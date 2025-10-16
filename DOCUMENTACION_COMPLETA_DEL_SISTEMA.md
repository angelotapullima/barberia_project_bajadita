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

-   **`database.ts`**: Configura y exporta una instancia de `Pool` (`dbPool`). Incluye `connectionTimeoutMillis` e `idleTimeoutMillis` para gestionar el ciclo de vida de las conexiones.
-   **`app.ts`**: Inicializa el pool de conexiones y realiza una conexión de prueba (`pool.connect()`) para asegurar que la base de datos esté accesible antes de configurar las rutas. **Importante:** Se ha corregido la liberación prematura del cliente (`client.release()`) en esta etapa para evitar problemas de conexión.
-   **`server.ts`**: Implementa manejadores para las señales de terminación del proceso (`SIGINT`, `SIGTERM`). Estos manejadores aseguran que el `dbPool` se cierre de forma elegante (`dbPool.end()`) cuando el servidor se detiene, liberando todas las conexiones y evitando errores de `db_termination` en reinicios.

### 🔗 ENDPOINTS DISPONIBLES

La API RESTful proporciona los siguientes endpoints, protegidos por autenticación JWT y, en algunos casos, por autorización basada en roles.

#### 🔐 Autenticación y Gestión de Usuarios (`/api/auth`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| POST | `/login` | Inicia sesión de un usuario, retorna JWT y datos del usuario. | - |
| GET | `/me` | Obtiene el perfil del usuario autenticado. | `authenticateToken` |
| PUT | `/change-password` | Cambia la contraseña del usuario autenticado. | `authenticateToken` |
| GET | `/users` | Lista todos los usuarios (solo Admin). | `authenticateToken`, `authorizeRoles('administrador')` |
| POST | `/users` | Crea un nuevo usuario (solo Admin). | `authenticateToken`, `authorizeRoles('administrador')` |
| PUT | `/users/:id` | Actualiza un usuario existente (solo Admin). | `authenticateToken`, `authorizeRoles('administrador')` |
| DELETE | `/users/:id` | Elimina un usuario (solo Admin). | `authenticateToken`, `authorizeRoles('administrador')` |

#### 📊 Dashboard (`/api/dashboard`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/summary` | Retorna un resumen de métricas clave para el dashboard (ventas, reservas, etc.). | `authenticateToken` |

#### 👨‍💼 Barberos (`/api/barbers`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/` | Lista todos los barberos activos. | `authenticateToken` |
| GET | `/:id` | Obtiene un barbero por su ID. | `authenticateToken` |
| POST | `/` | Crea un nuevo barbero. | `authenticateToken` |
| PUT | `/:id` | Actualiza un barbero existente. | `authenticateToken` |
| DELETE | `/:id` | Desactiva (soft delete) un barbero. | `authenticateToken` |
| POST | `/:id/advances` | Registra un adelanto de pago para un barbero. | `authenticateToken` |

#### 🪑 Estaciones (`/api/stations`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/` | Lista todas las estaciones activas. | `authenticateToken` |
| POST | `/` | Crea una nueva estación (máximo 10 estaciones). | `authenticateToken` |
| PUT | `/:id` | Actualiza una estación existente. | `authenticateToken` |
| DELETE | `/:id` | Desactiva (soft delete) una estación, con validación si tiene barberos asignados. | `authenticateToken` |

#### ✂️ Servicios (`/api/services`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/` | Lista todos los servicios activos con paginación. | `authenticateToken` |
| GET | `/:id` | Obtiene un servicio por su ID. | `authenticateToken` |
| POST | `/` | Crea un nuevo servicio (manejo de error 409 por nombre único). | `authenticateToken` |
| PUT | `/:id` | Actualiza un servicio existente (manejo de error 409 por nombre único). | `authenticateToken` |
| DELETE | `/:id` | Desactiva (soft delete) un servicio. | `authenticateToken` |

#### 🛍️ Productos (`/api/products`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/` | Lista todos los productos activos. | `authenticateToken` |
| GET | `/:id` | Obtiene un producto por su ID. | `authenticateToken` |
| POST | `/` | Crea un nuevo producto. | `authenticateToken` |
| PUT | `/:id` | Actualiza un producto existente. | `authenticateToken` |
| DELETE | `/:id` | Desactiva (soft delete) un producto. | `authenticateToken` |

#### 📅 Reservaciones (`/api/reservations`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/` | Lista todas las reservaciones con paginación y opción de incluir detalles de venta. | `authenticateToken` |
| GET | `/:id` | Obtiene una reservación por su ID con opción de incluir productos asociados. | `authenticateToken` |
| POST | `/` | Crea una nueva reservación. | `authenticateToken` |
| PUT | `/:id` | Actualiza una reservación existente. | `authenticateToken` |
| DELETE | `/:id` | Elimina una reservación y sus productos asociados. | `authenticateToken` |
| POST | `/:id/complete` | Completa una reservación y genera una venta. | `authenticateToken` |
| POST | `/:id/cancel` | Cancela una reservación. | `authenticateToken` |
| POST | `/:id/products` | Añade un producto a una reservación. | `authenticateToken` |
| DELETE | `/:id/products/:reservationProductId` | Elimina un producto de una reservación. | `authenticateToken` |
| GET | `/view/calendar` | Retorna datos de reservaciones, barberos y servicios para la vista de calendario, filtrable por fecha y estado. | `authenticateToken` |
| POST | `/fix-end-times` | Utilidad para corregir tiempos de finalización de reservas. | `authenticateToken` |

