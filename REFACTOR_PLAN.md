# Plan de Refactorización de la Base de Datos y Frontend

Este documento detalla el plan para refactorizar la base de datos y el frontend con el fin de mejorar la integridad, reducir la redundancia y alinear el sistema con la lógica de negocio principal de la barbería.

## 1. Objetivos Principales

1.  **Desacoplar la tabla `sales`**: Eliminar la responsabilidad de almacenar montos agregados y datos del cliente.
2.  **Crear una entidad `clients`**: Formalizar el concepto de "cliente" vinculado a `persons`.
3.  **Establecer `sale_items` como única fuente de verdad**: Todos los cálculos de montos se basarán en los ítems de la venta.
4.  **Simplificar las `reservations`**: Las reservas se asociarán directamente a un `client`.
5.  **Eliminar `reservation_products`**: Tabla redundante cuya función es cubierta por `sale_items`.

## 2. Scripts de Migración SQL

### Script 1: Modificación del Esquema (`migration_schema.sql`)

Este script altera la estructura de la base de datos.

```sql
-- PASO 1: Crear la nueva tabla para clientes
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    person_id INT NOT NULL UNIQUE REFERENCES persons(id) ON DELETE CASCADE,
    start_date DATE DEFAULT CURRENT_DATE,
    loyalty_points INT DEFAULT 0,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- PASO 2: Alterar la tabla de reservas para vincularla a clientes
ALTER TABLE reservations
    ADD COLUMN client_id INT REFERENCES clients(id) ON DELETE SET NULL;

-- PASO 3: Alterar la tabla de ventas para vincularla a clientes y eliminar columnas redundantes
ALTER TABLE sales
    ADD COLUMN client_id INT REFERENCES clients(id) ON DELETE CASCADE,
    DROP COLUMN barber_id,
    DROP COLUMN customer_name,
    DROP COLUMN service_amount,
    DROP COLUMN products_amount;

-- PASO 4: Eliminar la tabla redundante de productos en reserva
DROP TABLE reservation_products;

-- PASO 5: Una vez migrados los datos, eliminar las columnas antiguas de reservations (ejecutar manualmente post-migración)
-- ALTER TABLE reservations
--     DROP COLUMN client_name,
--     DROP COLUMN client_phone;
```

### Script 2: Migración de Datos (`migration_data.sql` - Conceptual)

**⚠️ ADVERTENCIA: Este script es un ejemplo y debe ser adaptado y probado exhaustivamente en una copia de la base de datos de producción.**

```sql
DO $$
DECLARE
    rec RECORD;
    new_person_id INT;
    new_client_id INT;
BEGIN
    -- Migrar clientes únicos desde reservaciones y ventas
    RAISE NOTICE 'Migrando clientes...';
    FOR rec IN
        SELECT DISTINCT name, phone FROM (
            SELECT client_name as name, client_phone as phone FROM reservations WHERE client_name IS NOT NULL AND client_name != ''
            UNION
            SELECT customer_name as name, NULL as phone FROM sales WHERE customer_name IS NOT NULL AND customer_name != ''
        ) as all_clients
        WHERE NOT EXISTS (SELECT 1 FROM persons WHERE first_name = all_clients.name)
    LOOP
        -- Crear persona
        INSERT INTO persons (dni, first_name, phone, created_at, updated_at)
        VALUES (rec.phone, rec.name, rec.phone, NOW(), NOW())
        ON CONFLICT (dni) DO NOTHING
        RETURNING id INTO new_person_id;

        IF new_person_id IS NOT NULL THEN
            -- Crear cliente
            INSERT INTO clients (person_id, created_at, updated_at)
            VALUES (new_person_id, NOW(), NOW())
            RETURNING id INTO new_client_id;

            -- Actualizar tablas
            UPDATE reservations SET client_id = new_client_id WHERE client_name = rec.name;
            UPDATE sales SET client_id = new_client_id WHERE customer_name = rec.name;

            RAISE NOTICE 'Cliente "%" migrado con person_id % y client_id %', rec.name, new_person_id, new_client_id;
        END IF;
    END LOOP;
    RAISE NOTICE 'Migración de clientes completada.';
END $$;
```

## 3. Plan de Modificación del Backend

(El detalle de los cambios en `services`, `controllers` y `models` permanece como en la versión anterior del plan).

## 4. Plan de Modificación del Frontend (Detallado)

La API cambiará, rompiendo el frontend actual. Aquí están los cambios necesarios:

### Flujo de Reservas y Ventas (Impacto CRÍTICO)
-   **`components/ReservationFormModal.vue`**: Reemplazar campos `client_name` y `client_phone` por un selector de clientes. Reutilizar `components/PersonSelectorModal.vue` para buscar/crear clientes y obtener un `client_id`.
-   **`components/SaleRegistrationModal.vue`**: Modificar para gestionar una lista de `saleItems` (servicios + productos). La llamada a la API enviará esta lista, no montos pre-calculados.
-   **`stores/reservationStore.js`**: Actualizar la acción `createReservation` para enviar `client_id`.
-   **`stores/salesStore.js`**: Reescribir la acción `completeSale` para que coincida con el nuevo endpoint y formato de datos del backend.

### Reportes y Dashboard (Impacto ALTO)
-   **Vistas (`ComprehensiveSalesReportView.vue`, `DashboardView.vue`, etc.)**: Ajustar para manejar la nueva estructura de datos de la API (ventas con una lista de `sale_items` en lugar de montos totales).
-   **`stores/reportStore.js`**: Actualizar las acciones que obtienen datos de reportes. Las respuestas de la API tendrán un formato diferente.

### Nueva Funcionalidad: Gestión de Clientes
-   **Nueva Vista (`ClientsView.vue`)**: Crear una nueva página para el CRUD de Clientes.
-   **Nuevos Componentes**: Crear `ClientListTable.vue` y `ClientFormModal.vue` (pueden basarse en los componentes de `Person`).
-   **Nuevo Store (`stores/clientStore.js`)**: Añadir un store para manejar el estado y la lógica de los clientes.

## 5. Actualización de Documentación

-   **`design-doc-backend.md`**: Actualizar para reflejar el nuevo esquema.
-   **`swagger.ts`**: Actualizar la documentación de la API.

## 6. Orden de Implementación Sugerido

1.  **Backend - Base de Datos**: Ejecutar el `migration_schema.sql` en un entorno de desarrollo.
2.  **Backend - Lógica**: Modificar todos los `services`, `controllers` y `models` afectados en el backend para que funcionen con el nuevo esquema. Probar la API.
3.  **Data Migration**: Probar y ejecutar el script de migración de datos en un entorno de prueba que sea una copia de producción.
4.  **Frontend - Implementación**: Modificar el frontend (vistas, componentes, stores) para que funcione con la nueva API, empezando por el flujo de reservas y ventas.
5.  **Despliegue**: Coordinar el despliegue del backend y frontend actualizados.