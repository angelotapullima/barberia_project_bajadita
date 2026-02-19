# Plan de Refactorización Detallado (v3) - Fase 1: Caja, Inventario y Combos

## 🎯 Objetivo Principal

Implementar un sistema robusto y desacoplado para el control financiero (Caja) y de stock (Inventario), basado en un modelo de "ledger" (libro de movimientos). **Esta versión incluye la gestión de Combos (Bundles) como un requisito central de la Fase 1.**

---

## 🏛️ Sección 1: Modificaciones en la Base de Datos (SQL)

### Paso 1.1: Deprecación y Eliminación de Estructuras Antiguas

El objetivo es eliminar tablas y campos que son redundantes o que serán reemplazados por el nuevo modelo, simplificando la base de datos.

- **Acción 1: Eliminar la columna `stock_quantity` de `inventory_items`.**
  - **Justificación:** El stock se calculará siempre a partir de la suma de `inventory_movements`, eliminando inconsistencias.
  - **SQL:** `ALTER TABLE inventory_items DROP COLUMN stock_quantity;`

- **Acción 2: Eliminar las tablas `purchases` y `purchase_details`.**
  - **Justificación:** Reemplazadas por el modelo de `acquisitions` y `acquisition_lines`, que es más completo.
  - **SQL:** `DROP TABLE IF EXISTS purchases, purchase_details CASCADE;`

- **Acción 3: Eliminar la tabla `disposals`.**
  - **Justificación:** Su funcionalidad es absorbida por `inventory_movements` con un tipo de movimiento `DISPOSAL`, centralizando todos los cambios de stock.
  - **SQL:** `DROP TABLE IF EXISTS disposals CASCADE;`

- **Acción 4: Eliminar las tablas `barber_advances` y `barber_commissions`.**
  - **Justificación:** Serán reemplazadas por registros en `financial_movements`, unificando el historial financiero.
  - **SQL:** `DROP TABLE IF EXISTS barber_advances, barber_commissions CASCADE;`

### Paso 1.2: Tablas a Conservar e Integrar

- **Acción: Confirmar la conservación de las tablas de Combos (Bundles).**
  - **Justificación:** Los combos son un requisito clave del negocio. Las tablas `T_BAR_BUNDLES` y `T_BAR_BUNDLE_ITEMS` se conservarán y se integrarán en el nuevo flujo de ventas.
  - **Tablas:** `T_BAR_BUNDLES`, `T_BAR_BUNDLE_ITEMS`.

### Paso 1.3: Creación de la Nueva Estructura Financiera (Caja)

(Idéntico a la v2, pero se presenta en el contexto de las eliminaciones y conservaciones ya mencionadas).

- **Acción 1: Crear ENUMs.**
  ```sql
  CREATE TYPE financial_movement_type AS ENUM ('INCOME', 'EXPENSE', 'TRANSFER', 'OWNER_WITHDRAWAL', 'INITIAL');
  CREATE TYPE inventory_movement_type AS ENUM ('PURCHASE', 'SALE', 'INTERNAL_CONSUMPTION', 'ADJUSTMENT', 'INITIAL_STOCK', 'WASTE');
  ```
- **Acción 2: Crear `financial_accounts`.**
  ```sql
  CREATE TABLE financial_accounts (
      id SERIAL PRIMARY KEY, name TEXT NOT NULL UNIQUE, type TEXT NOT NULL, description TEXT, is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
  );
  ```
- **Acción 3: Crear `cash_box_sessions`.**
  ```sql
  CREATE TABLE cash_box_sessions (
      id SERIAL PRIMARY KEY, user_id INT NOT NULL REFERENCES users(id), account_id INT NOT NULL REFERENCES financial_accounts(id), start_amount REAL NOT NULL, end_amount REAL, system_end_amount REAL, discrepancy REAL, notes TEXT, started_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, ended_at TIMESTAMPTZ
  );
  ```
- **Acción 4: Crear `financial_movements` (Libro Contable).**
  ```sql
  CREATE TABLE financial_movements (
      id SERIAL PRIMARY KEY, account_id INT NOT NULL REFERENCES financial_accounts(id), session_id INT REFERENCES cash_box_sessions(id) ON DELETE SET NULL, amount REAL NOT NULL, type financial_movement_type NOT NULL, description TEXT NOT NULL, reference_id INT, reference_type TEXT, created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
  );
  ```

### Paso 1.4: Ajustes a Tablas Existentes

- **Acción: Modificar `acquisitions`.**
  - **Cambio:** Añadir `status` ('PENDING', 'PAID') y `payment_account_id`.
    ```sql
    ALTER TABLE acquisitions ADD COLUMN status TEXT NOT NULL DEFAULT 'PENDING';
    ALTER TABLE acquisitions ADD COLUMN payment_account_id INT REFERENCES financial_accounts(id);
    ```

---

## ⚙️ Sección 2: Refactorización del Backend (API)

### Paso 2.1: Actualizar Modelos de Datos

- **Nuevos:** `FinancialAccount`, `CashBoxSession`, `FinancialMovement`.
- **Modificados:** `InventoryItem` (sin `stock_quantity`), `Acquisition` (con `status`, `payment_account_id`).
- **Conservados:** `Bundle`, `BundleItem`.

### Paso 2.2: Crear `CashBoxService`
(Sin cambios respecto al plan v2. Responsable de abrir/cerrar sesión, registrar gastos, etc.)

### Paso 2.3: Refactorizar `SaleService` (¡Punto Clave!)

El servicio de ventas debe manejar la venta de productos, servicios y **combos**.

- **Modificar `createDirectSale(saleData)`:**
  1.  Guardar la `sale` y sus `sale_items`.
  2.  **Generar movimiento financiero:** Crear **un único** `financial_movements` de tipo `INCOME` por el `total_amount` de la venta. (Esto no cambia).
  3.  **Generar movimientos de inventario (Lógica expandida):** Iterar sobre cada `sale_item`:
      - **Si `item_type` es 'product':**
        - Crear un `inventory_movements` para rebajar el stock de ese `inventory_item_id`.
      - **Si `item_type` es 'bundle':**
        - Consultar la tabla `T_BAR_BUNDLE_ITEMS` para obtener todos los productos y servicios que componen ese combo (`bundle`).
        - Iterar sobre los componentes del combo.
        - Por **cada componente que sea un producto** (`item_type = 'menu_product'`), buscar su `inventory_item_id` correspondiente y crear un `inventory_movements` para rebajar su stock.
        - Los componentes de tipo 'service' del combo no generan movimiento de inventario.
      - **Si `item_type` es 'service':**
        - No se genera movimiento de inventario en esta fase (el consumo de insumos se abordará en la Fase 2).

### Paso 2.4: Refactorizar `AcquisitionService`
(Sin cambios respecto al plan v2. Debe generar movimientos de inventario y, si se paga, de finanzas).

---

## 🔌 Sección 3 y 4: API y Orden de Implementación

(Los endpoints y el orden de implementación sugerido en la v2 siguen siendo válidos, con la adición crucial de que el `SaleService` debe ser probado exhaustivamente con casos de venta de productos simples y combos complejos).

---

Este plan v3 es completo e integra los combos como un requisito fundamental desde el inicio. Es la hoja de ruta que seguiremos.

**Ahora sí, ¿estamos listos para empezar con este plan?**