#### 💰 Ventas (`/api/sales`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| POST | `/` | Crea una nueva venta directa (sin reservación). | `authenticateToken` |
| GET | `/` | Lista todas las ventas con paginación y filtros por fecha y método de pago. | `authenticateToken` |
| GET | `/:id` | Obtiene una venta por su ID, incluyendo sus ítems. | `authenticateToken` |
| GET | `/by-reservation/:reservationId` | Obtiene una venta asociada a una reservación. | `authenticateToken` |

#### 💳 Pagos (`/api/payments`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/` | Listar pagos (comisiones finalizadas). | `authenticateToken` |
| PUT | `/:id` | Actualizar pago (ej. estado). | `authenticateToken` |

#### 🏪 Punto de Venta (`/api/pos`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/master-data` | Datos maestros del POS (servicios, productos, barberos). | `authenticateToken` |

#### 📈 Reportes (`/api/reports`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/comprehensive-sales` | Reporte comprensivo de ventas, filtrable por rango de fechas y método de pago. | `authenticateToken` |
| GET | `/services-products-sales` | Reporte de ventas por servicios y productos, filtrable por rango de fechas. | `authenticateToken` |
| GET | `/station-usage` | Reporte de uso de estaciones, filtrable por rango de fechas. | `authenticateToken` |
| GET | `/customer-frequency` | Reporte de frecuencia de clientes, filtrable por rango de fechas. | `authenticateToken` |
| GET | `/peak-hours` | Reporte de horas pico de actividad (reservas), filtrable por rango de fechas. | `authenticateToken` |
| GET | `/detailed-barber-service-sales` | Reporte detallado de ventas de servicios por barbero, filtrable por rango de fechas y barbero. | `authenticateToken` |

#### 💵 Comisiones de Barberos (`/api/barber-commissions`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/monthly-summary` | Resumen mensual de comisiones calculadas en vivo para todos los barberos. | `authenticateToken` |
| POST | `/finalize-payment` | Registra y finaliza un pago de comisiones para un barbero en un período específico. | `authenticateToken` |
| GET | `/:barberId/services` | Lista los servicios detallados realizados por un barbero en un mes específico. | `authenticateToken` |
| GET | `/:barberId/advances` | Lista los adelantos detallados de un barbero en un mes específico. | `authenticateToken` |

#### 📦 Inventario (`/api/inventory`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/summary` | Resumen del inventario actual (total productos, bajo stock, valor total). | `authenticateToken` |
| GET | `/movements` | Lista todos los movimientos de inventario, opcionalmente filtrados por producto. | `authenticateToken` |
| POST | `/movements` | Registra un nuevo movimiento de inventario (entrada/salida). | `authenticateToken` |

#### ⚙️ Configuración (`/api/settings`)
| Método | Endpoint | Descripción | Middleware |
|--------|----------|-------------|------------|
| GET | `/` | Obtiene todas las configuraciones del sistema. | `authenticateToken`, `authorizeRoles('administrador')` |
| PUT | `/` | Actualiza una o varias configuraciones del sistema. | `authenticateToken`, `authorizeRoles('administrador')` |
| GET | `/:key` | Obtiene una configuración específica por su clave. | `authenticateToken`, `authorizeRoles('administrador')` |

### Modelos de Datos (Interfaces TypeScript)

-   **`Barber`**: `id`, `name`, `email`, `phone`, `hire_date`, `base_salary`, `commission_rate`, `station_id`, `is_active`, `created_at`, `updated_at`.
-   **`Product`**: `id`, `name`, `description`, `price`, `stock_quantity`, `min_stock_level`, `category`, `is_active`, `created_at`, `updated_at`.
-   **`Reservation`**: `id`, `barber_id`, `station_id`, `service_id`, `client_name`, `client_phone`, `start_time`, `end_time`, `status`, `service_price`, `notes`, `created_at`, `updated_at`. Incluye campos opcionales para joins (`barber_name`, `station_name`, `service_name`, `products`).
-   **`ReservationProduct`**: `id`, `reservation_id`, `product_id`, `quantity`, `price_at_reservation`, `created_at`.
-   **`Sale`**: `id`, `reservation_id`, `barber_id`, `customer_name`, `service_amount`, `products_amount`, `total_amount`, `payment_method`, `sale_date`, `created_at`, `updated_at`. Incluye `items` opcional para detalles de ítems de venta.
-   **`SaleItem`**: `id`, `sale_id`, `item_type`, `item_id`, `item_name`, `quantity`, `unit_price`, `total_price`, `created_at`.
-   **`Service`**: `id`, `name`, `description`, `price`, `duration_minutes`, `is_active`, `created_at`, `updated_at`.
-   **`Station`**: `id`, `name`, `description`, `is_active`, `created_at`, `updated_at`.
-   **`User`**: `id`, `name`, `email`, `password` (hash), `role`.

