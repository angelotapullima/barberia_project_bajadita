# Plan de Refactorización Detallado (v2) - Fase 1: Caja e Inventario

## 🎯 Objetivo Principal

Implementar un sistema robusto y desacoplado para el control financiero (Caja) y de stock (Inventario), basado en un modelo de "ledger" (libro de movimientos). Este plan es una versión más detallada que incluye la **eliminación explícita de tablas y campos obsoletos**.

---

## 🏛️ Sección 1: Modificaciones en la Base de Datos (SQL)

### Paso 1.1: Deprecación y Eliminación de Estructuras Antiguas

El objetivo es eliminar tablas y campos que son redundantes o que serán reemplazados por el nuevo modelo de ledgers, simplificando la base de datos.

- **Acción 1: Eliminar la columna `stock_quantity` de `inventory_items`.**
  - **Justificación:** Este es el cambio más importante para adoptar un sistema de ledger. El stock real siempre se calculará a partir de la suma de `inventory_movements`, eliminando la posibilidad de inconsistencias.
  - **SQL:** `ALTER TABLE inventory_items DROP COLUMN stock_quantity;`

- **Acción 2: Eliminar las tablas `purchases` y `purchase_details`.**
  - **Justificación:** Estas tablas son un modelo de compras "legacy". Las tablas `acquisitions` y `acquisition_lines` son más completas y se alinean mejor con el nuevo sistema. Centralizaremos todas las entradas de stock en el modelo de `acquisitions`.
  - **SQL:** `DROP TABLE IF EXISTS purchases, purchase_details CASCADE;`

- **Acción 3: Eliminar la tabla `disposals`.**
  - **Justificación:** La funcionalidad de esta tabla (registrar bajas de inventario) será absorbida por la tabla `inventory_movements` usando un tipo de movimiento específico como `DISPOSAL` o `WASTE`. Esto centraliza todos los cambios de stock en un único libro de movimientos.
  - **SQL:** `DROP TABLE IF EXISTS disposals CASCADE;`

- **Acción 4: Eliminar las tablas `barber_advances` y `barber_commissions`.**
  - **Justificación:** Ambos son conceptos puramente financieros. Serán reemplazados por registros en la nueva tabla `financial_movements`. Un adelanto será un movimiento de tipo `EXPENSE` (o `ADVANCE`) y el pago de comisiones también. Esto unifica todo el historial financiero en un solo lugar.
  - **SQL:** `DROP TABLE IF EXISTS barber_advances, barber_commissions CASCADE;`

- **Nota sobre `product_recipes` y `T_BAR_BUNDLES`:**
  - Estas tablas manejan lógica de negocio compleja (productos compuestos y combos). Para simplificar la Fase 1 y enfocarnos en el núcleo transaccional, propongo **desactivar su lógica temporalmente**. Las tablas pueden permanecer pero no las usaremos en esta fase. Las re-integraremos en una fase posterior una vez que el nuevo sistema de inventario y caja sea estable.

### Paso 1.2: Creación de la Nueva Estructura Financiera (Caja)

(Esta sección permanece igual, pero ahora se entiende que reemplaza a las tablas eliminadas).

- **Acción 1: Crear ENUMs para tipos de movimiento.**
  ```sql
  CREATE TYPE financial_movement_type AS ENUM ('INCOME', 'EXPENSE', 'TRANSFER', 'OWNER_WITHDRAWAL', 'INITIAL');
  -- Para el ledger de inventario, podemos refinar el tipo existente:
  CREATE TYPE inventory_movement_type AS ENUM ('PURCHASE', 'SALE', 'INTERNAL_CONSUMPTION', 'ADJUSTMENT', 'INITIAL_STOCK', 'WASTE');
  ```

- **Acción 2: Crear `financial_accounts`.**
  ```sql
  CREATE TABLE financial_accounts (
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL UNIQUE,
      type TEXT NOT NULL, -- 'CASH', 'DIGITAL_WALLET', 'BANK_ACCOUNT'
      description TEXT,
      is_active BOOLEAN DEFAULT TRUE,
      created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
  );
  ```

