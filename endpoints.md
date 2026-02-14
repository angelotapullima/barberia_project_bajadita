# Catálogo de Endpoints de la API Backend - Sistema de Gestión de Barbería

Este documento detalla todos los endpoints disponibles en la API RESTful del backend, proporcionando información sobre sus métodos HTTP, rutas, descripciones, middlewares de seguridad, y ejemplos de cuerpos de solicitud/respuesta cuando son relevantes.

La URL base para todos los endpoints es `/api`.

---

## 🔐 Autenticación y Gestión de Usuarios

### Autenticación

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `POST` | `/auth/login` | Inicia sesión de un usuario y retorna un token JWT y datos del usuario. | Ninguno | `{"email": "string", "password": "string"}` | `{"token": "string", "user": {"id": number, "first_name": "string", "email": "string", "role": "string"}}` |
| `GET` | `/auth/me` | Obtiene el perfil del usuario autenticado. | `authenticateToken` | Ninguno | `{"id": number, "first_name": "string", "email": "string", "role": "string"}` |
| `PUT` | `/auth/change-password` | Cambia la contraseña del usuario autenticado. | `authenticateToken` | `{"oldPassword": "string", "newPassword": "string"}` | `{"message": "Contraseña actualizada exitosamente."}` |

### Gestión de Personas

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/persons` | Obtiene una lista paginada de todas las personas. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Person], "total": number, "page": number, "limit": number}` |
| `GET` | `/persons/:id` | Obtiene los detalles de una persona por su ID. | `authenticateToken` | Ninguno | `Person` |
| `POST` | `/persons` | Crea una nueva persona. | `authenticateToken` | `{"dni": "string", "first_name": "string", "last_name": "string", "email": "string", "phone": "string", "address": "string", "birth_date": "YYYY-MM-DD"}` | `Person` (con `id`) |
| `PUT` | `/persons/:id` | Actualiza una persona existente por su ID. | `authenticateToken` | `{"dni"?: "string", "first_name"?: "string", ...}` | `Person` (actualizada) |
| `DELETE` | `/persons/:id` | Elimina una persona por su ID. | `authenticateToken` | Ninguno | `{"message": "Persona eliminada exitosamente."}` |

