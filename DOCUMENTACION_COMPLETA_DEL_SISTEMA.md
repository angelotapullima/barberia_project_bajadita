# DOCUMENTACIÓN COMPLETA DEL SISTEMA DE BARBERÍA

## 📋 ÍNDICE

1. [Arquitectura General](#arquitectura-general)
2. [Backend - API REST](#backend---api-rest)
3. [Frontend - Aplicación Vue.js](#frontend---aplicación-vuejs)
4. [Funcionalidades por Pantalla](#funcionalidades-por-pantalla)
5. [Lógica de Negocio por Módulo](#lógica-de-negocio-por-módulo)
6. [Flujo de Datos](#flujo-de-datos)
7. [Autenticación y Autorización](#autenticación-y-autorización)
8. [Métricas y KPIs del Sistema](#métricas-y-kpis-del-sistema)
9. [Tecnologías y Herramientas](#tecnologías-y-herramientas)
10. [Características Técnicas](#características-técnicas)

---

## 🏗️ ARQUITECTURA GENERAL

### Stack Tecnológico

**Backend:** (ubicado en la carpeta `barberia_project_backend`)

- **Node.js + Express.js**: Entorno de ejecución y framework web.
- **TypeScript**: Lenguaje de programación con tipado estático.
- **PostgreSQL**: Base de datos relacional.
- **`pg` (Node-Postgres)**: Cliente de PostgreSQL para Node.js, utilizando un pool de conexiones.
- **JWT (JSON Web Tokens)**: Para autenticación y autorización.
- **Swagger/OpenAPI**: Para documentación interactiva de la API.
- **Day.js**: Librería ligera para manipulación de fechas.
- **Bcrypt**: Para hashing de contraseñas.
- **CORS**: Manejo de políticas de Cross-Origin Resource Sharing.
- **Dotenv**: Gestión de variables de entorno.
- **Nodemon**: Para reinicio automático del servidor durante el desarrollo.

**Frontend:** (ubicado en la carpeta `barberia_project_frontend`)

- **Vue.js 3 (Composition API)**: Framework progresivo para la interfaz de usuario.
- **Pinia**: Gestión de estado global (reemplazo de Vuex).
- **Vue Router 4**: Para enrutamiento de la aplicación de una sola página (SPA).
- **Tailwind CSS**: Framework CSS utilitario para un diseño rápido y responsivo.
- **Axios**: Cliente HTTP para realizar peticiones a la API.
- **ApexCharts**: Librería para la creación de gráficos interactivos.
- **Day.js**: Librería ligera para manipulación de fechas.
- **jsPDF y jspdf-autotable**: Para la generación de documentos PDF (ej. boletas de pago).
- **Vite**: Herramienta de construcción rápida para el desarrollo frontend.

### Arquitectura MVC (Modelo-Vista-Controlador)

El sistema sigue una arquitectura MVC clara, donde el Frontend actúa como la Vista, la API REST como el Controlador y la Base de Datos como el Modelo.

```
Frontend (Vue.js) ←→ API REST (Express.js) ←→ Base de Datos (PostgreSQL)
```

---

## 🖥️ BACKEND - API REST (ubicado en la carpeta `barberia_project_backend`)

### Estructura de Directorios

La estructura del backend está organizada para promover la modularidad y la separación de responsabilidades:

```
src/
├── controllers/     # Contiene la lógica de manejo de solicitudes HTTP, interactuando con los servicios.
├── middleware/      # Implementa funciones intermedias para autenticación, autorización, etc.
├── models/          # Define las interfaces de los modelos de datos (TypeScript).
├── routes/          # Define las rutas de la API y las asocia con los controladores y middlewares.
├── services/        # Contiene la lógica de negocio principal y la interacción directa con la base de datos.
├── app.ts           # Configuración principal de la aplicación Express (middlewares, rutas).
├── server.ts        # Punto de entrada del servidor, inicia Express y gestiona el ciclo de vida del pool de DB.
├── database.ts      # Configuración del pool de conexiones a PostgreSQL.
└── swagger.ts       # Configuración de la documentación Swagger/OpenAPI.
```

### Manejo de Conexiones a la Base de Datos

El backend utiliza `pg` (Node-Postgres) con un pool de conexiones para gestionar eficientemente las interacciones con PostgreSQL.

- **`database.ts`**: Configura y exporta una instancia de `Pool` (`dbPool`).
- **`server.ts`**: Implementa manejadores para las señales de terminación del proceso (`SIGINT`, `SIGTERM`) que aseguran que el `dbPool` se cierre de forma elegante.

### 🔗 ENDPOINTS DISPONIBLES

La API RESTful proporciona los siguientes endpoints, protegidos por autenticación JWT y, en algunos casos, por autorización basada en roles.

#### 🔐 Autenticación, Personas y Usuarios

| Método | Endpoint                    | Descripción                                   | Middleware / Rol                                       |
| ------ | --------------------------- | --------------------------------------------- | ------------------------------------------------------ |
| POST   | `/api/auth/login`           | Inicia sesión de un usuario, retorna JWT.     | -                                                      |
| GET    | `/api/auth/me`              | Obtiene el perfil del usuario autenticado.    | `authenticateToken`                                    |
| PUT    | `/api/auth/change-password` | Cambia la contraseña del usuario autenticado. | `authenticateToken`                                    |
| GET    | `/api/persons`              | Lista todas las personas.                     | `authenticateToken`                                    |
| POST   | `/api/persons`              | Crea una nueva persona.                       | `authenticateToken`                                    |
| PUT    | `/api/persons/:id`          | Actualiza una persona.                        | `authenticateToken`                                    |
| GET    | `/api/users`                | Lista todos los usuarios.                     | `authenticateToken`, `authorizeRoles('administrador')` |
| POST   | `/api/users`                | Crea un nuevo usuario.                        | `authenticateToken`, `authorizeRoles('administrador')` |
| PUT    | `/api/users/:id`            | Actualiza un usuario.                         | `authenticateToken`, `authorizeRoles('administrador')` |

#### 💈 Gestión de Barbería

| Método                 | Endpoint                    | Descripción                               | Middleware          |
| ---------------------- | --------------------------- | ----------------------------------------- | ------------------- |
| GET, POST, PUT, DELETE | `/api/barbers`              | CRUD completo para barberos.              | `authenticateToken` |
| POST                   | `/api/barbers/:id/advances` | Registra un adelanto para un barbero.     | `authenticateToken` |
| GET, POST, PUT, DELETE | `/api/stations`             | CRUD completo para estaciones de trabajo. | `authenticateToken` |
| GET, POST, PUT, DELETE | `/api/services`             | CRUD completo para servicios.             | `authenticateToken` |

#### 📦 Inventario y Productos

| Método                 | Endpoint                   | Descripción                                       | Middleware          |
| ---------------------- | -------------------------- | ------------------------------------------------- | ------------------- |
| GET, POST, PUT, DELETE | `/api/inventory-items`     | CRUD para ítems de inventario (materias primas).  | `authenticateToken` |
| GET, POST, PUT, DELETE | `/api/menu-products`       | CRUD para productos de menú (productos de venta). | `authenticateToken` |
| GET                    | `/api/inventory/summary`   | Resumen del inventario (legado).                  | `authenticateToken` |
| GET, POST              | `/api/inventory/movements` | Gestión de movimientos de inventario (legado).    | `authenticateToken` |

#### 🚚 Compras y Proveedores

| Método                 | Endpoint         | Descripción                     | Middleware          |
| ---------------------- | ---------------- | ------------------------------- | ------------------- |
| GET, POST, PUT, DELETE | `/api/suppliers` | CRUD completo para proveedores. | `authenticateToken` |
| GET, POST, PUT, DELETE | `/api/purchases` | CRUD completo para compras.     | `authenticateToken` |

#### 📅 Reservas y Ventas

| Método                 | Endpoint                          | Descripción                                | Middleware          |
| ---------------------- | --------------------------------- | ------------------------------------------ | ------------------- |
| GET, POST, PUT, DELETE | `/api/reservations`               | CRUD completo para reservaciones.          | `authenticateToken` |
| POST                   | `/api/reservations/:id/complete`  | Completa una reserva y genera una venta.   | `authenticateToken` |
| POST                   | `/api/reservations/:id/cancel`    | Cancela una reserva.                       | `authenticateToken` |
| GET                    | `/api/reservations/view/calendar` | Obtiene datos para la vista de calendario. | `authenticateToken` |
| POST                   | `/api/sales`                      | Crea una venta directa de productos.       | `authenticateToken` |
| GET                    | `/api/sales/:id`                  | Obtiene una venta por su ID.               | `authenticateToken` |

#### 💵 Comisiones y Pagos

| Método   | Endpoint                                     | Descripción                                | Middleware          |
| -------- | -------------------------------------------- | ------------------------------------------ | ------------------- |
| GET      | `/api/barber-commissions/monthly-summary`    | Resumen mensual de comisiones.             | `authenticateToken` |
| POST     | `/api/barber-commissions/finalize-payment`   | Finaliza un pago de comisiones.            | `authenticateToken` |
| GET      | `/api/barber-commissions/:barberId/services` | Lista servicios detallados de un barbero.  | `authenticateToken` |
| GET      | `/api/barber-commissions/:barberId/advances` | Lista adelantos detallados de un barbero.  | `authenticateToken` |
| GET, PUT | `/api/payments`                              | Gestiona registros de pagos de comisiones. | `authenticateToken` |

#### 📈 Reportes y Dashboard

| Método | Endpoint                               | Descripción                                  | Middleware          |
| ------ | -------------------------------------- | -------------------------------------------- | ------------------- |
| GET    | `/api/dashboard/summary`               | Resumen de métricas clave para el dashboard. | `authenticateToken` |
| GET    | `/api/reports/comprehensive-sales`     | Reporte comprensivo de ventas. Devuelve datos paginados y los totales de montos de todo el rango filtrado. | `authenticateToken` |
| GET    | `/api/reports/services-products-sales` | Reporte de ventas por servicios y productos. | `authenticateToken` |
| GET    | `/api/reports/station-usage`           | Reporte de uso de estaciones.                | `authenticateToken` |
| GET    | `/api/reports/customer-frequency`      | Reporte de frecuencia de clientes.           | `authenticateToken` |
| GET    | `/api/reports/peak-hours`              | Reporte de horas pico de actividad.          | `authenticateToken` |

#### ⚙️ Configuración

| Método   | Endpoint        | Descripción                            | Middleware / Rol                                       |
| -------- | --------------- | -------------------------------------- | ------------------------------------------------------ |
| GET, PUT | `/api/settings` | Gestiona la configuración del sistema. | `authenticateToken`, `authorizeRoles('administrador')` |

#### 🛒 Punto de Venta (POS)

| Método | Endpoint              | Descripción                                                              | Middleware          |
| ------ | --------------------- | ------------------------------------------------------------------------ | ------------------- |
| GET    | `/api/pos/master-data` | Obtiene datos maestros (servicios, productos de menú) para el POS. | `authenticateToken` |

### Modelos de Datos (Interfaces TypeScript)

- **`Person`**: `id`, `dni`, `first_name`, `last_name`, `email`, `phone`, `address`, `birth_date`. Representa una entidad humana o legal.
- **`Client`**: `id`, `person_id`, `start_date`, `loyalty_points`, `notes`. Representa un cliente del negocio, vinculado a una `Person`.
- **`User`**: `id`, `person_id`, `password` (hash), `role` (`administrador`, `cajero`). Usuario del sistema con credenciales.
- **`Barber`**: `id`, `name`, `email`, `phone`, `hire_date`, `base_salary`, `commission_rate`, `station_id`, `is_active`. Empleado que realiza servicios.
- **`Station`**: `id`, `name`, `description`, `is_active`. Puesto de trabajo físico.
- **`Service`**: `id`, `name`, `description`, `price`, `duration_minutes`, `is_active`. Servicios ofrecidos por la barbería.
- **`InventoryItem`**: `id`, `name`, `description`, `stock_quantity`, `min_stock_level`, `unit`. Materia prima o insumo.
- **`MenuProduct`**: `id`, `name`, `price`, `category`, `is_active`, `inventory_item_id` (si es venta directa), `recipes` (si es compuesto). Producto final que se vende al cliente.
- **`ProductRecipe`**: `menu_product_id`, `inventory_item_id`, `quantity_used`. Define los insumos para un `MenuProduct` compuesto.
- **`Supplier`**: `id`, `name`, `ruc`, `phone`, `email`, `address`, `person_id`. Proveedor de insumos.
- **`Purchase`**: `id`, `supplier_id`, `purchase_date`, `total_amount`, `status`. Transacción de compra a un proveedor.
- **`PurchaseDetail`**: `purchase_id`, `item_description`, `quantity`, `unit_price`. Ítems dentro de una compra.
- **`Reservation`**: `id`, `client_id`, `barber_id`, `station_id`, `service_id`, `start_time`, `end_time`, `status`. Cita agendada, ahora vinculada a un `Client`.
- **`Sale`**: `id`, `reservation_id`, `client_id`, `total_amount`, `payment_method`, `sale_date`. Transacción de venta finalizada, ahora vinculada a un `Client`.
- **`SaleItem`**: `sale_id`, `item_type` (`service`, `product`), `item_id`, `quantity`, `original_unit_price`, `unit_price`, `is_courtesy`, `courtesy_reason`. Ítems dentro de una venta.

---

## 🎨 FRONTEND - APLICACIÓN VUE.JS (ubicado en la carpeta `barberia_project_frontend`)

### Estructura de Directorios

```
src/
├── assets/          # Archivos estáticos como imágenes o iconos.
├── components/      # Componentes Vue reutilizables (modales, tablas, selectores, PurchaseItemSelector, etc.).
├── router/          # Configuración de Vue Router para la navegación.
├── services/        # Servicios JavaScript para interacción con la API (Axios) y otras utilidades.
├── stores/          # Módulos de Pinia para la gestión del estado global de la aplicación.
├── views/           # Componentes Vue que representan las pantallas/páginas principales de la aplicación.
├── App.vue          # Componente raíz de la aplicación.
├── main.js          # Punto de entrada de la aplicación Vue.
└── style.css        # Estilos globales de la aplicación (Tailwind CSS).
```

### 🛣️ RUTAS PRINCIPALES

| Ruta            | Vista                      | Nombre de Ruta                | Descripción                                                   |
| --------------- | -------------------------- | ----------------------------- | ------------------------------------------------------------- |
| `/`             | `DashboardView`            | `Dashboard`                   | Panel principal con métricas y gráficos resumen.              |
| `/login`        | `LoginView`                | `Login`                       | Página de inicio de sesión.                                   |
| `/people`       | `PeopleView`               | `People`                      | Gestión de personas (clientes, personal).                     |
| `/barbers`      | `BarbersView`              | `Barbers`                     | Gestión de barberos (CRUD).                                   |
| `/stations`     | `StationsView`             | `Stations`                    | Gestión de estaciones de trabajo (CRUD).                      |
| `/services`     | `ServicesView`             | `Services`                    | Gestión de servicios ofrecidos (CRUD con paginación).         |
| `/inventory`    | `InventoryView`            | `Inventory`                   | Gestión de inventario y productos de menú.                    |
| `/suppliers`    | `SuppliersView`            | `Suppliers`                   | Gestión de proveedores.                                       |
| `/purchases`    | `PurchasesView`            | `Purchases`                   | Gestión de compras a proveedores.                             |
| `/reservations` | `ReservationsView`         | `Reservations`                | Gestión de reservaciones (CRUD, paginación).                  |
| `/schedule`     | `DailyCalendarView`, `WeeklyCalendarView` | `Schedule`                    | Vista de calendario diario y semanal de citas.         |
| `/payments`     | `BarberPaymentsReportView` | `Payments`                    | Resumen de pagos a barberos.                                  |
| `/settings`     | `SettingsView`             | `Settings`                    | Configuración del sistema y gestión de usuarios (solo Admin). |
| `/reports/*`    | Vistas de Reportes         | Diversos reportes de negocio. |

### 🗃️ STORES DE PINIA

- **`clientStore`**: Gestiona el estado y las operaciones para los clientes (ej. buscar o crear un cliente a partir de una persona).
- **`authStore`**: Gestiona el estado de autenticación del usuario (token JWT, datos del usuario, roles).
- **`personStore`**: Gestiona el estado y las operaciones CRUD para las personas.
- **`userStore`**: Gestiona la lista de usuarios (solo para administradores).
- **`barberStore`**: Gestiona la lista de barberos.
- **`stationStore`**: Gestiona la lista de estaciones.
- **`serviceStore`**: Gestiona la lista de servicios con paginación.
- **`inventoryItemStore`**: Gestiona el estado y las operaciones CRUD para los ítems de inventario (materias primas).
- **`menuProductStore`**: Gestiona el estado y las operaciones CRUD para los productos de menú.
- **`supplierStore`**: Gestiona el estado de los proveedores.
- **`purchaseStore`**: Gestiona el estado de las compras.
- **`reservationStore`**: Gestiona la lista de reservaciones y sus operaciones, incluyendo `calendarReservations` para las vistas de calendario.
- **`salesStore`**: Gestiona la lista de ventas, incluyendo la creación de ventas directas (`createDirectSale`).
- **`reportStore`**: Almacena los datos de los diversos reportes, incluyendo los totales generales de ventas (`totalComprehensiveSales`, `totalServiceAmount`, `totalProductsAmount`, `totalAmount`) y el total de cortesías (`totalCourtesyAmount`).
- **`paymentStore`**: Almacena temporalmente la información de un pago de comisión seleccionado.
- **`PurchaseItemSelector`**: Este componente interactúa con `menuProductStore` e `inventoryItemStore` para la selección y creación de ítems en el flujo de compras.

### Componentes Reutilizables Clave

- **`Modal.vue`**: Componente base para modales.
- **`TablaBarberia.vue`**: Tabla genérica y reutilizable para mostrar datos con acciones y paginación.
- **`PersonFormModal.vue`**: Formulario para crear/editar personas.
- **`SupplierFormModal.vue`**: Formulario para crear/editar proveedores.
- **`InventoryItemFormModal.vue`**: Formulario para crear/editar ítems de inventario.
- **`MenuProductFormModal.vue`**: Formulario para productos de menú (con lógica para recetas).
- **`CompleteSaleModal.vue`**: Modal para completar ventas ligadas a reservas.
- **`DirectSaleModal.vue`**: Nuevo modal para registrar ventas directas de productos.
- **`ReservationFormModal.vue`**: Formulario para crear/editar una reserva.
- **`PurchaseItemSelector.vue`**: Componente para seleccionar o crear ítems de inventario/productos de menú en línea dentro del formulario de compra.
- **`Sidebar.vue`**: Barra lateral de navegación principal de la aplicación.

---

## 📱 FUNCIONALIDADES POR PANTALLA

### 1. 🏠 **Dashboard** (`/`)

- **Funcionalidades:** Tarjetas de métricas en tiempo real, gráficos de ventas, tabla de pagos a barberos, servicios populares.
- **Lógica:** Se actualiza al cargar, obteniendo datos consolidados del endpoint `/api/dashboard/summary`.

### 2. 🔐 **Login** (`/login`)

- **Funcionalidades:** Formulario de email/password, validación, almacenamiento de token JWT en `localStorage`.
- **Lógica:** Utiliza JWT para autenticación. Un `router.beforeEach` protege las rutas.

### 3. 👥 **Personas** (`/people`)

- **Funcionalidades:** CRUD completo para la entidad `Person`. Esta vista permite gestionar una base de datos central de individuos que pueden ser clientes, o la base para crear usuarios, proveedores, etc.
- **Lógica:** Interactúa con el `personStore` para realizar las operaciones contra `/api/persons`.

### 4. 👨‍💼 **Barberos** (`/barbers`)

- **Funcionalidades:** Lista de barberos, modal para crear/editar (nombre, contacto, sueldo, comisión, estación), eliminación lógica.
- **Lógica:** Los barberos inactivos no aparecen en otros módulos.

### 5. 🪑 **Estaciones** (`/stations`)

- **Funcionalidades:** CRUD completo de estaciones de trabajo.
- **Lógica:** Validación para evitar eliminar estaciones con barberos asignados.

### 6. ✂️ **Servicios** (`/services`)

- **Funcionalidades:** Gestión de servicios con tabla paginada (precio, duración, etc.).
- **Lógica:** El precio y duración se usan en reservas y ventas.

### 7. 📦 **Inventario** (`/inventory`)

- **Funcionalidades:** Interfaz con dos pestañas:
  - **Pestaña "Productos de Menú"**: Gestión de los productos que se venden al cliente (ej. "Café Americano", "Cera Moldeadora"). Permite definir si es un producto de venta directa, si es un producto compuesto (con receta), o un servicio.
  - **Pestaña "Ítems de Inventario"**: Gestión de las materias primas y su stock real (ej. "Gramos de Café", "Botella de Shampoo", "Pote de Cera").
- **Lógica:** Es el núcleo del control de stock. Las ventas de "Productos de Menú" descuentan "Ítems de Inventario".

### 8. 🚚 **Proveedores** (`/suppliers`)

- **Funcionalidades:** CRUD para los proveedores de la barbería. Permite registrar información de contacto y fiscal.
- **Lógica:** Interactúa con el `supplierStore` y los endpoints `/api/suppliers`.

### 9. 🛒 **Compras** (`/purchases`)

- **Funcionalidades:** Registro de las compras a proveedores. Se selecciona un proveedor, se añaden los ítems comprados (que se relacionan con los `Ítems de Inventario`) y se registra el total.
- **Lógica:** Al registrar una compra, se actualiza automáticamente el stock de los `Ítems de Inventario` correspondientes.

### 10. 📅 **Reservaciones y Calendario** (`/schedule`)

- **Funcionalidades:** La vista de calendario (`/schedule`) muestra las citas por día y semana. El botón "Nuevo" permite iniciar una "Nueva Reserva" (abriendo el `ReservationFormModal`) o una "Nueva Venta" (abriendo el `DirectSaleModal`).
- **Lógica:** Completar una reserva genera una venta automática. Las horas se manejan en UTC.

### 11. 💰 **Ventas**

- **Funcionalidades:** La creación de ventas directas (sin reserva) se realiza a través del `DirectSaleModal`, accesible desde la vista de calendario. Estas ventas no se asocian a un barbero y, por lo tanto, no generan comisiones. Los detalles de cualquier venta se pueden ver en el `SaleDetailsModal` o en el reporte de ventas.
- **Lógica:** Las ventas actualizan el stock de `Ítems de Inventario` según la lógica de productos directos o compuestos.

### 12. 💵 **Pagos a Barberos** (`/payments`)

- **Funcionalidades:** Resumen mensual de comisiones por barbero, detalle de servicios y adelantos, y finalización de pagos con generación de boleta en PDF.
- **Lógica:** El cálculo de comisión se basa en las ventas generadas a partir de **reservas completadas**. Las ventas directas no se incluyen en este cálculo.

### 13. ⚙️ **Configuración** (`/settings`)

- **Funcionalidades:**
  - **Pestaña "Configuración General"**: Ajuste de parámetros del sistema (solo admin).
  - **Pestaña "Gestión de Usuarios"**: CRUD para los usuarios del sistema (`cajero`, `administrador`) (solo admin).
- **Lógica:** Permite la administración de alto nivel del sistema.

### 14. 📊 **Reportes** (`/reports/*`)

- **Funcionalidades:** Múltiples vistas de reportes interactivos (Ventas, Inventario, Uso de Estaciones, etc.) con filtros por fecha y gráficos. La vista de "Ventas Detallado" funciona como el historial principal de todas las ventas.

---

## 🧠 LÓGICA DE NEGOCIO POR MÓDULO

### **Módulo de Inventario, Compras y Ventas (Lógica Clave)**

El sistema de inventario está diseñado para proporcionar un control granular sobre todos los activos y consumibles del negocio. El flujo de datos se centra en el `Ítem de Inventario` como entidad central.

1.  **Tipos de Ítem de Inventario (`inventory_item_type_enum`):** La correcta clasificación de un ítem es fundamental para la lógica de negocio.
    *   **`RAW_MATERIAL` (Materia Prima):** Ingredientes para crear otros productos. Su stock se reduce cuando un `Producto del Menú` de tipo "Compuesto" que los contiene en su receta es vendido.
        *   *Ejemplo:* "Pigmento de color", "Peróxido".
    *   **`CONSUMABLE_SUPPLY` (Insumo Consumible):** Ítems que se gastan durante la prestación de un `Servicio`. Su stock se reduce cuando se vende un servicio que los tiene configurados como insumos.
        *   *Ejemplo:* "Champú a granel", "Navajas desechables", "Gel de peinado".
    *   **`OPERATIONAL_ASSET` (Activo Operacional):** Herramientas y equipo reutilizable del negocio. Se registran para control de patrimonio. Su stock no se descuenta automáticamente con las ventas.
        *   *Ejemplo:* "Máquinas de cortar", "Tijeras", "Toallas".
    *   **`RETAIL_PRODUCT` (Producto de Venta):** Ítems comprados para ser revendidos tal cual. Su stock se descuenta cuando un `Producto del Menú` de tipo "Directo" vinculado a ellos es vendido.
        *   *Ejemplo:* "Botella de cera marca X", "Lata de bebida".

2.  **Flujo de Entrada de Stock (Adquisiciones):**
    *   Una `Adquisición` con sus `Líneas de Adquisición` crea un movimiento de inventario de tipo `IN` para cada `Ítem de Inventario` comprado. Esto incrementa la cantidad de `current_stock` en la vista `v_inventory_stock`.

3.  **Flujo de Salida de Stock (Ventas y Bajas):**
    *   La función `updateStockFromSale` se encarga de procesar todos los ítems de una venta de forma recursiva.
    *   **Venta de un Combo/Bundle:** Si un ítem de venta es de tipo `bundle`, el sistema consulta `T_BAR_BUNDLE_ITEMS` para "desempacar" su contenido. Luego, vuelve a llamar a la función de actualización de stock para procesar cada servicio y producto del combo como si se hubieran vendido individualmente.
    *   **Venta de un Servicio:** El sistema consulta la tabla `T_BAR_SERVICE_SUPPLIES` para encontrar los insumos y cantidades asociadas al `service_id` vendido. Por cada insumo, se crea un movimiento de tipo `OUT`, reduciendo el stock.
    *   **Venta de un Producto del Menú:**
        *   **Tipo "Directo":** Se busca el `inventory_item_id` asociado al `menu_product_id` y se crea un movimiento `OUT` para ese ítem.
        *   **Tipo "Compuesto":** El sistema consulta `product_recipes` para encontrar todos los `inventory_item_id` y sus `quantity_used` para el `menu_product_id` vendido. Se crea un movimiento `OUT` por cada ítem en la receta.
    *   **Bajas manuales:** La creación de un registro en la tabla `disposals` genera un movimiento de tipo `DISPOSAL`, reduciendo el stock.

4.  **Trazabilidad Total (`inventory_movements`):** Cada uno de los flujos anteriores (entrada y salida) se registra obligatoriamente en la tabla `inventory_movements`, proporcionando un historial auditable de cada cambio de stock para cada ítem.

5.  **Venta de Cortesía**: Cuando un ítem en una venta es marcado como cortesía:
    - El `unit_price` y `total_price` del `SaleItem` se registran como 0.
    - El `original_unit_price` se preserva para poder calcular cuánto dinero se ha "perdido" en cortesías.
    - El `total_amount` de la `Sale` no incluye los montos de los ítems de cortesía.

### **Módulo de Comisiones de Barberos**

- **Cálculo de Comisión**: Se basa únicamente en las ventas generadas a través de la finalización de una reserva (`reservations.status = 'pagado'`). Si el total de ventas de servicios de un barbero en el mes es mayor o igual al doble de su sueldo base, su comisión se calcula como `(Total Ventas Servicios * Tasa de Comisión)`. De lo contrario, su ingreso es solo su sueldo base.
- **Ventas Directas y Comisiones:** Las ventas creadas directamente (`reservation_id` es NULL en la tabla `sales`) **no se asocian a ningún barbero** y, por lo tanto, no contribuyen al cálculo de comisiones.
- **Pago Final**: `(Ingreso Calculado) - (Total de Adelantos del Mes)`.

### **Casos de Uso Avanzados de Inventario (Mejores Prácticas)**

1.  **Ítem de Doble Uso (Venta y Consumo):**
    *   **Escenario:** Un producto (ej. Gel) se vende como unidad y se consume en ml durante los servicios.
    *   **Solución Recomendada:** Registrar el ítem en su unidad más pequeña de consumo (ej. "Mililitro").
        *   Se crea un único `Ítem de Inventario` (ej. "Gel Marca X", unidad: "ml").
        *   La `Adquisición` se registra en la unidad base (ej. una botella de 500ml se ingresa como una cantidad de 500).
        *   Un `Servicio` se configura en `T_BAR_SERVICE_SUPPLIES` para consumir una pequeña cantidad (ej. `quantity_used: 10`).
        *   Un `Producto del Menú` para la venta se configura como "Directo", y la lógica de la aplicación debe asegurar que al venderlo, se descuente la cantidad correcta en la unidad base (ej. la venta de una botella descuenta 500 del stock de "ml").

2.  **Manejo de Unidades de Medida Múltiples:**
    *   **Escenario:** Se compra en cajas, se almacena en botellas, se usa en ml.
    *   **Solución Recomendada:** El sistema no soporta conversión de unidades. Toda la trazabilidad de un ítem debe realizarse en una **única unidad base** consistente. La mejor práctica es elegir la **unidad de consumo más pequeña**.
        *   **Ejemplo:** Se compra una caja de 10 potes de cera (100ml c/u) y se usan 5ml por servicio.
        *   **Implementación:**
            *   `Ítem de Inventario`: "Cera Profesional", `unit_id` apunta a "Mililitro".
            *   `Adquisición`: Se registra una entrada de `quantity: 1000` (10 potes * 100 ml).
            *   `Servicio`: El insumo se configura con `quantity_used: 5`.
        *   **Resultado:** Este enfoque garantiza la máxima precisión en el seguimiento del stock.

### **Módulo de Autenticación y Usuarios**

- **Roles**: `administrador` (acceso total) y `cajero` (acceso operativo).
- **Seguridad**: Las contraseñas se hashean con Bcrypt. El acceso a rutas se controla con middlewares en el backend y guardias de navegación en el frontend.

---

## 🔄 FLUJO DE DATOS

### 📝 **Flujo Principal: Desde Reservación hasta Venta y Comisión**

```mermaid
graph LR
    A[Cliente solicita cita] --> B{Crear Reservación}
    B -- barber_id, client_id --> C[API: POST /api/reservations]
    C --> D[Frontend: Calendario muestra la reserva]
    D --> E{Completar Reservación}
    E -- Items de venta (servicios, productos, combos) --> F[API: POST /api/reservations/:id/complete]
    F -- Inicia Transacción --> G{1. Crea Venta (vinculada a reservation_id)}
    G --> H{2. Crea los Ítems de Venta}
    H --> I{3. Llama a updateStockFromSale}
    I -- Para cada ítem... --> J{Evalúa item_type}
    J -- Si es Combo --> K[Desempaca el combo y llama recursivamente a updateStockFromSale]
    J -- Si es Servicio --> L[Busca insumos y crea movimientos 'OUT']
    J -- Si es Producto --> M[Busca receta/link directo y crea movimientos 'OUT']
    K & L & M --> N{4. Actualiza estado de la Reserva a 'pagado'}
    N -- COMMIT Transacción --> O[Venta y Stock Actualizados]
    O --> P((Comisión generada para el barbero de la reserva))
```

### 🚶 **Flujo de Venta Directa (sin Comisión)**

```mermaid
graph LR
    A[Usuario hace clic en 'Nueva Venta' en Calendario] --> B{Abre DirectSaleModal}
    B -- client_id, items -- > C[API: POST /api/sales]
    C -- Inicia Transacción --> D{1. Crea Venta (reservation_id es NULL)}
    D --> E{2. Crea los Ítems de Venta}
    E --> F{3. Actualiza Stock (descuenta productos)}
    F -- COMMIT Transacción --> G[Venta y Stock Actualizados]
    G --> H((No se genera comisión, no hay barbero asociado))
```

### 🛒 **Flujo de Compras y Abastecimiento de Inventario (Mejorado)**

El proceso de registro de compras ha sido optimizado para mejorar la experiencia del usuario, permitiendo la creación de proveedores e ítems de inventario/productos de menú directamente desde el formulario de compra, sin necesidad de navegar a vistas separadas.

```mermaid
graph LR
    A[Admin inicia nueva Compra] --> B{Selecciona Proveedor}
    B -- Si no existe --> C[Crear Proveedor (integrado en selector)]
    C --> B
    B -- Selecciona Ítems de Compra --> D{Añade Detalle de Compra}
    D -- Si Ítem no existe --> E[Crear Ítem (integrado en selector de detalle)]
    E --> D
    D --> F[API: POST /api/purchases]
    F -- Inicia Transacción --> G{1. Crea la Compra}
    G --> H{2. Crea los Detalles de la Compra}
    H --> I{3. Actualiza Stock}
    I -- Por cada Ítem de Inventario en la compra... --> J{Incrementa stock del Ítem de Inventario}
    J -- COMMIT Transacción --> K[Compra registrada y Stock abastecido]
```

---

## 🛡️ AUTENTICACIÓN Y AUTORIZACIÓN

- **Autenticación**: Basada en **JWT**. El token se almacena en `localStorage` y se envía en el header `Authorization` de cada petición a través de un interceptor de Axios.
- **Autorización**: Basada en **roles** (`administrador`, `cajero`). El rol se incluye en el payload del JWT y es verificado en el backend por un middleware (`authorizeRoles`) para proteger rutas sensibles.
- **Protección de Rutas Frontend**: `router.beforeEach` en Vue Router previene el acceso a vistas protegidas si el usuario no está autenticado.
- **Manejo de Sesión Expirada**: Un interceptor de respuesta de Axios detecta errores 401 (No autorizado), cierra la sesión en el frontend (`authStore.logout()`) y redirige al usuario a la página de login.

---

## 📈 **MÉTRICAS Y KPIs DEL SISTEMA**

- **Financieras**: Ventas diarias/mensuales, desglose por servicios/productos, comisiones por barbero, valor total del inventario.
- **Operativas**: Tasa de ocupación de estaciones, frecuencia de clientes, horas pico de reservas, rendimiento por barbero.
- **Inventario**: Nivel de stock actual, productos por debajo del mínimo, historial de movimientos por ítem.

---

## 🚀 **TECNOLOGÍAS Y HERRAMIENTAS**

### **Backend**

- Node.js, Express.js, TypeScript, PostgreSQL, `pg`, JWT, Swagger, Day.js, Bcrypt, CORS, Dotenv, Nodemon.

### **Frontend**

- Vue.js 3, Pinia, Vue Router 4, Tailwind CSS, Axios, ApexCharts, Day.js, jsPDF, Vite.

### **Herramientas de Desarrollo**

- ESLint, Prettier, Jest (Backend), TS-Node (Backend), Cross-env (Backend).

---

## 📱 **CARACTERÍSTICAS TÉCNICAS**

- **Performance**: Paginación en listas largas, carga bajo demanda de rutas (Lazy Loading), consultas optimizadas con `Promise.all` en el backend, y un pool de conexiones a la base de datos para reutilización.
- **Responsive Design**: Uso de Tailwind CSS para un diseño `mobile-first` que se adapta a cualquier tamaño de pantalla.
- **Mantenibilidad**: Código modular y reutilizable, separación de responsabilidades, tipado estático con TypeScript, y manejo centralizado de estado (Pinia) y errores (interceptores de Axios).
- **Cierre Elegante de Recursos**: Gestión del ciclo de vida del pool de conexiones a la base de datos para evitar fugas de recursos en reinicios del servidor.
