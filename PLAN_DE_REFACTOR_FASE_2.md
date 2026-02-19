# Plan de Refactorización Detallado - Fase 2: Consumo Interno y Centros de Costo

## 🎯 Objetivo Principal

Tras establecer una base financiera y de inventario sólida en la Fase 1, esta fase se centra en obtener inteligencia de negocio avanzada. Implementaremos el seguimiento del consumo de productos por parte de los barberos y la clasificación de todas las operaciones por Centros de Costo para un análisis de rentabilidad preciso.

**Requisito Previo:** Haber completado exitosamente la implementación de la Fase 1.

---

## 🏛️ Sección 1: Modificaciones en la Base de Datos (SQL)

Estos cambios añaden las capas de clasificación y seguimiento de costos operativos.

### Paso 1.1: Crear la Estructura de Centros de Costo

- **Acción 1: Crear la tabla `cost_centers`.**
  - **Propósito:** Define las diferentes unidades de negocio para clasificar ingresos y costos.
  ```sql
  CREATE TABLE cost_centers (
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL UNIQUE,
      description TEXT,
      created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
  );
  ```

- **Acción 2: Poblar la tabla con datos iniciales.**
  ```sql
  INSERT INTO cost_centers (name, description) VALUES
  ('Barbería', 'Ingresos y costos asociados a servicios de barbería.'),
  ('Venta de Productos', 'Ingresos y costos de la venta de productos de retail.'),
  ('Cafetería', 'Ingresos y costos asociados a la venta de bebidas y snacks.');
  ```

### Paso 1.2: Integrar Centros de Costo en el Modelo

- **Acción 1: Vincular `services` y `menu_products` a los centros de costo.**
  - **Propósito:** Cada vez que se venda un servicio o producto, debemos saber a qué unidad de negocio pertenece.
  ```sql
  ALTER TABLE services ADD COLUMN cost_center_id INT REFERENCES cost_centers(id);
  ALTER TABLE menu_products ADD COLUMN cost_center_id INT REFERENCES cost_centers(id);
  ```

- **Acción 2: Añadir `cost_center_id` a la tabla `sale_items`.**
  - **Propósito:** Desnormalizamos intencionadamente para "congelar" el centro de costo al momento de la venta, permitiendo análisis históricos precisos aunque un producto cambie de centro de costo en el futuro.
  ```sql
  ALTER TABLE sale_items ADD COLUMN cost_center_id INT REFERENCES cost_centers(id);
  ```

### Paso 1.3: Crear la Tabla de Consumo Interno

- **Acción: Crear la tabla `internal_consumptions`.**
  - **Propósito:** Registra cada vez que un barbero utiliza un producto del inventario para realizar un servicio. No es una venta ni un gasto financiero, es un **costo operativo**.
  ```sql
  CREATE TABLE internal_consumptions (
      id SERIAL PRIMARY KEY,
      barber_id INT NOT NULL REFERENCES barbers(id),
      inventory_item_id INT NOT NULL REFERENCES inventory_items(id),
      quantity REAL NOT NULL,
      cost_at_time REAL NOT NULL, -- "Congela" el costo del producto en ese momento
      consumption_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
      notes TEXT
  );
  ```

---

## ⚙️ Sección 2: Refactorización del Backend (API)

### Paso 2.1: Actualizar Modelos de Datos

- **Nuevos Modelos:** `CostCenter`, `InternalConsumption`.
- **Modelos Modificados:**
  - `Service`, `MenuProduct`, `SaleItem`: Añadir `cost_center_id`.

### Paso 2.2: Crear `InternalConsumptionService`

- **Propósito:** Centralizar la lógica de consumo de insumos.
- **Métodos a implementar:**
  - `recordConsumption(barberId, inventoryItemId, quantity)`:
    1.  Busca el `inventory_item` para obtener su costo actual (`cost_price` de `acquisition_lines` o un promedio).
    2.  Crea un nuevo registro en `internal_consumptions`, guardando el `cost_at_time`.
    3.  **Crea un movimiento de inventario:** Genera un registro en `inventory_movements` (tipo `INTERNAL_CONSUMPTION`, cantidad negativa) para rebajar el stock.