---

## 🎨 FRONTEND - APLICACIÓN VUE.JS (ubicado en la carpeta `barberia_project_frontend`)

### Estructura de Directorios

La estructura del frontend está organizada para Vue.js 3 con Composition API y Pinia:

```
src/
├── assets/          # Archivos estáticos como imágenes o iconos.
├── components/      # Componentes Vue reutilizables (modales, tablas, selectores, etc.).
├── router/          # Configuración de Vue Router para la navegación.
├── services/        # Servicios JavaScript para interacción con la API (Axios) y otras utilidades.
├── stores/          # Módulos de Pinia para la gestión del estado global de la aplicación.
├── views/           # Componentes Vue que representan las pantallas/páginas principales de la aplicación.
├── App.vue          # Componente raíz de la aplicación.
├── main.js          # Punto de entrada de la aplicación Vue.
└── style.css        # Estilos globales de la aplicación (Tailwind CSS).
```

### 🛣️ RUTAS PRINCIPALES

La aplicación utiliza Vue Router para gestionar la navegación entre las diferentes vistas. Todas las rutas, excepto `/login`, requieren autenticación.

| Ruta | Vista | Nombre de Ruta | Descripción |
|------|-------|----------------|-------------|
| `/` | `DashboardView` | `Dashboard` | Panel principal con métricas y gráficos resumen. |
| `/login` | `LoginView` | `Login` | Página de inicio de sesión. |
| `/barbers` | `BarbersView` | `Barbers` | Gestión de barberos (CRUD). |
| `/stations` | `StationsView` | `Stations` | Gestión de estaciones de trabajo (CRUD). |
| `/services` | `ServicesView` | `Services` | Gestión de servicios ofrecidos (CRUD con paginación). |
| `/products` | `ProductsView` | `Products` | Gestión de productos (CRUD). |
| `/reservations` | `ReservationsView` | `Reservations` | Gestión de reservaciones (CRUD, paginación). |
| `/schedule` | `CalendarView` | `Schedule` | Vista de calendario semanal de citas. |
| `/sales` | `SalesView` | `SalesRegistration` | Registro y listado de ventas. |
| `/payments` | `BarberPaymentsReportView` | `Payments` | Resumen de pagos a barberos. |
| `/profile` | `ProfileView` | `Profile` | Perfil de usuario y cambio de contraseña. |
| `/settings` | `SettingsView` | `Settings` | Configuración del sistema y gestión de usuarios (solo Admin). |
| `/reports` | `ReportsView` | `Reports` | Página de inicio para la sección de reportes. |
| `/reports/inventory` | `InventoryReportView` | `InventoryReport` | Reporte de inventario (resumen y movimientos). |
| `/reports/station-usage` | `StationUsageReportView` | `StationUsageReport` | Reporte de uso de estaciones. |
| `/reports/customer-frequency` | `CustomerFrequencyReportView` | `CustomerFrequencyReport` | Reporte de frecuencia de clientes. |
| `/reports/peak-hours` | `PeakHoursReportView` | `PeakHoursReport` | Reporte de horas pico de reservas. |
| `/reports/sales/comprehensive` | `ComprehensiveSalesReportView` | `ComprehensiveSalesReport` | Reporte detallado de ventas. |
| `/reports/sales/by-type` | `ServicesProductsSalesReportView` | `ServicesProductsSalesReport` | Reporte de ventas por tipo (servicios/productos). |
| `/reports/barber-payments-detailed` | `BarberPaymentsReportView` | `BarberPaymentsReport` | Reporte detallado de pagos a barberos. |
| `/payment/confirm` | `PaymentConfirmationView` | `PaymentConfirm` | Confirmación y finalización de pago a barbero. |

### 🗃️ STORES DE PINIA

Pinia se utiliza para la gestión centralizada del estado de la aplicación, proporcionando stores modulares y reactivos.

-   **`authStore`**: Gestiona el estado de autenticación del usuario (token JWT, datos del usuario, roles). Incluye acciones para `login`, `logout` e `initializeStore` (para cargar datos de `localStorage`).
-   **`barberStore`**: Gestiona la lista de barberos, incluyendo acciones CRUD (`getAllBarbers`, `addBarber`, `updateBarber`, `deleteBarber`).
-   **`paymentStore`**: Almacena temporalmente la información de un pago de comisión seleccionado para la vista de confirmación (`selectedPaymentItem`, `detailedServices`, `detailedAdvances`).
-   **`productStore`**: Gestiona la lista de productos, incluyendo acciones CRUD (`fetchProducts`, `addProduct`, `updateProduct`, `deleteProduct`).
-   **`reportStore`**: Almacena los datos de los diversos reportes (`comprehensiveSales`, `servicesProductsSales`, `stationUsage`, `customerFrequency`, `peakHours`, etc.) y acciones para obtenerlos de la API.
-   **`reservationStore`**: Gestiona la lista de reservaciones, incluyendo acciones CRUD (`fetchReservations`, `addReservation`, `updateReservation`, `deleteReservation`), así como acciones específicas como `addProductToReservation`, `removeProductFromReservation`, `completeReservationAndCreateSale` y `cancelReservation`.
-   **`salesStore`**: Gestiona la lista de ventas, incluyendo acciones para `getAllSales`, `fetchSaleById`, `createDirectSale` y `fetchSaleByReservationId`.
-   **`serviceStore`**: Gestiona la lista de servicios, incluyendo acciones CRUD (`fetchServices`, `addService`, `updateService`, `deleteService`) y manejo de paginación (`setPage`, `setItemsPerPage`).
-   **`settingStore`**: Gestiona las configuraciones del sistema (`fetchAllSettings`, `updateSetting`).
-   **`stationStore`**: Gestiona la lista de estaciones, incluyendo acciones CRUD (`fetchStations`, `addStation`, `updateStation`, `deleteStation`).
-   **`userStore`**: Gestiona la lista de usuarios (solo para administradores), incluyendo acciones CRUD (`fetchUsers`, `createUser`, `updateUser`, `deleteUser`).