- **Acción 3: Crear `cash_box_sessions`.**
  ```sql
  CREATE TABLE cash_box_sessions (
      id SERIAL PRIMARY KEY,
      user_id INT NOT NULL REFERENCES users(id),
      account_id INT NOT NULL REFERENCES financial_accounts(id), -- A qué cuenta pertenece la sesión (ej. Caja Principal)
      start_amount REAL NOT NULL,
      end_amount REAL,
      system_end_amount REAL,
      discrepancy REAL,
      notes TEXT,
      started_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
      ended_at TIMESTAMPTZ
  );
  ```

- **Acción 4: Crear `financial_movements` (Libro Contable).**
  ```sql
  CREATE TABLE financial_movements (
      id SERIAL PRIMARY KEY,
      account_id INT NOT NULL REFERENCES financial_accounts(id),
      session_id INT REFERENCES cash_box_sessions(id) ON DELETE SET NULL,
      amount REAL NOT NULL,
      type financial_movement_type NOT NULL,
      description TEXT NOT NULL,
      reference_id INT,
      reference_type TEXT, -- 'SALE', 'ACQUISITION', etc.
      created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
  );
  ```

### Paso 1.3: Ajustes a Tablas Existentes

- **Acción 1: Modificar `inventory_movements`.**
  - **Propósito:** Asegurar que sea un ledger completo y robusto.
  - **Cambio:** Usar el nuevo `inventory_movement_type` y estandarizar las referencias.
    ```sql
    -- Potencial ALTER TABLE para usar el nuevo ENUM y asegurar consistencia
    ALTER TABLE inventory_movements ALTER COLUMN movement_type TYPE inventory_movement_type USING movement_type::inventory_movement_type;
    ```

- **Acción 2: Modificar `acquisitions`.**
  - **Propósito:** Integrarla con el sistema financiero.
  - **Cambio:** Añadir `status` ('PENDING', 'PAID') y `payment_account_id`.
    ```sql
    ALTER TABLE acquisitions ADD COLUMN status TEXT NOT NULL DEFAULT 'PENDING';
    ALTER TABLE acquisitions ADD COLUMN payment_account_id INT REFERENCES financial_accounts(id);
    ```

---

## ⚙️ Sección 2 y 3: Refactorización del Backend y API

(El plan detallado para el backend y los endpoints sigue siendo el mismo que en el documento anterior, pero ahora se entiende que operará sobre esta nueva estructura de base de datos más limpia y enfocada).

---

## 🚀 Sección 4: Orden de Implementación Sugerido (Actualizado)

1.  **Backup de la Base de Datos Actual:** ¡El paso más importante!
2.  **Crear y Aplicar Script de Migración SQL:** Este script contendrá **todos** los `DROP`, `ALTER` y `CREATE TABLE` de la Sección 1.
3.  **Actualizar Modelos del Backend:** Reflejar la nueva estructura de la BD en el código.
4.  **Implementar Servicios de Caja:** Crear el `CashBoxService` y sus endpoints.
5.  **Refactorizar `AcquisitionService`:** Adaptarlo para que use la tabla `acquisitions` y genere los movimientos de inventario y finanzas correctamente.
6.  **Refactorizar `SaleService`:** Adaptarlo para que genere los movimientos de inventario y finanzas.
7.  **Desarrollar Vista de Caja (Frontend):** Crear la nueva UI.
8.  **Probar de Forma Exhaustiva:** Validar todos los flujos con la nueva arquitectura.

---

Este plan es significativamente más agresivo y claro respecto a la simplificación del sistema. Define un camino para modernizar la arquitectura, eliminar deuda técnica y construir sobre una base sólida.

**¿Este nivel de detalle y los cambios propuestos (incluyendo las eliminaciones) se alinean mejor con tu visión?**
