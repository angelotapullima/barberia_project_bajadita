# Plan de Implementación: Sistema de Gestión de Inventario y Compras

Este documento detalla el plan para implementar un sistema robusto de gestión de inventario y compras, aprovechando las estructuras de base de datos existentes y extendiendo la funcionalidad del frontend y backend.

## Visión General

El objetivo es separar claramente los "productos del menú" (lo que se vende al cliente) de los "items de inventario" (insumos y productos físicos gestionados por stock). Se implementarán movimientos de inventario, un sistema de compras, alertas de stock y una integración con las ventas para el consumo automático de inventario.

**Referencias de Diseño (Dribbble):**
*   [Ecomiq SaaS E-Commerce Inventory Management](https://dribbble.com/shots/25782378-Ecomiq-SaaS-E-Commerce-Inventory-Management)
*   [Ecomiq Product Details - Inventory for SaaS E-Commerce](https://dribbble.com/shots/26618048-Ecomiq-Product-Details-Inventory-for-SaaS-E-Commerce)

---

## Análisis de Estructuras Existentes

La base de datos actual ya cuenta con una excelente base para este sistema:

*   **`inventory_items`**: Tabla existente con `stock_quantity`, `min_stock_level`, `unit`, `category`.
*   **`inventory_movements`**: Tabla existente con `movement_type` ('in', 'out', 'adjustment'), `quantity`, `reference_id`.
*   **`menu_products`**: Tabla existente con `product_type` ('direct_sale', 'derived') y `inventory_item_id` para productos de venta directa.
*   **`product_recipes`**: Tabla existente para definir los insumos (`inventory_items`) que consume un `menu_product` de tipo 'derived'.
*   **`T_BAR_SERVICE_SUPPLIES`**: Tabla existente para definir los insumos (`inventory_items`) que consume un `service`.
*   **`suppliers`**: Tabla existente.
*   **`purchases`**: Tabla existente para órdenes de compra (cabecera).
*   **`purchase_details`**: Tabla existente para los ítems de una orden de compra, con `reference_id` para vincular a `inventory_items`.

---

## Plan de Implementación por Fases

### Fase 1: Backend - Core Inventory Management (Movimientos y Stock)

**Objetivo:** Establecer la lógica central para registrar y gestionar los movimientos de inventario y mantener el stock actualizado.

*   **Tareas:**
    *   **`inventory.service.ts`**:
        *   Crear una función `recordInventoryMovement(movementData: InventoryMovement)` que inserte un registro en `inventory_movements`.
        *   Crear una función `updateInventoryStock(itemId: number, quantityChange: number)` que actualice `inventory_items.stock_quantity`.
        *   Integrar estas funciones para que cada `recordInventoryMovement` dispare `updateInventoryStock`.
    *   **Lógica de Alertas de Stock:**
        *   Desarrollar una función (posiblemente en `inventory.service.ts`) para identificar `inventory_items` cuyo `stock_quantity` esté por debajo de `min_stock_level`.
        *   Considerar un endpoint para consultar estos ítems con bajo stock.

### Fase 2: Backend - Sistema de Compras

**Objetivo:** Implementar la lógica para procesar órdenes de compra y su impacto en el inventario.

*   **Tareas:**
    *   **`purchases.service.ts`**:
        *   Mejorar las funciones de creación y actualización de `purchases` y `purchase_details`.
        *   Crear una función `processPurchaseReception(purchaseId: number)`:
            *   Cambiar el `status` de la `purchase` a 'Received'.
            *   Iterar sobre los `purchase_details` de esa compra.
            *   Para cada `purchase_detail` que referencia un `inventory_item` (usando `reference_id` y `item_type`), llamar a `recordInventoryMovement` con `movement_type: 'in'` y la `quantity` correspondiente, vinculando `reference_id` al `purchase_id`.

### Fase 3: Frontend - Interfaz de Gestión de Items de Inventario (CRUD y Vista de Stock)

**Objetivo:** Proporcionar una interfaz completa para la gestión de los items de inventario.

*   **Tareas:**
    *   **Nueva Vista (`InventoryView.vue`):**
        *   Crear la estructura básica de la vista.
        *   Utilizar `inventoryItemStore` (o crear uno si no existe) para gestionar el estado de los `inventory_items`.
        *   Mostrar una tabla paginada y con búsqueda de `inventory_items` (similar a `BundlesView.vue` o `ServicesView.vue`).
        *   Columnas: Nombre, Descripción, Stock Actual, Stock Mínimo, Unidad, Categoría, Acciones.
    *   **CRUD para `inventory_items`:**
        *   Implementar modales o formularios para añadir y editar `inventory_items`.
        *   Funcionalidad para "eliminar" (marcar como inactivo, no borrar físicamente).
    *   **Visualización de Stock y Alertas:**
        *   Resaltar visualmente los items con `stock_quantity < min_stock_level`.
        *   Mostrar el `stock_quantity` y `min_stock_level`.
    *   **Historial de Movimientos:**
        *   Al seleccionar un `inventory_item`, mostrar un modal o sección expandible con su historial de `inventory_movements`.

### Fase 4: Frontend - Interfaz de Gestión de Compras

**Objetivo:** Permitir la creación y gestión de órdenes de compra.

*   **Tareas:**
    *   **Nueva Vista (`PurchaseOrdersView.vue`):**
        *   Crear la estructura básica de la vista.
        *   Utilizar `purchaseStore` (o crear uno) para gestionar el estado de las `purchases`.
        *   Mostrar una tabla paginada y con búsqueda de `purchases`.
        *   Columnas: Proveedor, Fecha de Compra, Total, Estado, Acciones.
    *   **CRUD para `purchases`:**
        *   Implementar modales o formularios para crear y editar `purchases` y sus `purchase_details`.
        *   Selector de `suppliers` y `inventory_items` para los `purchase_details`.
    *   **UI de Recepción:**
        *   Un botón o acción para "Recibir Compra" que llame a la función `processPurchaseReception` del backend.

### Fase 5: Integración con Productos de Menú y Ventas

**Objetivo:** Automatizar el consumo de inventario al registrar ventas.

*   **Tareas:**
    *   **`sale.service.ts` (Backend):**
        *   Modificar la función `createSale` (o similar) para que, después de registrar la venta, procese los `sale_items`.
        *   Para cada `sale_item` que sea un `menu_product`:
            *   **Si `menu_product.product_type` es 'direct_sale':**
                *   Obtener el `inventory_item_id` asociado.
                *   Llamar a `recordInventoryMovement` con `movement_type: 'out'`, `quantity: sale_item.quantity`, y `reference_id` a la `sale_id`.
            *   **Si `menu_product.product_type` es 'derived':**
                *   Obtener las `product_recipes` asociadas a ese `menu_product`.
                *   Para cada `product_recipe`, llamar a `recordInventoryMovement` con `movement_type: 'out'`, `quantity: product_recipe.quantity_used * sale_item.quantity`, y `reference_id` a la `sale_id`.
    *   **`service.service.ts` (Backend):**
        *   Modificar la función `completeReservationAndCreateSale` (o similar) para que, al vender un `service`, procese sus `T_BAR_SERVICE_SUPPLIES`.
        *   Para cada `T_BAR_SERVICE_SUPPLY` asociado al `service` vendido, llamar a `recordInventoryMovement` con `movement_type: 'out'`, `quantity: service_supply.quantity_used`, y `reference_id` a la `sale_id`.

---

Este plan detalla cómo construiremos el sistema de inventario y compras, aprovechando al máximo lo que ya tienes. ¿Te parece bien este enfoque?