### Componentes Reutilizables

-   **`BarberAdvanceModal.vue`**: Modal para registrar adelantos de pago a barberos.
-   **`Breadcrumbs.vue`**: Componente de navegación tipo "migas de pan".
-   **`CustomSelect.vue`**: Componente de selector (`<select>`) estilizado.
-   **`Modal.vue`**: Componente base para modales, con manejo de cierre por `Escape` y click fuera.
-   **`PaginationControls.vue`**: Controles de paginación para tablas.
-   **`ReservationCancelModal.vue`**: Modal de confirmación para cancelar una reserva.
-   **`ReservationFormModal.vue`**: Modal para crear o editar una reserva. **Importante:** Se ha ajustado para que las horas de inicio y fin se construyan y envíen al backend en formato UTC (`dayjs.utc()`) para evitar problemas de zona horaria.
-   **`ReservationRejectModal.vue`**: Modal de confirmación para rechazar una reserva.
-   **`SaleDetailsModal.vue`**: Modal para mostrar los detalles de una venta.
-   **`SaleRegistrationModal.vue`**: Modal para registrar ventas (directas o desde reserva), permitiendo añadir servicios y productos.
-   **`Sidebar.vue`**: Barra lateral de navegación principal de la aplicación.
-   **`TablaBarberia.vue`**: Componente genérico de tabla para mostrar listas de datos con acciones de edición/eliminación y paginación.

### Manejo de Fechas y Horas (UTC)

Para asegurar la consistencia y evitar problemas de zona horaria entre el frontend y el backend, todas las fechas y horas se manejan en UTC.

-   En `CalendarView.vue`, las funciones `formatTime` y `getAppointmentStyle` utilizan `dayjs.utc()` para interpretar y mostrar las horas de las reservas directamente en UTC, y para calcular la posición de los eventos en el calendario basándose en la hora UTC.
-   En `ReservationFormModal.vue`, al crear o actualizar una reserva, `start_time` y `end_time` se construyen utilizando `dayjs.utc()` a partir de la fecha y hora seleccionadas por el usuario, y luego se convierten a formato ISO 8601 (UTC) antes de ser enviadas al backend.

---

## 📱 FUNCIONALIDADES POR PANTALLA

### 1. 🏠 **Dashboard** (`/`)
**Endpoint Principal:** `GET /api/dashboard/summary`

**Funcionalidades:**
-   ✅ Tarjetas de métricas en tiempo real: Ventas de productos (hoy), Ventas de servicios (hoy), Reservas para hoy, Clientes atendidos (hoy), Ingresos del mes.
-   ✅ Gráfico de área: Ventas de productos (últimos 30 días).
-   ✅ Gráfico de área: Ventas de servicios (últimos 30 días).
-   ✅ Tabla de pagos a barberos del mes actual.
-   ✅ Gráfico donut: Servicios populares de la semana.

**Lógica de Negocio:**
-   Se actualiza automáticamente al cargar la página.
-   Los datos se obtienen del endpoint de dashboard que consolida información de múltiples tablas.

### 2. 🔐 **Login** (`/login`)
**Endpoint:** `POST /api/auth/login`

**Funcionalidades:**
-   ✅ Formulario de inicio de sesión (email/password).
-   ✅ Validación de credenciales.
-   ✅ Almacenamiento del token JWT en `localStorage`.
-   ✅ Redirección automática al dashboard tras un login exitoso.

**Lógica de Negocio:**
-   Utiliza JWT para autenticación.
-   El token se guarda en `localStorage` y se adjunta automáticamente a las peticiones HTTP a través de un interceptor de Axios.
-   Un `router.beforeEach` en Vue Router verifica el estado de autenticación antes de permitir el acceso a rutas protegidas.

### 3. 👨‍💼 **Barberos** (`/barbers`)
**Endpoints:**
-   `GET /api/barbers` - Listar
-   `POST /api/barbers` - Crear
-   `PUT /api/barbers/:id` - Actualizar
-   `DELETE /api/barbers/:id` - Eliminar (soft delete)
-   `POST /api/barbers/:id/advances` - Crear adelanto

