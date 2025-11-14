# Plan de Implementación Detallado: Módulos de Inventario y Compras

## 1. Introducción

Este documento describe el plan técnico detallado para implementar las funcionalidades de gestión de inventario, compras, productos derivados, consumo de insumos y combos, unificando los requisitos de los documentos `PLAN_MODULO_COMPRAS.md` y `PLAN_IMPLEMENTACION_INVENTARIO.md`.

El plan se divide en cuatro fases principales:
1.  **Modificaciones a la Base de Datos**: Añadir las tablas necesarias para soportar la nueva funcionalidad.
2.  **Desarrollo del Backend (API)**: Implementar la lógica de negocio en los servicios y controladores.
3.  **Desarrollo del Frontend (UI)**: Crear y modificar las interfaces de usuario para gestionar las nuevas características.
4.  **Actualización de Documentación**: Reflejar los cambios en los documentos de diseño del proyecto.

---

## 2. Fase 1: Modificaciones a la Base de Datos

### Objetivo
Ampliar el esquema de la base de datos para dar soporte al consumo de insumos por servicio y a la creación de combos/paquetes de venta. **Las nuevas tablas adoptarán la convención de nombres `T_BAR_[NOMBRE_TABLA]`**.

### Script de Migración (SQL)
Se debe crear y ejecutar un nuevo script de migración con el siguiente contenido, que ya incluye la nueva convención de nombres para las tablas nuevas y referencias a las tablas existentes con sus nombres originales.

```sql
-- ARCHIVO: barberia_project_backend/src/database/migrations/001_add_inventory_features.sql

-- 1. Tabla para registrar los insumos que consume cada servicio
CREATE TABLE IF NOT EXISTS T_BAR_SERVICE_SUPPLIES (
    id SERIAL PRIMARY KEY,
    service_id INT NOT NULL REFERENCES services(id) ON DELETE CASCADE,
    inventory_item_id INT NOT NULL REFERENCES inventory_items(id) ON DELETE RESTRICT,
    quantity_used REAL NOT NULL,
    -- Restricción para evitar duplicados
    CONSTRAINT unique_service_supply UNIQUE (service_id, inventory_item_id)
);

-- 2. Tabla para definir los combos o paquetes de venta
CREATE TABLE IF NOT EXISTS T_BAR_BUNDLES (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    price REAL NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabla de detalle para los ítems que componen un combo
CREATE TABLE IF NOT EXISTS T_BAR_BUNDLE_ITEMS (
    id SERIAL PRIMARY KEY,
    bundle_id INT NOT NULL REFERENCES T_BAR_BUNDLES(id) ON DELETE CASCADE,
    item_type TEXT NOT NULL, -- 'service' o 'menu_product'
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    -- Precio interno para el desglose. Clave para el cálculo de comisiones.
    internal_price REAL NOT NULL,
    -- Agrupa ítems que son una elección para el usuario (ej: 'bebida_a_elegir', 'postre_opcional')
    choice_group TEXT NULL
);

-- Comentario de la migración
COMMENT ON TABLE T_BAR_SERVICE_SUPPLIES IS 'Registra los materiales y cantidades que consume cada servicio. Ej: 1 corte de cabello consume 0.5 navajas.';
COMMENT ON TABLE T_BAR_BUNDLES IS 'Define los paquetes promocionales que agrupan servicios y/o productos a un precio especial.';
COMMENT ON TABLE T_BAR_BUNDLE_ITEMS IS 'Detalla los componentes de un paquete, incluyendo su precio interno para comisiones y si forman parte de un grupo de elección.';

```

### Justificación de las Nuevas Tablas

*   **`T_BAR_SERVICE_SUPPLIES`**: Conectará `services` con `inventory_items` para automatizar el descuento de stock por consumo en servicios.
*   **`T_BAR_BUNDLES`**: Será la cabecera de un combo, definiendo su nombre, precio de venta y estado.
*   **`T_BAR_BUNDLE_ITEMS`**: Es el corazón de los combos.
    *   `internal_price`: Permite asignar un valor a cada componente para el cálculo de comisiones.
    *   `choice_group`: Permite agrupar productos para que el cliente elija uno.

---

## 3. Fase 2: Desarrollo del Backend (API)

### Objetivo
Implementar la lógica de negocio que gestiona el ciclo de vida del inventario y las compras, **haciendo referencia a las tablas existentes con sus nombres originales y a las nuevas tablas con el prefijo `T_BAR_`**.

### Modificaciones al Módulo de Compras (`/api/purchases`)

*   **`POST /api/purchases`**: El servicio `PurchaseService` debe ser modificado.
    1.  Al recibir una nueva compra con sus `purchase_details`.
    2.  Para cada `detail`, verificar el `item_type`:
        *   Si es `'service_supply'` o `'sale_product'`:
            1.  Obtener el `inventory_item` usando el `reference_id`.
            2.  Actualizar `inventory_items` incrementando el `stock_quantity`.
            3.  Crear un registro en `inventory_movements` (`movement_type = 'in_purchase'`, `quantity` = cantidad comprada).
        *   Si es `'asset_expense'`: No se realiza ninguna acción sobre el inventario.

### Modificaciones al Módulo de Ventas (POS) (`/api/sales`)

