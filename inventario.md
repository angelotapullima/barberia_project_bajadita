# Módulo de Inventario - Barbería

## 1. Observaciones Generales
Separación correcta entre **inventario (todo lo que posee la empresa)** y **productos de venta**.  
Se recomienda mejorar:
- Uso de `NUMERIC` para precisión.
- Control de stock vía movimientos.
- Fuentes de adquisición (compra, donación, costo cero).
- Control de bajas (jubilaciones).
- Vistas para cálculo de stock.

---

## 2. Estructura SQL Recomendada

```sql
-- Tipos y Unidades
CREATE TABLE unit_types (
  id SERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE item_categories (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

-- Inventario general
CREATE TABLE inventory_items (
  id SERIAL PRIMARY KEY,
  sku TEXT UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  item_type TEXT NOT NULL, -- 'consumible','producto','activo'
  category_id INT REFERENCES item_categories(id),
  unit_id INT REFERENCES unit_types(id),
  min_stock NUMERIC(14,4) DEFAULT 0,
  is_trackable BOOLEAN DEFAULT true,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Productos de venta
CREATE TABLE menu_products (
  id SERIAL PRIMARY KEY,
  code TEXT UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  price NUMERIC(12,2) NOT NULL,
  category TEXT,
  is_active BOOLEAN DEFAULT true,
  is_composite BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Recetas
CREATE TABLE product_recipes (
  id SERIAL PRIMARY KEY,
  menu_product_id INT NOT NULL REFERENCES menu_products(id) ON DELETE CASCADE,
  inventory_item_id INT NOT NULL REFERENCES inventory_items(id) ON DELETE RESTRICT,
  quantity NUMERIC(14,4) NOT NULL,
  UNIQUE(menu_product_id, inventory_item_id)
);

-- Proveedores
CREATE TABLE suppliers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  contact JSONB
);

-- Adquisiciones
CREATE TABLE acquisitions (
  id SERIAL PRIMARY KEY,
  supplier_id INT REFERENCES suppliers(id),
  acquisition_type TEXT NOT NULL, -- 'compra','donacion','traslado','cost_zero'
  document_ref TEXT,
  date TIMESTAMPTZ DEFAULT now(),
  notes TEXT
);

CREATE TABLE acquisition_lines (
  id SERIAL PRIMARY KEY,
  acquisition_id INT NOT NULL REFERENCES acquisitions(id) ON DELETE CASCADE,
  inventory_item_id INT NOT NULL REFERENCES inventory_items(id),
  unit_price NUMERIC(12,4),
  quantity NUMERIC(14,4) NOT NULL
);

-- Movimientos
CREATE TYPE movement_kind AS ENUM ('in','out','adjustment','transfer','reservation','release','disposal');

CREATE TABLE inventory_movements (
  id SERIAL PRIMARY KEY,
  inventory_item_id INT NOT NULL REFERENCES inventory_items(id) ON DELETE RESTRICT,
  kind movement_kind NOT NULL,
  quantity NUMERIC(14,4) NOT NULL,
  movement_date TIMESTAMPTZ DEFAULT now(),
  related_table TEXT,
  related_id INT,
  location_from TEXT,
  location_to TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Ubicaciones físicas
CREATE TABLE locations (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  address TEXT
);

-- Bajas / Jubilaciones
CREATE TABLE disposals (
  id SERIAL PRIMARY KEY,
  inventory_item_id INT REFERENCES inventory_items(id),
  disposal_type TEXT,
  date TIMESTAMPTZ DEFAULT now(),
  notes TEXT
);
```

---

## 3. Vistas y Consultas Útiles

```sql
CREATE VIEW v_inventory_stock AS
SELECT
  i.id as inventory_item_id,
  i.name,
  COALESCE(SUM(
    CASE WHEN m.kind IN ('in','release') THEN m.quantity
         WHEN m.kind IN ('out','reservation','disposal') THEN -m.quantity
         WHEN m.kind = 'adjustment' THEN m.quantity
         ELSE 0 END
  ),0) AS qty,
  i.unit_id,
  i.is_trackable,
  i.min_stock
FROM inventory_items i
LEFT JOIN inventory_movements m ON m.inventory_item_id = i.id
GROUP BY i.id, i.name, i.unit_id, i.is_trackable, i.min_stock;
```

Consultar stock bajo mínimo:
```sql
SELECT * FROM v_inventory_stock WHERE qty <= min_stock;
```

---

## 4. Flujos Operativos Ejemplo

**Venta de Café (producto compuesto):**
1. Café (10g), Leche (100ml).
2. Insertar venta → generar movimientos `out` por ingredientes.

```sql
BEGIN;
INSERT INTO sales (date, total) VALUES (now(), 2.50) RETURNING id INTO sale_id;

INSERT INTO inventory_movements (inventory_item_id, kind, quantity, movement_date, related_table, related_id)
SELECT pr.inventory_item_id, 'out'::movement_kind, pr.quantity, now(), 'sales', sale_id
FROM product_recipes pr
WHERE pr.menu_product_id = :menu_product_id;
COMMIT;
```

**Compra / Donación:**
```sql
BEGIN;
INSERT INTO acquisitions (supplier_id, acquisition_type, document_ref) VALUES (1,'compra','FAC-123') RETURNING id INTO acq_id;
INSERT INTO acquisition_lines (acquisition_id, inventory_item_id, unit_price, quantity) VALUES (acq_id, 10, 0.50, 20);
INSERT INTO inventory_movements (inventory_item_id, kind, quantity, related_table, related_id)
VALUES (10, 'in'::movement_kind, 20, 'acquisitions', acq_id);
COMMIT;
```

---

## 5. Control de Activos
- Activos con identificación individual → crear tabla `inventory_item_instances` (seriales, fechas, garantías).
- Bajas → `disposals`.
- Adquisición gratuita → `acquisitions(acquisition_type='cost_zero')`.

---

## 6. Sugerencias Prácticas
- Mantener stock como vista, no columna (o usar trigger para cache).
- Controlar azúcares / insumos opcionales mediante movimientos o ajustes periódicos.
- Integrar con POS: cada venta genera movimientos.
- Usar reconciliaciones mensuales (`adjustment`) para corregir desviaciones.

---

## 7. Consultas Comunes
```sql
-- Stock actual
SELECT * FROM v_inventory_stock;

-- Stock bajo mínimo
SELECT * FROM v_inventory_stock WHERE qty < min_stock;

-- Historial de movimientos de un ítem
SELECT * FROM inventory_movements WHERE inventory_item_id = :id ORDER BY movement_date DESC;
```

---

## 8. Extensiones Futuras
- Control por lotes o fechas de vencimiento.
- Movimientos entre sucursales (`transfer` con location_from/location_to).
- Reservas por pedidos pendientes (`reservation` y `release`).
- Dashboard con stock crítico y consumos por período.
```