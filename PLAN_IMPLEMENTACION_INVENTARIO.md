# Plan de Implementación del Módulo de Inventario

## 1. Objetivo
Implementar un módulo de inventario completo y funcional, siguiendo las directrices y la estructura detallada en el documento `inventario.md`. Este módulo permitirá una gestión granular de todos los ítems que posee la barbería, incluyendo materias primas, suministros consumibles, activos operacionales y productos de venta al por menor, así como un control exhaustivo de su adquisición, movimientos y bajas.

## 2. Fases de Implementación

### Fase 1: Base de Datos y Modelos (Backend)

**Descripción:** Modificación del esquema de la base de datos para incorporar las nuevas tablas y campos definidos en `inventario.md`, y actualización de los modelos TypeScript correspondientes.

**Pasos:**
1.  **Actualizar `barberia_project_backend/src/database/db.sql`:**
    *   Eliminar la tabla `inventory_items` existente.
    *   Añadir las nuevas tablas:
        *   `unit_types`
        *   `item_categories`
        *   `inventory_items` (con la nueva estructura: `sku`, `item_type`, `category_id`, `unit_id`, `min_stock`, `is_trackable`, `is_active`)
        *   `acquisitions`
        *   `acquisition_lines`
        *   `inventory_movements` (con el `movement_kind` ENUM)
        *   `locations`
        *   `disposals`
    *   Modificar `menu_products` para eliminar `inventory_item_id` y `category` (si se usará `item_categories` para esto).
    *   Modificar `product_recipes` para asegurar que referencia a la nueva `inventory_items`.
    *   Añadir la vista `v_inventory_stock`.

2.  **Generar Script de Migración para Producción:**
    *   Crear un script SQL (`.sql`) que contenga las sentencias `ALTER TABLE`, `CREATE TABLE`, `CREATE TYPE`, `CREATE VIEW` necesarias para aplicar estos cambios a una base de datos existente sin perder datos. Este script debe ser cuidadosamente revisado y probado.

3.  **Actualizar Modelos TypeScript (`barberia_project_backend/src/models/`):**
    *   Modificar `inventoryItem.model.ts` para reflejar la nueva estructura de la tabla `inventory_items`.
    *   Crear nuevos modelos TypeScript para:
        *   `UnitType.model.ts`
        *   `ItemCategory.model.ts`
        *   `Acquisition.model.ts`
        *   `AcquisitionLine.model.ts`
        *   `InventoryMovement.model.ts`
        *   `Location.model.ts`
        *   `Disposal.model.ts`
    *   Actualizar `menuProduct.model.ts` si es necesario.

4.  **Actualizar Controladores y Servicios (Backend):**
    *   Modificar `inventory.controller.ts`, `inventoryItem.controller.ts`, `inventory.service.ts`, `inventoryItem.service.ts` para adaptarse a la nueva estructura de datos.
    *   Crear nuevos controladores y servicios para `unit_types`, `item_categories`, `acquisitions`, `acquisition_lines`, `inventory_movements`, `locations`, `disposals` según sea necesario para la gestión CRUD.

### Fase 2: Interfaz de Usuario (Frontend)

**Descripción:** Adaptación de las vistas y componentes existentes, y creación de nuevas interfaces para gestionar el inventario según la nueva estructura.

**Pasos:**
1.  **Refactorizar `InventoryView.vue`:**
    *   Implementar un sistema de pestañas o filtros robusto para navegar entre los diferentes tipos de ítems de inventario (`RAW_MATERIAL`, `CONSUMABLE_SUPPLY`, `OPERATIONAL_ASSET`, `RETAIL_PRODUCT`) y categorías personalizadas (`item_categories`).
    *   Integrar la visualización de `v_inventory_stock` para mostrar el stock actual.

2.  **Actualizar `InventoryItemsTable.vue`:**
    *   Ajustar las columnas y la información mostrada dinámicamente según el `item_type` o la `category` seleccionada.
    *   Mostrar `sku`, `unit`, `min_stock`, `is_trackable`, etc.