*   **`POST /api/sales`**: El servicio `SaleService` debe ser refactorizado para manejar el descuento de inventario.

    *   **Caso 1: Venta de un Servicio (`item_type: 'service'`)**
        1.  Buscar en `T_BAR_SERVICE_SUPPLIES` todos los insumos asociados al `service_id`.
        2.  Para cada insumo encontrado, disminuir el `stock_quantity` del `inventory_items` correspondiente.
        3.  Crear un registro en `inventory_movements` por cada insumo (`movement_type = 'out_service_consumption'`).

    *   **Caso 2: Venta de un Producto de Venta Directa (`item_type: 'product'`)**
        1.  Buscar el `menu_product` en `menu_products` y obtener su `inventory_item_id` asociado.
        2.  Disminuir el `stock_quantity` de ese `inventory_items`.
        3.  Crear un registro en `inventory_movements` (`movement_type = 'out_sale'`).

    *   **Caso 3: Venta de un Producto Derivado/Preparado (`item_type: 'product'`)**
        1.  Verificar si el `menu_product` tiene una receta en `product_recipes`.
        2.  Si existe, iterar sobre cada `inventory_item_id` (ingrediente) de la receta.
        3.  Disminuir el `stock_quantity` de cada ingrediente en `inventory_items`.
        4.  Crear un registro en `inventory_movements` por cada ingrediente consumido (`movement_type = 'out_production'`).

    *   **Caso 4: Venta de un Combo (`item_type: 'bundle'`)**
        1.  El frontend enviará el `bundle_id` y las elecciones del cliente (si las hay).
        2.  El backend buscará en `T_BAR_BUNDLE_ITEMS` todos los componentes del `bundle_id`.
        3.  Para cada componente (servicio o producto), ejecutará la lógica de descuento de stock correspondiente (Casos 1, 2 o 3).
        4.  El servicio de comisiones deberá usar el `internal_price` del componente de servicio para el cálculo, no el precio total del combo.

### Nuevos Endpoints de Gestión

Se deben crear los siguientes endpoints CRUD para administrar la nueva funcionalidad desde el frontend:

*   **Gestión de Combos**:
    *   `GET /api/bundles`
    *   `GET /api/bundles/:id`
    *   `POST /api/bundles`
    *   `PUT /api/bundles/:id`
    *   `DELETE /api/bundles/:id`
*   **Gestión de Insumos por Servicio**:
    *   `GET /api/services/:id/supplies`
    *   `POST /api/services/:id/supplies` (Para añadir un insumo)
    *   `DELETE /api/services/:id/supplies/:supply_id` (Para quitar un insumo)

---

## 4. Fase 3: Desarrollo del Frontend (UI)

### Objetivo
Crear y adaptar las interfaces de usuario para que la gestión de las nuevas funcionalidades sea intuitiva.

### Nuevas Vistas y Rutas

*   **`'/admin/bundles'`**:
    *   **Componente Principal**: `BundlesView.vue`.
    *   **Funcionalidad**: Mostrar una tabla con todos los combos creados. Permitirá editar, activar/desactivar y eliminar. Un botón "Crear Combo" llevará al formulario.
*   **`'/admin/bundles/new'` y `'/admin/bundles/edit/:id'`**:
    *   **Componente Principal**: `BundleForm.vue`.
    *   **Funcionalidad**: Formulario para definir el nombre, descripción y precio del combo. Incluirá una sección dinámica para añadir/quitar `bundle_items` (servicios o productos), especificando su `internal_price` y `choice_group`.
*   **`'/admin/purchases'`**:
    *   **Componente Principal**: `PurchasesView.vue`.
    *   **Funcionalidad**: Vista para registrar y consultar compras, similar a la de ventas.

### Modificaciones a Vistas Existentes

*   **Formulario de Servicios (`/admin/services/edit/:id`)**:
    *   **Componente a modificar**: `ServiceForm.vue`.
    *   **Cambio**: Añadir una nueva sección "Insumos Requeridos". Será una tabla donde el usuario puede seleccionar un `inventory_item` de una lista y especificar la `quantity_used`. Se podrá añadir o quitar insumos dinámicamente.

*   **Formulario de Productos (`/admin/menu-products/edit/:id`)**:
    *   **Componente a modificar**: `MenuProductForm.vue`.
    *   **Cambio**: Mejorar el formulario para que sea más claro cómo definir un producto:
        1.  **Tipo de Producto**: Un selector para elegir "Venta Directa", "Preparado/Derivado" o "Insumo simple".
        2.  Si es "Venta Directa", se mostrará un campo para asociarlo a un único `inventory_item`.
        3.  Si es "Preparado/Derivado", se mostrará una sección para definir la receta (similar a la de insumos de servicios).

*   **Punto de Venta (POS) (`/pos`)**:
    *   **Componente a modificar**: `POSView.vue` o similar.
    *   **Cambio**:
        1.  La lista de productos a la venta debe incluir los `bundles` activos.
        2.  Al hacer clic en un combo que contenga un `choice_group`, se debe disparar un modal (`ChoiceModal.vue`) que muestre los productos elegibles para que el cajero seleccione el que el cliente pidió. La selección se enviará a la API al cerrar la venta.

---

## 5. Fase 4: Actualización de Documentación

### Objetivo
Mantener la documentación del proyecto sincronizada con los cambios en el código.

### Tareas

1.  **Actualizar `barberia_project_backend/design-doc-backend.md`**:
    *   Añadir el nuevo diagrama de entidad-relación de la base de datos.
    *   Documentar los nuevos endpoints (`/bundles`, `/services/:id/supplies`).
    *   Describir en detalle la nueva lógica de negocio en `SaleService` y `PurchaseService`.

2.  **Actualizar `barberia_project_frontend/design-doc-frontend.md`**:
    *   Añadir wireframes o descripciones de las nuevas vistas (`BundlesView`, `BundleForm`).
    *   Describir las modificaciones realizadas a los formularios de servicios, productos y la vista del POS.
