# Catálogo Exhaustivo de Endpoints - API Barbería Pro (v3.11)

La URL base es `/api`. Todos los endpoints (salvo `/auth/login`) requieren el header `Authorization: Bearer <token>`.

---

## 🔐 Autenticación y Usuarios (`/auth`)
| Método | Ruta | Descripción |
|---|---|---|
| `POST` | `/auth/login` | Login de usuario. Retorna JWT y datos de perfil. |
| `GET` | `/auth/me` | Obtiene datos del usuario actual. |
| `PUT` | `/auth/change-password` | Cambia contraseña del usuario actual. |
| `GET` | `/auth/users` | Lista todos los usuarios (Admin). |
| `POST` | `/auth/users` | Crea un nuevo usuario vinculado a una Persona (Admin). |
| `PUT` | `/auth/users/:id` | Actualiza rol/datos de usuario (Admin). |
| `DELETE` | `/auth/users/:id` | Elimina cuenta de usuario (Admin). |

---

## 👥 Personas, Clientes y Proveedores
| Método | Ruta | Descripción |
|---|---|---|
| `GET/POST` | `/persons` | CRUD de Personas (Base para todo el sistema). |
| `GET/PUT/DELETE` | `/persons/:id` | Detalle, actualización y eliminación de personas. |
| `GET` | `/persons/search` | Búsqueda de personas por DNI/Email. |
| `GET/POST` | `/clients` | CRUD de Clientes. |
| `GET/PUT/DELETE` | `/clients/:id` | Detalle y gestión de clientes. |
| `GET` | `/clients/:id/statistics` | Estadísticas (gasto total, barbero favorito, etc.). |
| `GET` | `/clients/:id/service-history` | Historial de servicios recibidos. |
| `GET/POST` | `/suppliers` | CRUD de Proveedores. |
| `GET/PUT/DELETE` | `/suppliers/:id` | Gestión de proveedores. |

---

## 💈 Gestión de Barbería
| Método | Ruta | Descripción |
|---|---|---|
| `GET/POST` | `/barbers` | CRUD de Barberos. |
| `GET/PUT/DELETE` | `/barbers/:id` | Gestión de barberos. |
| `POST` | `/barbers/:id/advances` | Registro de adelantos de sueldo. |
| `GET/POST` | `/stations` | CRUD de Estaciones de trabajo. |
| `GET/PUT/DELETE` | `/stations/:id` | Gestión de estaciones. |
| `GET/POST` | `/services` | CRUD de Servicios. |
| `GET/PUT/DELETE` | `/services/:id` | Gestión de servicios. |
| `GET/POST` | `/service_supplies` | Gestión de insumos vinculados a un servicio. |

---

## 💰 Finanzas y Caja (`/cash-box` y `/financial-accounts`)
| Método | Ruta | Descripción |
|---|---|---|
| `POST` | `/cash-box/open` | Apertura de sesión de caja (Monto Inicial). |
| `POST` | `/cash-box/close` | Cierre de caja y arqueo final. |
| `GET` | `/cash-box/session/current` | Datos de la sesión de caja abierta. |
| `GET` | `/cash-box/sessions` | Historial de todas las sesiones de caja. |
| `POST` | `/cash-box/expense` | Registro de egresos/gastos manuales. |
| `POST` | `/cash-box/withdrawal` | Registro de retiros de efectivo. |
| `GET` | `/cash-box/session/:id/movements` | Todos los movimientos financieros de una sesión. |
| `GET` | `/financial-accounts` | Lista de cuentas (Efectivo, Yape, Bancos). |
| `GET/POST` | `/financial-accounts/types` | Gestión de tipos de cuenta. |

---

## 📦 Inventario y Productos de Menú
| Método | Ruta | Descripción |
|---|---|---|
| `GET/POST` | `/products` | CRUD de Ítems de Inventario (antes `/inventory-items`). |
| `GET/PUT/DELETE` | `/products/:id` | Gestión de ítems de stock. |
| `GET/POST` | `/menu-products` | CRUD de Productos de Venta POS. |
| `GET/PUT/DELETE` | `/menu-products/:id` | Gestión de productos (incluye recetas). |
| `GET/POST` | `/unit-types` | CRUD de Unidades de medida (Gramos, ml, etc.). |
| `GET/POST` | `/item-categories` | CRUD de Categorías de inventario. |
| `GET/POST` | `/locations` | CRUD de Ubicaciones de almacén. |
| `GET/POST` | `/acquisitions` | Registro de entradas por compra a proveedores. |
| `GET/POST` | `/acquisition-lines` | Detalle de ítems dentro de una adquisición. |
| `GET/POST` | `/disposals` | Registro de bajas de stock (pérdidas, roturas). |
| `GET/POST` | `/inventory-movements` | Auditoría de movimientos y ajustes de stock. |
| `GET/POST` | `/consumptions` | Registro de consumo interno del personal. |
| `GET/POST` | `/bundles` | CRUD de Combos/Bundles. |
| `GET/POST` | `/bundle_items` | Gestión de ítems dentro de un combo. |

---

## 📅 Reservas y Ventas
| Método | Ruta | Descripción |
|---|---|---|
| `GET/POST` | `/reservations` | CRUD de Reservas. |
| `GET` | `/reservations/view/calendar` | Obtiene reservas para el calendario. |
| `POST` | `/reservations/:id/complete` | Finaliza reserva y genera venta (afecta stock). |
| `POST` | `/reservations/:id/cancel` | Cancela reserva con motivo. |
| `GET/POST` | `/sales` | CRUD de Ventas (Directas o desde reserva). |
| `GET` | `/sales/by-reservation/:id` | Obtiene la venta vinculada a una reserva. |
| `POST` | `/sales/:id/anular` | Anulación total (revierte dinero y stock). |

---

## 📊 Reportes, Dashboard y Comisiones
| Método | Ruta | Descripción |
|---|---|---|
| `GET` | `/dashboard/summary` | Resumen de métricas para el dashboard. |
| `GET` | `/dashboard/financial-summary` | Resumen de ingresos por cuenta. |
| `GET` | `/reports/comprehensive-sales` | Reporte detallado de ventas con filtros. |
| `GET` | `/reports/peak-hours` | Reporte de horas de mayor demanda. |
| `GET` | `/barber-commissions/monthly-summary` | Resumen de comisiones del mes. |
| `POST` | `/barber-commissions/finalize-payment` | Cierre de pago a barbero. |
| `GET` | `/payments` | Historial de pagos de comisiones realizados. |

---

## ⚙️ Configuración y POS
| Método | Ruta | Descripción |
|---|---|---|
| `GET/PUT` | `/settings` | Gestión de configuraciones clave-valor. |
| `GET` | `/pos/master-data` | Carga masiva de datos para el inicio del POS. |

---
**Nota sobre `/inventory`:** El endpoint `/api/inventory/summary` y `/api/inventory/movements` proporcionan vistas agregadas y de reporte del stock actual, independientes del CRUD de productos.