**Funcionalidades:**
-   ✅ Lista completa de barberos con tabla responsive.
-   ✅ Modal para crear/editar barberos con campos: nombre, email, teléfono, fecha de contratación, sueldo base, tasa de comisión, estación asignada, estado activo.
-   ✅ Eliminación lógica (desactivación) con confirmación.
-   ✅ Vista móvil adaptativa.

**Lógica de Negocio:**
-   Cada barbero puede tener una estación asignada.
-   Los barberos inactivos no aparecen en las selecciones de otros módulos.
-   El sueldo base y la tasa de comisión se usan para calcular comisiones.

### 4. 🪑 **Estaciones** (`/stations`)
**Endpoints:**
-   `GET /api/stations` - Listar
-   `POST /api/stations` - Crear
-   `PUT /api/stations/:id` - Actualizar
-   `DELETE /api/stations/:id` - Eliminar (soft delete)

**Funcionalidades:**
-   ✅ CRUD completo de estaciones de trabajo.
-   ✅ Validación para evitar la eliminación si hay barberos activos asignados a la estación.

### 5. ✂️ **Servicios** (`/services`)
**Endpoints:**
-   `GET /api/services` - Listar (con paginación)
-   `POST /api/services` - Crear
-   `PUT /api/services/:id` - Actualizar
-   `DELETE /api/services/:id` - Eliminar (soft delete)

**Funcionalidades:**
-   ✅ Gestión de servicios ofrecidos por la barbería.
-   ✅ Tabla con paginación: Muestra los servicios, incluyendo nombre, descripción, precio, duración y estado activo.
-   ✅ Modal de creación/edición: Permite añadir nuevos servicios o editar existentes con campos para nombre, descripción, precio, duración y estado activo.

**Lógica de Negocio:**
-   El precio y la duración se utilizan en el módulo de reservaciones y ventas.
-   Los servicios inactivos no se muestran en las selecciones.

### 6. 🛍️ **Productos** (`/products`)
**Endpoints:**
-   `GET /api/products` - Listar
-   `POST /api/products` - Crear
-   `PUT /api/products/:id` - Actualizar
-   `DELETE /api/products/:id` - Eliminar (soft delete)

**Funcionalidades:**
-   ✅ Inventario de productos para venta.
-   ✅ Campos: nombre, descripción, precio, stock actual, stock mínimo, categoría, estado activo.
-   ✅ Control de stock automático (a través de movimientos de inventario).

**Lógica de Negocio:**
-   El stock se actualiza automáticamente con las ventas.
-   Se pueden generar alertas cuando el stock está por debajo del mínimo.

### 7. 📅 **Reservaciones** (`/reservations`)
**Endpoints:**
-   `GET /api/reservations` - Listar (con paginación)
-   `POST /api/reservations` - Crear
-   `PUT /api/reservations/:id` - Actualizar
-   `DELETE /api/reservations/:id` - Eliminar
-   `POST /api/reservations/:id/complete` - Completar → venta
-   `POST /api/reservations/:id/cancel` - Cancelar

**Funcionalidades:**
-   ✅ Formulario de nueva reservación (cliente, barbero, estación, servicio, horario, notas, teléfono).
-   ✅ Lista de reservaciones con filtros y paginación.
-   ✅ Estados: `reservado`, `pagado`, `cancelado`.
-   ✅ Completar reservación genera venta automática.
-   ✅ Posibilidad de añadir productos a una reservación.

**Lógica de Negocio:**
-   Las reservaciones bloquean tiempo en el calendario.
-   Al completarse, se crea una venta automáticamente, actualizando el stock de productos.
-   Las horas de inicio y fin se manejan en UTC para evitar inconsistencias.

### 8. 🗓️ **Calendario** (`/schedule`)
**Endpoint:** `GET /api/reservations/view/calendar`

**Funcionalidades:**
-   ✅ Vista de calendario semanal con navegación por semanas y días.
-   ✅ Filtro por barbero o vista general.
-   ✅ Añadir cita directamente desde una celda de tiempo libre en el calendario.
-   ✅ Visualización de reservaciones como bloques de tiempo con colores distintivos por barbero y estado.
-   ✅ Indicador de la hora actual.

**Lógica de Negocio:**
-   Muestra reservaciones como bloques de tiempo, calculando su posición y duración en base a la hora UTC.
-   Un clic en una hora libre abre el modal de nueva cita, pre-rellenando la fecha y hora seleccionadas (en UTC).

### 9. 💰 **Ventas** (`/sales`)
**Endpoints:**
-   `POST /api/sales` - Crear venta directa
-   `GET /api/sales` - Listar ventas (con paginación y filtros)
-   `GET /api/sales/:id` - Obtener venta por ID
-   `GET /api/sales/by-reservation/:reservationId` - Obtener venta por reservación

**Funcionalidades:**
-   ✅ Lista de todas las ventas con filtros por rango de fechas y método de pago.
-   ✅ Modal para registrar ventas directas (sin reservación previa), permitiendo añadir servicios y productos.
-   ✅ Modal para ver detalles de venta (ítems, montos, cliente, barbero, método de pago).