### Gestión de Usuarios

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/users` | Obtiene una lista de todos los usuarios del sistema. | `authenticateToken`, `authorizeRoles('administrador')` | Ninguno | `[User]` |
| `POST` | `/users` | Crea un nuevo usuario en el sistema. | `authenticateToken`, `authorizeRoles('administrador')` | `{"person_id": number, "password": "string", "role": "string"}` | `User` (con `id`) |
| `PUT` | `/users/:id` | Actualiza los datos de un usuario específico por su ID. | `authenticateToken`, `authorizeRoles('administrador')` | `{"first_name"?: "string", "email"?: "string", "role"?: "string"}` | `User` (actualizado) |
| `DELETE` | `/users/:id` | Elimina un usuario del sistema por su ID. | `authenticateToken`, `authorizeRoles('administrador')` | Ninguno | `{"message": "Usuario eliminado exitosamente."}` |

---

## 💈 Gestión de Barbería

### Barberos

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/barbers` | Obtiene una lista de todos los barberos. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Barber], "total": number, "page": number, "limit": number}` |
| `GET` | `/barbers/:id` | Obtiene un barbero por su ID. | `authenticateToken` | Ninguno | `Barber` |
| `POST` | `/barbers` | Crea un nuevo barbero. | `authenticateToken` | `{"person_id": number, "hire_date": "YYYY-MM-DD", "base_salary": number, "commission_rate": number, "is_active": boolean, "station_id": number}` | `Barber` (con `id`) |
| `PUT` | `/barbers/:id` | Actualiza un barbero existente. | `authenticateToken` | `{"hire_date"?: "YYYY-MM-DD", "base_salary"?: number, ...}` | `Barber` (actualizado) |
| `DELETE` | `/barbers/:id` | Elimina (desactiva) un barbero por su ID. | `authenticateToken` | Ninguno | `{"message": "Barbero eliminado exitosamente."}` |
| `POST` | `/barbers/:id/advances` | Registra un adelanto para un barbero. | `authenticateToken` | `{"amount": number, "date": "YYYY-MM-DD", "notes": "string"}` | `BarberAdvance` (con `id`) |

### Estaciones

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/stations` | Obtiene una lista de todas las estaciones. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Station], "total": number, "page": number, "limit": number}` |
| `GET` | `/stations/:id` | Obtiene una estación por su ID. | `authenticateToken` | Ninguno | `Station` |
| `POST` | `/stations` | Crea una nueva estación. | `authenticateToken` | `{"name": "string", "description": "string", "is_active": boolean}` | `Station` (con `id`) |
| `PUT` | `/stations/:id` | Actualiza una estación existente. | `authenticateToken` | `{"name"?: "string", "description"?: "string", ...}` | `Station` (actualizada) |
| `DELETE` | `/stations/:id` | Elimina una estación por su ID. | `authenticateToken` | Ninguno | `{"message": "Estación eliminada exitosamente."}` |

### Servicios

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/services` | Obtiene una lista de todos los servicios. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Service], "total": number, "page": number, "limit": number}` |
| `GET` | `/services/:id` | Obtiene un servicio por su ID. | `authenticateToken` | Ninguno | `Service` |
| `POST` | `/services` | Crea un nuevo servicio. | `authenticateToken` | `{"name": "string", "description": "string", "duration_minutes": number, "price": number, "is_active": boolean, "supplies": [ServiceSupply]}` | `Service` (con `id`) |
| `PUT` | `/services/:id` | Actualiza un servicio existente. | `authenticateToken` | `{"name"?: "string", "description"?: "string", ...}` | `Service` (actualizado) |
| `DELETE` | `/services/:id` | Elimina (desactiva) un servicio por su ID. | `authenticateToken` | Ninguno | `{"message": "Servicio eliminado exitosamente."}` |

---

## 📦 Inventario y Productos

### Tipos de Unidad

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/unit-types` | Obtiene una lista de todos los tipos de unidad. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [UnitType], "total": number, "page": number, "limit": number}` |
| `GET` | `/unit-types/:id` | Obtiene un tipo de unidad por su ID. | `authenticateToken` | Ninguno | `UnitType` |
| `POST` | `/unit-types` | Crea un nuevo tipo de unidad. | `authenticateToken` | `{"name": "string", "description": "string"}` | `UnitType` (con `id`) |
| `PUT` | `/unit-types/:id` | Actualiza un tipo de unidad existente. | `authenticateToken` | `{"name"?: "string", "description"?: "string"}` | `UnitType` (actualizado) |
| `DELETE` | `/unit-types/:id` | Elimina un tipo de unidad por su ID. | `authenticateToken` | Ninguno | `{"message": "Tipo de unidad eliminado exitosamente."}` |

### Categorías de Ítems

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/item-categories` | Obtiene una lista de todas las categorías de ítems. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [ItemCategory], "total": number, "page": number, "limit": number}` |
| `GET` | `/item-categories/:id` | Obtiene una categoría de ítem por su ID. | `authenticateToken` | Ninguno | `ItemCategory` |
| `POST` | `/item-categories` | Crea una nueva categoría de ítem. | `authenticateToken` | `{"name": "string", "description": "string"}` | `ItemCategory` (con `id`) |
| `PUT` | `/item-categories/:id` | Actualiza una categoría de ítem existente. | `authenticateToken` | `{"name"?: "string", "description"?: "string"}` | `ItemCategory` (actualizado) |
| `DELETE` | `/item-categories/:id` | Elimina una categoría de ítem por su ID. | `authenticateToken` | Ninguno | `{"message": "Categoría de ítem eliminada exitosamente."}` |

### Ubicaciones

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/locations` | Obtiene una lista de todas las ubicaciones. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Location], "total": number, "page": number, "limit": number}` |
| `GET` | `/locations/:id` | Obtiene una ubicación por su ID. | `authenticateToken` | Ninguno | `Location` |
| `POST` | `/locations` | Crea una nueva ubicación. | `authenticateToken` | `{"name": "string", "description": "string"}` | `Location` (con `id`) |
| `PUT` | `/locations/:id` | Actualiza una ubicación existente. | `authenticateToken` | `{"name"?: "string", "description"?: "string"}` | `Location` (actualizada) |
| `DELETE` | `/locations/:id` | Elimina una ubicación por su ID. | `authenticateToken` | Ninguno | `{"message": "Ubicación eliminada exitosamente."}` |

### Ítems de Inventario

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/inventory-items` | Obtiene una lista de todos los ítems de inventario. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [InventoryItem], "total": number, "page": number, "limit": number}` |
| `GET` | `/inventory-items/:id` | Obtiene un ítem de inventario por su ID. | `authenticateToken` | Ninguno | `InventoryItem` |
| `POST` | `/inventory-items` | Crea un nuevo ítem de inventario. | `authenticateToken` | `{"sku": "string", "name": "string", "description": "string", "item_type": "enum", "category_id": number, "unit_id": number, "consumption_unit_id": number, "conversion_factor": number, "min_stock": number, "is_trackable": boolean, "is_active": boolean}` | `InventoryItem` (con `id`) |
| `PUT` | `/inventory-items/:id` | Actualiza un ítem de inventario existente. | `authenticateToken` | `{"sku"?: "string", "name"?: "string", ...}` | `InventoryItem` (actualizado) |
| `DELETE` | `/inventory-items/:id` | Elimina (desactiva) un ítem de inventario por su ID. | `authenticateToken` | Ninguno | `{"message": "Ítem de inventario eliminado exitosamente."}` |

### Productos del Menú

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/menu-products` | Obtiene una lista de todos los productos del menú. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [MenuProduct], "total": number, "page": number, "limit": number}` |
| `GET` | `/menu-products/:id` | Obtiene un producto del menú por su ID. | `authenticateToken` | Ninguno | `MenuProduct` |
| `POST` | `/menu-products` | Crea un nuevo producto del menú (puede incluir `product_recipes`). | `authenticateToken` | `{"name": "string", "description": "string", "price": number, "category": "string", "inventory_item_id": number, "is_active": boolean, "recipes": [ProductRecipe]}` | `MenuProduct` (con `id`) |
| `PUT` | `/menu-products/:id` | Actualiza un producto del menú existente (puede actualizar `product_recipes`). | `authenticateToken` | `{"name"?: "string", "description"?: "string", ...}` | `MenuProduct` (actualizado) |
| `DELETE` | `/menu-products/:id` | Elimina (desactiva) un producto del menú por su ID. | `authenticateToken` | Ninguno | `{"message": "Producto del menú eliminado exitosamente."}` |

### Combos (Bundles)

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/bundles` | Obtiene una lista de todos los combos. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Bundle], "total": number, "page": number, "limit": number}` |
| `GET` | `/bundles/:id` | Obtiene un combo por su ID. | `authenticateToken` | Ninguno | `Bundle` |
| `POST` | `/bundles` | Crea un nuevo combo (puede incluir `bundle_items`). | `authenticateToken` | `{"name": "string", "description": "string", "price": number, "is_active": boolean, "items": [BundleItem]}` | `Bundle` (con `id`) |
| `PUT` | `/bundles/:id` | Actualiza un combo existente (puede actualizar `bundle_items`). | `authenticateToken` | `{"name"?: "string", "description"?: "string", ...}` | `Bundle` (actualizado) |
| `DELETE` | `/bundles/:id` | Elimina (desactiva) un combo por su ID. | `authenticateToken` | Ninguno | `{"message": "Combo eliminado exitosamente."}` |

### Adquisiciones

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/acquisitions` | Obtiene una lista de todas las adquisiciones. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Acquisition], "total": number, "page": number, "limit": number}` |
| `GET` | `/acquisitions/:id` | Obtiene una adquisición por su ID. | `authenticateToken` | Ninguno | `Acquisition` |
| `POST` | `/acquisitions` | Crea una nueva adquisición (puede incluir `acquisition_lines`). | `authenticateToken` | `{"supplier_id": number, "acquisition_date": "YYYY-MM-DD", "acquisition_type": "enum", "document_ref": "string", "total_amount": number, "notes": "string", "lines": [AcquisitionLine]}` | `Acquisition` (con `id`) |
| `PUT` | `/acquisitions/:id` | Actualiza una adquisición existente (puede actualizar `acquisition_lines`). | `authenticateToken` | `{"supplier_id"?: number, "acquisition_date"?: "YYYY-MM-DD", ...}` | `Acquisition` (actualizada) |
| `DELETE` | `/acquisitions/:id` | Elimina una adquisición por su ID. | `authenticateToken` | Ninguno | `{"message": "Adquisición eliminada exitosamente."}` |

### Bajas (Disposals)

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/disposals` | Obtiene una lista de todas las bajas de inventario. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Disposal], "total": number, "page": number, "limit": number}` |
| `GET` | `/disposals/:id` | Obtiene una baja de inventario por su ID. | `authenticateToken` | Ninguno | `Disposal` |
| `POST` | `/disposals` | Crea una nueva baja de inventario. | `authenticateToken` | `{"inventory_item_id": number, "disposal_date": "YYYY-MM-DD", "disposal_type": "enum", "quantity": number, "notes": "string"}` | `Disposal` (con `id`) |
| `PUT` | `/disposals/:id` | Actualiza una baja de inventario existente. | `authenticateToken` | `{"inventory_item_id"?: number, "disposal_date"?: "YYYY-MM-DD", ...}` | `Disposal` (actualizada) |
| `DELETE` | `/disposals/:id` | Elimina una baja de inventario por su ID. | `authenticateToken` | Ninguno | `{"message": "Baja de inventario eliminada exitosamente."}` |

### Movimientos de Inventario

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/inventory-movements` | Obtiene una lista de todos los movimientos de inventario. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder`, `inventoryItemId` | `{"items": [InventoryMovement], "total": number, "page": number, "limit": number}` |
| `POST` | `/inventory-movements` | Crea un nuevo movimiento de inventario (ej. ajuste). | `authenticateToken` | `{"inventory_item_id": number, "movement_type": "enum", "quantity": number, "movement_date": "YYYY-MM-DDTHH:mm:ssZ", "reference_id": number, "notes": "string"}` | `InventoryMovement` (con `id`) |

---

## 📅 Reservas y Ventas

### Clientes

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/clients` | Obtiene una lista de todos los clientes. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [Client], "total": number, "page": number, "limit": number}` |
| `GET` | `/clients/:id` | Obtiene un cliente por su ID. | `authenticateToken` | Ninguno | `Client` |
| `POST` | `/clients` | Crea un nuevo cliente. | `authenticateToken` | `{"person_id": number, "start_date": "YYYY-MM-DD", "loyalty_points": number, "notes": "string"}` | `Client` (con `id`) |
| `PUT` | `/clients/:id` | Actualiza un cliente existente. | `authenticateToken` | `{"start_date"?: "YYYY-MM-DD", "loyalty_points"?: number, ...}` | `Client` (actualizado) |
| `DELETE` | `/clients/:id` | Elimina un cliente por su ID. | `authenticateToken` | Ninguno | `{"message": "Cliente eliminado exitosamente."}` |

### Reservas

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/reservations` | Obtiene una lista paginada de todas las reservas. | `authenticateToken` | Query Params: `page`, `limit`, `includeSaleDetails`, `startDate`, `endDate`, `month`, `barberId`, `status` | `{"reservations": [Reservation], "totalCount": number, "totalPages": number, "currentPage": number}` |
| `GET` | `/reservations/:id` | Obtiene una reserva por su ID. | `authenticateToken` | Query Params: `includeProducts` | `Reservation` |
| `POST` | `/reservations` | Crea una nueva reserva. | `authenticateToken` | `{"barberId": number, "serviceId": number, "clientId": number, "startTime": "YYYY-MM-DDTHH:mm:ssZ", "endTime": "YYYY-MM-DDTHH:mm:ssZ", "status": "enum", "servicePrice": number, "notes": "string"}` | `Reservation` (con `id`) |
| `PUT` | `/reservations/:id` | Actualiza una reserva existente. | `authenticateToken` | `{"barberId"?: number, "stationId"?: number, ...}` | `Reservation` (actualizada) |
| `DELETE` | `/reservations/:id` | Elimina una reserva por su ID. | `authenticateToken` | Ninguno | `(No Content)` |
| `POST` | `/reservations/:id/complete` | Completa una reserva y crea una venta. | `authenticateToken` | `{"paymentMethod": "string", "items": [SaleItem]}` | `{"message": "string", "sale": Sale}` |
| `POST` | `/reservations/:id/cancel` | Cancela una reserva y registra el motivo. | `authenticateToken` | `{"reason": "string"}` | `Reservation` (actualizada con status 'cancelado') |
| `GET` | `/reservations/view/calendar` | Obtiene datos de reservas para la vista de calendario. | `authenticateToken` | Query Params: `startDate`, `endDate`, `status` | `[Reservation]` (formato calendario) |
| `GET` | `/reservations/:id/saleId` | Obtiene el ID de la venta asociada a una reserva. | `authenticateToken` | Ninguno | `{"saleId": number}` |