### Paso 2.3: Refactorizar `SaleService` para Usar Centros de Costo

- **Modificar `createDirectSale(saleData)`:**
  1.  Al procesar cada `sale_item` antes de guardarlo:
  2.  Si el `item_type` es 'service', busca el `service` correspondiente, obtén su `cost_center_id` y añádelo al objeto `sale_item`.
  3.  Si el `item_type` es 'product', busca el `menu_product` correspondiente, obtén su `cost_center_id` y añádelo al objeto `sale_item`.
  4.  Guarda el `sale_item` con su `cost_center_id`.

### Paso 2.4: Crear o Ampliar `ReportService`

- **Propósito:** Generar los nuevos análisis de negocio que esta estructura permite.
- **Métodos de ejemplo a implementar:**
  - `getRevenueByCostCenter(startDate, endDate)`:
    - `SELECT cc.name, SUM(si.total_price) FROM sale_items si JOIN cost_centers cc ON si.cost_center_id = cc.id WHERE si.created_at BETWEEN startDate AND endDate GROUP BY cc.name;`
  - `getInternalConsumptionByBarber(startDate, endDate)`:
    - `SELECT b.id, p.first_name, SUM(ic.cost_at_time * ic.quantity) as total_cost FROM internal_consumptions ic JOIN barbers b ON ic.barber_id = b.id JOIN persons p ON b.person_id = p.id WHERE ic.consumption_date BETWEEN startDate AND endDate GROUP BY b.id, p.first_name;`
  - `calculateProductSaleCommissions(userId, startDate, endDate)`:
    - Filtra las ventas (`sale_items`) donde el `cost_center_id` corresponda a "Venta de Productos" y el `user_id` (de la tabla `sales`) corresponda al cajero, y aplica la lógica de comisión.

---

## 🔌 Sección 3: Nuevos Endpoints del API

- `POST /api/consumptions`: Para registrar un nuevo consumo interno. Body: `{ barberId, inventoryItemId, quantity }`.
- `GET /api/reports/revenue-by-cost-center`: Para los reportes de ingresos. Query params: `startDate`, `endDate`.
- `GET /api/reports/barber-consumption`: Para los reportes de consumo por barbero. Query params: `startDate`, `endDate`.

---

## 🚀 Sección 4: Orden de Implementación Sugerido

1.  **Asegurar Finalización de Fase 1:** Es crucial que la base de Caja e Inventario esté funcionando correctamente.
2.  **Aplicar Migración SQL (Fase 2):** Ejecutar el nuevo script en la base de datos de desarrollo.
3.  **Actualizar Modelos y Lógica de Ventas:** Modificar los modelos del backend y refactorizar el `SaleService` para que guarde el `cost_center_id` en `sale_items`. Este es un cambio pequeño pero fundamental.
4.  **Implementar Consumo Interno:** Desarrollar el `InternalConsumptionService` y su endpoint.
5.  **Desarrollar Reportes:** Implementar el `ReportService` y sus endpoints para visualizar los nuevos datos.
6.  **Desarrollar Interfaces (Frontend):**
    - Crear una vista simple (puede ser para tablet o PC en el almacén) para que los barberos o el encargado registren la salida de productos para consumo.
    - Crear las nuevas vistas de reportes en el dashboard para mostrar los análisis de rentabilidad y consumo.
7.  **Pruebas exhaustivas:** Validar que el consumo interno rebaje el stock correctamente pero no afecte la caja, y que los reportes por centro de costo sean precisos.

---

Una vez completada esta fase, el sistema no solo controlará operaciones, sino que se convertirá en una potente herramienta de inteligencia de negocio para la toma de decisiones.