**Lógica de Negocio:**
-   Las ventas pueden originarse de reservaciones completadas o ser ventas directas.
-   Cada venta registra servicios y productos por separado, actualizando el stock de productos.

### 10. 💵 **Pagos a Barberos** (`/payments`)
**Endpoints:**
-   `GET /api/barber-commissions/monthly-summary`
-   `POST /api/barber-commissions/finalize-payment`
-   `GET /api/barber-commissions/:barberId/services`
-   `GET /api/barber-commissions/:barberId/advances`

**Funcionalidades:**
-   ✅ Resumen mensual de comisiones por barbero, con estado (pendiente/pagado).
-   ✅ Detalle de servicios realizados y adelantos tomados por barbero en un período.
-   ✅ Cálculo automático de comisiones basado en reglas de negocio (sueldo base vs. ventas de servicios).
-   ✅ Registro de adelantos.
-   ✅ Finalización de pagos, generando un registro de pago y una boleta en PDF.

**Lógica de Negocio:**
-   **Cálculo de Comisión:** Si las ventas de servicios del barbero superan el doble de su sueldo base, se aplica una tasa de comisión personalizada. De lo contrario, solo recibe el sueldo base.
-   **Pago Final:** Comisión calculada - Adelantos del mes.
-   **Estados:** `pending`, `paid`.
-   **Boleta de Pago:** Generación de PDF con `jsPDF` y `jspdf-autotable`.

### 11. 📊 **Reportes** (`/reports/*`)
**Endpoints:** Ver sección "Reportes" en Endpoints Disponibles.

**Funcionalidades:**
-   ✅ Múltiples vistas de reportes interactivos con filtros por fecha.
-   ✅ Gráficos con ApexCharts para visualización de datos.
-   ✅ Exportación de datos a CSV.
-   **Reportes disponibles:**
    -   Inventario (resumen, bajo stock, movimientos).
    -   Uso de Estaciones (reservas completadas por estación).
    -   Frecuencia de Clientes (visitas por cliente).
    -   Horas Pico (actividad por hora del día).
    -   Ventas Detallado (ventas individuales).
    -   Ventas por Tipo (servicios vs. productos, con comparación de períodos).
    -   Pagos a Barberos (resumen y detalle).

---

## 🧠 LÓGICA DE NEGOCIO POR MÓDULO

### 🔐 **Módulo de Autenticación y Usuarios**
1.  **Login**: Verifica credenciales (email/password), hashea la contraseña con Bcrypt, genera un JWT con `id`, `email` y `role`, y lo retorna.
2.  **Middleware `authenticateToken`**: Valida el JWT en cada petición, decodifica la información del usuario y la adjunta a `req.user`.
3.  **Middleware `authorizeRoles`**: Verifica si el `req.user.role` está incluido en los roles permitidos para una ruta específica.
4.  **Roles**: `administrador` (acceso completo, gestión de usuarios y configuración), `cajero` (acceso a funcionalidades operativas).
5.  **Gestión de Usuarios**: CRUD completo de usuarios, solo accesible por administradores. Las contraseñas se hashean antes de almacenarse.

### 👨‍💼 **Módulo de Barberos**
1.  **Gestión**: CRUD básico de barberos.
2.  **Estación**: Cada barbero tiene una `station_id` asignada.
3.  **Comisiones**: Calculadas dinámicamente en el servicio `barberCommissions.service.ts` basado en las ventas de servicios y el sueldo base.
4.  **Adelantos**: Se pueden registrar adelantos de pago que se descuentan del pago final de comisiones.
5.  **Estado**: `is_active` permite la desactivación lógica de barberos.

### 📅 **Módulo de Reservaciones**
1.  **Creación**: Requiere `barber_id`, `station_id`, `service_id`, `client_name`, `start_time`, `end_time`. `service_price` y `end_time` se calculan automáticamente en el backend.
2.  **Estados**: `reservado` (inicial), `pagado` (tras completar y generar venta), `cancelado`.
3.  **Productos en Reserva**: Se pueden añadir productos a una reserva, registrando la cantidad y el precio del producto en el momento de la adición.
4.  **Calendario**: La vista de calendario (`CalendarView.vue`) muestra las reservas, calculando la posición y duración de los eventos en base a la hora UTC.
5.  **Conversión a Venta**: Al completar una reserva, se genera una venta automáticamente, incluyendo el servicio principal y los productos añadidos a la reserva.

### 💰 **Módulo de Ventas**
1.  **Origen**: Pueden ser generadas al completar una reservación o ser ventas directas (sin reservación).
2.  **Composición**: Una venta puede incluir uno o varios `SaleItem`s, que pueden ser servicios o productos.
3.  **Cálculo de Montos**: `service_amount` y `products_amount` se calculan por separado, sumando al `total_amount`.
4.  **Métodos de Pago**: `cash`, `card`, `transfer`, etc.
5.  **Actualización de Stock**: La venta de productos actualiza automáticamente el `stock_quantity` en el inventario.

