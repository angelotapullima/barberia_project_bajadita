# 📋 Plan de Implementación: Módulo de Personal y Nómina (RRHH v1.0)

Este documento detalla el paso a paso técnico para unificar a todo el equipo (Barberos, Cajeras, Personal de Limpieza, etc.) bajo una estructura laboral profesional y segura.

---

## 🎯 Objetivos Principales
1.  **Unificación:** Centralizar a todo el personal en una tabla `employees`.
2.  **Separación de Conceptos:** Separar la **Ficha Laboral** (Dinero/Sede) del **Acceso al Sistema** (Usuario/Password).
3.  **Nómina Automatizada:** Cálculo automático de pagos: `Sueldo Base + Comisiones`.
4.  **Seguridad Senior:** El Superadmin supervisa todo; el Admin de Sede solo gestiona su equipo local.

---

## 🛠️ Fase 1: Evolución de la Base de Datos (Integridad Total)

### 1.1 Creación de la Tabla `employees`
Esta tabla reemplaza el concepto limitado de "Barbers" y se convierte en el corazón del personal.
-   `id` (PK)
-   `person_id` (FK -> persons): Vínculo a DNI, Nombre, Email.
-   `location_id` (FK -> locations): Sede obligatoria (excepto para Superadmin).
-   `job_title` (Enum/Text): 'barbero', 'cajero', 'administrador', 'limpieza'.
-   `base_salary` (Decimal): Sueldo fijo mensual garantizado.
-   `commission_rate` (Decimal): % de ganancia (Barberos sobre servicios, Cajeras sobre retail).
-   `is_active` (Boolean): Estado laboral.

### 1.2 Migración de Referencias
Actualizaremos las tablas operativas para que apunten al nuevo `employee_id`:
-   `reservations`: `barber_id` -> `employee_id`.
-   `sale_items`: `barber_id` -> `employee_id`.
-   `internal_consumptions`: `barber_id` -> `employee_id`.

### 1.3 Limpieza de la Tabla `users`
-   Eliminaremos `location_id` y `commission_rate` de `users`.
-   La tabla `users` solo tendrá: `id`, `person_id`, `password`, `role`.
-   **Lógica de Sede:** El sistema obtendrá la sede haciendo un JOIN: `users -> persons -> employees`.

---

## 🧠 Fase 2: Lógica de Negocio (Backend)

### 2.1 Servicio Unificado de Pagos
Implementaremos el método `calculateMonthlyPayroll(employeeId, month, year)` con las siguientes reglas de oro:
-   **Regla Barberos:** Se paga el `MAX(Sueldo Base, Producción de Servicios * % Comisión)`.
-   **Regla Cajeras:** Se paga `Sueldo Base + (Ventas Retail * % Comisión)`.
-   **Regla Limpieza/Otros:** Se paga `Sueldo Base` fijo.

### 2.2 Blindaje de Seguridad (Regla de Oro)
-   El controlador de pagos **ignora** el `location_id` enviado por el front.
-   Si el usuario es `superadmin`, el servicio devuelve la nómina de **todas las sedes**.
-   Si es `administrador`, el servicio fuerza el filtro `WHERE location_id = $X` de su propia ficha de empleado.

---

## 🎨 Fase 3: Interfaz de Usuario (Frontend Clean & Bright)

### 3.1 Vista: Gestión de Empleados (`EmployeesView.vue`)
-   Tabla con fotos/iniciales, cargo, sede y sueldo.
-   Modal de registro inteligente: 
    -   Si eliges 'Barbero', te pide estación.
    -   Si eliges 'Cajero', te pide comisión de retail.
-   Filtros rápidos por Sede (solo para Superadmin).

### 3.2 Vista: Tablero de Nómina (`PayrollView.vue`)
-   Resumen del mes actual.
-   Lista de "Pagos Pendientes" vs "Pagos Realizados".
-   Botón de "Liquidar Mes" que genera el rastro contable en la caja.

---

## 🚀 Paso a Paso de Ejecución Inmediata

1.  **[BACKEND]** Crear el tipo Enum `UserRole` y los modelos de TypeScript para `Employee`.
2.  **[DB]** Ejecutar el script `v5.0` de migración (meticuloso, sin borrar tablas de negocio).
3.  **[BACKEND]** Actualizar el `AuthMiddleware` para que la sede se obtenga desde la ficha de empleado.
4.  **[FRONTEND]** Crear el Store de `employeeStore.js` para centralizar la lógica de personal.
5.  **[FRONTEND]** Implementar la vista de gestión de empleados y conectarla con el backend blindado.