### Ventas

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/sales` | Obtiene una lista paginada de todas las ventas registradas. | `authenticateToken` | Query Params: `page`, `limit`, `status` | `{"sales": [Sale], "total": number, "page": number, "limit": number}` |
| `GET` | `/sales/:id` | Obtiene los detalles de una venta específica. | `authenticateToken` | Ninguno | `Sale` (con `sale_items`) |
| `GET` | `/sales/by-reservation/:reservationId` | Obtiene una venta por el ID de la reserva asociada. | `authenticateToken` | Ninguno | `Sale` |
| `POST` | `/sales` | Crea un nuevo registro de venta directa. | `authenticateToken` | `{"client_id": number, "payment_method": "string", "items": [SaleItem]}` | `Sale` (con `id`) |
| `POST` | `/sales/:id/anular` | Anula una venta, revierte stock y actualiza la reserva asociada. | `authenticateToken` | `{"reason": "string"}` | `Sale` (actualizada con status 'anulada') |

---

## 💵 Comisiones y Pagos

### Comisiones de Barberos

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/barber-commissions/monthly-summary` | Obtiene un resumen de las comisiones mensuales calculadas para cada barbero. | `authenticateToken` | Query Params: `year`, `month` | `[BarberCommissionSummary]` |
| `POST` | `/barber-commissions/finalize-payment` | Finaliza y registra un pago de comisiones para un barbero en un período. | `authenticateToken` | `{"barberId": number, "periodStart": "YYYY-MM-DD", "periodEnd": "YYYY-MM-DD", "baseSalary": number, "servicesTotal": number, "commissionAmount": number, "totalPayment": number, "status": "string"}` | `BarberCommission` (con `id`) |
| `GET` | `/barber-commissions/:barberId/services` | Obtiene un listado detallado de los servicios realizados por un barbero en un mes. | `authenticateToken` | Query Params: `year`, `month` | `[ServiceDetail]` |
| `GET` | `/barber-commissions/:barberId/advances` | Obtiene un listado detallado de los adelantos realizados a un barbero en un mes. | `authenticateToken` | Query Params: `year`, `month` | `[BarberAdvance]` |