### 📊 **Módulo de Reportes**
1.  **Dashboard**: Proporciona una visión general en tiempo real de métricas clave.
2.  **Ventas**: Análisis detallado por períodos, tipos de ítems (servicios/productos), y métodos de pago.
3.  **Barberos**: Reportes de comisiones y ventas de servicios por barbero.
4.  **Inventario**: Resumen de stock, productos con bajo stock y movimientos históricos.
5.  **Clientes**: Análisis de frecuencia de visitas.
6.  **Operativo**: Reportes de uso de estaciones y horas pico.

---

## 🔄 FLUJO DE DATOS

### 📝 **Flujo Principal: Desde Reservación hasta Pago**

```mermaid
graph LR
    A[Cliente solicita cita] --> B{Crear Reservación}
    B -- Datos de Cliente, Barbero, Servicio, Estación, Horario --> C[API: POST /api/reservations]
    C -- Reserva Creada (status: 'reservado') --> D[Frontend: Calendario / Lista de Reservas]
    D -- Barbero atiende / Servicio finalizado --> E{Completar Reservación}
    E -- Método de Pago --> F[API: POST /api/reservations/:id/complete]
    F -- Genera Venta (status: 'pagado') --> G[API: POST /api/sales]
    G -- Venta Creada --> H[Actualizar Stock de Productos]
    H -- Stock Actualizado --> I[Registrar en Dashboard / Reportes]
    I -- Datos para Cálculo de Comisión --> J[API: GET /api/barber-commissions/monthly-summary]
    J -- Resumen de Comisiones --> K[Frontend: Pagos a Barberos]
    K -- Confirmar Pago --> L[API: POST /api/barber-commissions/finalize-payment]
    L -- Pago Finalizado --> M[Generar Boleta de Pago (PDF)]
```

### 🔄 **Flujo de Estados de Reservación**

```
PENDIENTE (inicial)
    ↓
RESERVADO (confirmada)
    ↓
EN PROCESO (opcional, no implementado explícitamente en el modelo actual)
    ↓
PAGADO (al completar y generar venta)
    ↓
CANCELADO (por el cliente o administración)
```

### 💸 **Flujo de Cálculo de Comisiones**

```
Venta de Servicio (registrada en 'sales' y 'sale_items')
    ↓
Servicio 'barberCommissions.service.ts'
    ↓
Evalúa: ¿Total Ventas de Servicios del Barbero >= (Sueldo Base * 2)?
    ↓
SI: Comisión = Total Ventas de Servicios * Tasa de Comisión del Barbero
NO: Comisión = Sueldo Base del Barbero
    ↓
Pago Bruto = Comisión Calculada
    ↓
Adelantos del Mes (registrados en 'barber_advances')
    ↓
Pago Final = Pago Bruto - Total Adelantos
```

---

## 🛡️ AUTENTICACIÓN Y AUTORIZACIÓN

### 🔑 **Sistema de Autenticación**
-   **JWT (JSON Web Tokens)**: Utilizado para autenticación sin estado. Los tokens se generan en el backend (`auth.service.ts`) y se verifican mediante el middleware `authenticateToken`.
-   **Almacenamiento**: El token JWT y los datos básicos del usuario se almacenan en `localStorage` en el frontend (`authStore.js`).
-   **Expiración**: Los tokens tienen un tiempo de vida limitado (8 horas). El interceptor de respuesta de Axios en `api.js` maneja la expiración o la invalidez del token, cerrando la sesión del usuario y redirigiéndolo a la página de login.
-   **Interceptors**: Axios intercepta automáticamente las peticiones salientes para añadir el token JWT en el encabezado `Authorization`.

### 👥 **Roles y Permisos**
-   **Administrador**: Acceso completo a todas las funcionalidades, incluyendo la gestión de usuarios y configuraciones del sistema.
-   **Cajero**: Acceso a funcionalidades operativas como la gestión de reservas, ventas, barberos, estaciones, servicios y productos, pero sin acceso a la gestión de usuarios o configuraciones sensibles.
-   El rol se almacena en el JWT y se verifica mediante el middleware `authorizeRoles`.

### 🛡️ **Middleware de Seguridad**
-   `authenticateToken`: Middleware de Express que verifica la validez del JWT. Si es válido, decodifica el token y adjunta la información del usuario (`id`, `email`, `role`) al objeto `req`.
-   `authorizeRoles`: Middleware de Express que toma una lista de roles permitidos y verifica si el rol del usuario autenticado (`req.user.role`) está incluido en esa lista. Si no, deniega el acceso con un estado 403.

### 🔒 **Rutas Protegidas**
-   Todas las rutas de la API requieren autenticación (`authenticateToken`) excepto `/auth/login`.
-   Rutas sensibles (ej. `/api/settings`, `/api/auth/users`) están protegidas adicionalmente con `authorizeRoles('administrador')`.
-   En el frontend, `router.beforeEach` en `router/index.js` verifica la autenticación antes de permitir la navegación a cualquier ruta que no sea `/login`.

---

## 📈 **MÉTRICAS Y KPIs DEL SISTEMA**