3.  **Actualizar `InventoryItemFormModal.vue`:**
    *   Añadir un selector para `item_type` (`consumible`, `producto`, `activo`).
    *   Añadir un selector para `category_id` (basado en `item_categories`).
    *   Añadir un selector para `unit_id` (basado en `unit_types`).
    *   Implementar renderizado condicional de campos de formulario (ej. `location`, `condition`, `acquisition_date`, `acquisition_cost` para activos) según el `item_type` seleccionado.
    *   Añadir campos para `initial_acquisition_type` y `supplier_id` (si aplica).

4.  **Gestión de Adquisiciones:**
    *   Crear una nueva vista (`AcquisitionsView.vue`) y componentes (`AcquisitionFormModal.vue`, `AcquisitionLinesTable.vue`) para gestionar las adquisiciones.
    *   Permitir la selección de `acquisition_type` (`compra`, `donacion`, `traslado`, `cost_zero`).
    *   Integrar la selección de `supplier_id` y la entrada de `document_ref`.
    *   Permitir añadir `acquisition_lines` vinculando `inventory_item_id`, `unit_price` y `quantity`.

5.  **Gestión de Bajas/Jubilaciones:**
    *   Crear una nueva vista (`DisposalsView.vue`) y componentes (`DisposalFormModal.vue`) para registrar las bajas de ítems de inventario, especialmente activos.
    *   Permitir seleccionar `disposal_type` y añadir `notes`.

6.  **Gestión de Movimientos de Inventario:**
    *   Crear una vista (`InventoryMovementsView.vue`) para visualizar el historial de `inventory_movements` de un ítem específico o de todo el inventario.
    *   Posiblemente, un componente para realizar ajustes manuales (`adjustment` movement_kind).

### Fase 3: Lógica de Negocio e Integración

**Descripción:** Implementación de la lógica central para el manejo de stock, recetas y la integración con otros módulos.

**Pasos:**
1.  **Gestión de Recetas (`product_recipes`):**
    *   Implementar la funcionalidad en el backend y frontend para definir y gestionar las recetas de los `menu_products`, especificando los `inventory_items` y `quantity` necesarios.

2.  **Generación Automática de Movimientos de Inventario:**
    *   **Ventas:** Modificar el proceso de venta para que, al vender un `menu_product` con receta, se generen automáticamente movimientos `out` en `inventory_movements` para los `inventory_items` consumidos.
    *   **Adquisiciones:** Al registrar una `acquisition`, generar automáticamente movimientos `in` en `inventory_movements` para los `inventory_items` adquiridos.
    *   **Bajas:** Al registrar una `disposal`, generar automáticamente movimientos `out` en `inventory_movements` para el `inventory_item` dado de baja.

3.  **Uso de `v_inventory_stock`:**
    *   Asegurar que todas las consultas de stock en el backend y frontend utilicen la vista `v_inventory_stock` para obtener el stock actual de manera precisa.

4.  **Alertas de Stock Mínimo:**
    *   Implementar lógica en el backend (y posiblemente en el frontend) para generar alertas cuando el stock de un `inventory_item` caiga por debajo de su `min_stock`.

### Fase 4: Pruebas y Despliegue

**Descripción:** Asegurar la calidad y funcionalidad del nuevo módulo.

**Pasos:**
1.  **Pruebas Unitarias:** Escribir y ejecutar pruebas unitarias exhaustivas para todos los nuevos servicios, controladores y modelos del backend.
2.  **Pruebas de Integración:** Realizar pruebas de integración para verificar la interacción entre los diferentes componentes del módulo de inventario y con otros módulos existentes (ej. ventas, compras).
3.  **Pruebas de Aceptación (UAT):** Realizar pruebas con usuarios finales para asegurar que el módulo cumple con los requisitos de negocio y la experiencia de usuario esperada.
4.  **Documentación:** Actualizar la documentación técnica y de usuario para reflejar los cambios en el módulo de inventario.
5.  **Despliegue:** Planificar y ejecutar el despliegue del nuevo módulo en los entornos de staging y producción.