### Pagos (Registros de Comisiones)

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/payments` | Obtiene todos los registros de pagos de comisiones a barberos. | `authenticateToken` | Query Params: `page`, `limit`, `search`, `sortBy`, `sortOrder` | `{"items": [BarberCommission], "total": number, "page": number, "limit": number}` |
| `PUT` | `/payments/:id` | Actualiza el estado de un registro de pago de comisión. | `authenticateToken` | `{"status": "string"}` | `BarberCommission` (actualizada) |

---

## 📈 Reportes y Dashboard

### Dashboard

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/dashboard/summary` | Obtiene un resumen de métricas clave para el dashboard (ventas, reservas, barberos, etc.). | `authenticateToken` | Ninguno | `DashboardSummary` |
| `GET` | `/dashboard/financial-summary` | Obtiene un resumen financiero detallado por método de pago para el mes actual. | `authenticateToken` | Ninguno | `FinancialSummary` |

### Reportes Generales

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/reports/comprehensive-sales` | Reporte detallado de ventas con múltiples filtros y paginación. | `authenticateToken` | Query Params: `page`, `limit`, `startDate`, `endDate`, `barberId`, `serviceId`, `paymentMethod`, `clientId` | `{"sales": [Sale], "total": number, "page": number, "limit": number, "summary": SalesSummary}` |
| `GET` | `/reports/services-products-sales` | Compara ventas de servicios vs. productos en un rango de fechas. | `authenticateToken` | Query Params: `startDate`, `endDate` | `{"serviceSales": number, "productSales": number, "totalSales": number}` |
| `GET` | `/reports/station-usage` | Reporte de uso de estaciones en un rango de fechas. | `authenticateToken` | Query Params: `startDate`, `endDate` | `[StationUsage]` |
| `GET` | `/reports/customer-frequency` | Reporte de frecuencia de clientes en un rango de fechas. | `authenticateToken` | Query Params: `startDate`, `endDate` | `[CustomerFrequency]` |
| `GET` | `/reports/peak-hours` | Reporte de horas pico de actividad en un rango de fechas. | `authenticateToken` | Query Params: `startDate`, `endDate` | `[PeakHour]` |
| `GET` | `/reports/detailed-barber-service-sales` | Reporte detallado de ventas de servicios por barbero. | `authenticateToken` | Query Params: `startDate`, `endDate`, `barberId` | `[BarberServiceSaleDetail]` |

---

## ⚙️ Configuración

### Configuración del Sistema

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/settings` | Obtiene todas las configuraciones clave-valor del sistema. | `authenticateToken`, `authorizeRoles('administrador')` | Ninguno | `[Setting]` |
| `GET` | `/settings/:key` | Obtiene el valor de una configuración específica por su clave. | `authenticateToken`, `authorizeRoles('administrador')` | Ninguno | `Setting` |
| `PUT` | `/settings/:key` | Actualiza o inserta el valor de una configuración. | `authenticateToken`, `authorizeRoles('administrador')` | `{"setting_value": "string", "description"?: "string"}` | `Setting` (actualizada) |

---

## 🛒 Punto de Venta (POS)

### Datos Maestros para POS

| Método | Ruta | Descripción | Seguridad | Request Body | Response (Success 200/201) |
|---|---|---|---|---|---|
| `GET` | `/pos/master-data` | Obtiene datos maestros (servicios, productos de menú, bundles, clientes) para el POS. | `authenticateToken` | Ninguno | `{"services": [Service], "menuProducts": [MenuProduct], "bundles": [Bundle], "clients": [Client]}` |

---