### 📊 **Dashboard Principal**
-   **Ventas Diarias**: Desglose de ventas de servicios y productos para el día actual.
-   **Reservas del Día**: Conteo de reservas próximas y completadas para el día actual.
-   **Clientes Atendidos**: Conteo de reservas completadas para el día actual.
-   **Ingresos Mensuales**: Total de ventas acumuladas en el mes actual.
-   **Servicios Más Populares**: Gráfico de los servicios más vendidos en la última semana.
-   **Tendencia de Ventas**: Gráficos de área mostrando las ventas diarias de productos y servicios en los últimos 30 días.

### 💰 **Métricas Financieras**
-   **Total de Ventas por Período**: Reportes detallados de ventas con filtros por fecha.
-   **Comisiones por Barbero**: Cálculo dinámico y resumen mensual de comisiones, incluyendo adelantos.
-   **Rentabilidad por Servicio/Producto**: Implícito en los reportes de ventas por tipo.
-   **Control de Gastos**: Registro de adelantos a barberos.

### 👥 **Métricas Operativas**
-   **Utilización de Estaciones**: Reporte de cuántas reservas completadas se realizaron por estación.
-   **Frecuencia de Clientes**: Reporte de cuántas veces un cliente ha visitado la barbería en un período.
-   **Horas Pico de Actividad**: Identificación de las horas del día con mayor número de reservas.
-   **Performance por Barbero**: Implícito en los reportes de comisiones y ventas detalladas por barbero.

---

## 🚀 **TECNOLOGÍAS Y HERRAMIENTAS**

### **Backend**
-   **Node.js**: Entorno de ejecución JavaScript.
-   **Express.js**: Framework web para Node.js.
-   **TypeScript**: Lenguaje de programación tipado.
-   **PostgreSQL**: Base de datos relacional.
-   **`pg`**: Cliente de PostgreSQL para Node.js.
-   **JWT**: JSON Web Tokens para autenticación.
-   **Swagger-jsdoc & Swagger-ui-express**: Documentación de API.
-   **Day.js**: Manipulación de fechas.
-   **Bcrypt**: Hashing de contraseñas.
-   **CORS**: Middleware para habilitar CORS.
-   **Dotenv**: Carga de variables de entorno.
-   **Nodemon**: Utilidad para desarrollo.

### **Frontend**
-   **Vue.js 3**: Framework progresivo.
-   **Pinia**: Gestión de estado.
-   **Vue Router 4**: Enrutamiento.
-   **Tailwind CSS**: Framework CSS.
-   **Axios**: Cliente HTTP.
-   **ApexCharts & Vue3-Apexcharts**: Librería de gráficos.
-   **Day.js**: Manipulación de fechas.
-   **jsPDF & jspdf-autotable**: Generación de PDFs.
-   **Vite**: Herramienta de construcción.

### **Herramientas de Desarrollo**
-   **ESLint**: Linter para código JavaScript/TypeScript.
-   **Prettier**: Formateador de código.
-   **Jest**: Framework de testing (para Backend).
-   **TS-Node**: Ejecución de TypeScript directamente (para Backend).
-   **Cross-env**: Configuración de variables de entorno (para tests de Backend).

---

## 📱 **CARACTERÍSTICAS TÉCNICAS**

### ⚡ **Performance**
-   **Lazy Loading de Rutas**: En el frontend, las rutas se cargan bajo demanda para reducir el tiempo de carga inicial.
-   **Paginación**: Implementada en listas largas (servicios, reservas, ventas) para optimizar la carga de datos.
-   **Consultas Optimizadas**: Uso de `Promise.all` en el backend para ejecutar múltiples consultas a la base de datos en paralelo, reduciendo la latencia.
-   **Pool de Conexiones DB**: Gestión eficiente de las conexiones a la base de datos para reducir la sobrecarga de establecer nuevas conexiones.

### 📱 **Responsive Design**
-   **Mobile-first approach**: El diseño se concibe primero para dispositivos móviles y luego se adapta a pantallas más grandes.
-   **Breakpoints adaptativos**: Utilización de Tailwind CSS para un diseño que se ajusta a diferentes tamaños de pantalla.
-   **Navegación touch-friendly**: Componentes de navegación adaptados para interacción táctil.
-   **Tablas responsivas**: Las tablas se adaptan o se transforman en vistas de tarjeta en dispositivos móviles.

### 🔧 **Mantenibilidad**
-   **Código Modular y Reutilizable**: Separación clara de componentes, servicios, stores y módulos en el frontend y backend.
-   **Separación de Responsabilidades**: Adherencia a principios SOLID y patrones de diseño para una lógica clara y fácil de entender.
-   **Documentación Completa**: Este documento sirve como referencia central para el entendimiento del sistema.
-   **Tipado Estático (TypeScript)**: Mejora la legibilidad, detecta errores en tiempo de desarrollo y facilita el refactoring.
-   **Manejo Centralizado de Errores**: Interceptores de Axios en el frontend y middlewares de Express en el backend para un manejo consistente de errores.
-   **Cierre Elegante de Recursos**: Gestión del ciclo de vida del pool de conexiones a la base de datos para evitar fugas de recursos.

---

Este sistema de barbería ofrece una solución completa para la gestión operativa y administrativa, desde la agenda de citas y el control de inventario hasta el cálculo de comisiones y la generación de reportes, todo ello con una interfaz moderna, robusta y fácil de usar.