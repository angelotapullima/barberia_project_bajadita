# Informe Detallado del Sistema de Gestión de Barbería

## 📋 Índice
1.  Introducción y Visión General del Sistema
2.  Estado Actual de la Documentación
3.  Análisis del Backend
    3.1. Tecnologías y Arquitectura
    3.2. Esquema de la Base de Datos (`barberia_project_backend/src/database/db.sql`)
    3.3. Funcionalidades de la API (Endpoints)
    3.4. Ausencias / Posibles Mejoras (Backend)
4.  Análisis del Frontend
    4.1. Tecnologías y Arquitectura
    4.2. Estructura y Flujo
    4.3. Funcionalidades Principales (Interfaz de Usuario)
    4.4. Ausencias / Posibles Mejoras (Frontend)
5.  Resumen de Funcionalidades Existentes
6.  Resumen de Funcionalidades Ausentes (o no implementadas según documentación)

---

### **1. Introducción y Visión General del Sistema**

El sistema de gestión de barbería es una aplicación completa diseñada para digitalizar y optimizar las operaciones diarias de una barbería. Está compuesto por un backend robusto basado en Node.js/Express.js con TypeScript y una base de datos PostgreSQL, y un frontend interactivo desarrollado con Vue.js 3, Pinia y Tailwind CSS.

La arquitectura sigue un patrón MVC, donde el frontend actúa como la Vista, el backend como el Controlador y la base de datos PostgreSQL como el Modelo. La comunicación entre frontend y backend se realiza a través de una API RESTful.

### **2. Estado Actual de la Documentación**

La documentación del proyecto es extensa y abarca diferentes niveles de detalle, desde guías de usuario hasta documentos de diseño técnico. Se ha realizado una limpieza, eliminando documentos obsoletos, redundantes o incompletos.

**Documentación Clave y su Propósito:**

*   **Documentación de Diseño (Backend y Frontend):**
    *   `barberia_project_backend/design-doc-backend.md`: Arquitectura, modelos de datos, flujos del backend.
    *   `barberia_project_frontend/design-doc-frontend.md`: Arquitectura, flujo de datos, componentes, stores y mapeo de vistas a endpoints del frontend.
*   **Manuales y Guías Operacionales:**
    *   `MANUAL_DE_INICIO_RAPIDO.md`: Guía concisa para la configuración inicial y operaciones diarias.
    *   `MANUAL_DE_USUARIO.md`: Manual extenso y detallado para todos los usuarios.
    *   `GUIA_DE_INVENTARIO_DETALLADA.md`: Guía práctica para la configuración avanzada del inventario con conversión de unidades.
*   **Diseño Técnico y Proposiciones (Útiles para Contexto/Futuro):**
    *   `inventario.md`: Propuesta de diseño técnico de inventario (SQL, vistas, flujos, sugerencias).
*   **Requisitos Funcionales/Diseño UI:**
    *   `MODULO_CLIENTES.md`: Requisitos funcionales y diseño de UI para el módulo de clientes (listado, detalle, CRUD).
    *   `barberia_project_frontend/DISEÑO_Y_LOGICA_DE_NEGOCIO.md`: Documento funcional de alto nivel para stakeholders.
*   **Guías de Desarrollo/Mantenimiento:**
    *   `barberia_project_backend/README.md`: Guía rápida de setup y ejecución del backend.
    *   `barberia_project_frontend/README.md`: Guía rápida de setup y ejecución del frontend.
    *   `backup_supabase_restore.md`: Guía técnica para backup y restauración de bases de datos (específico de Supabase).
    *   `barberia_project_frontend/DOCUMENTACION_FRONTEND.md`: Manual técnico exhaustivo del frontend (referencia para desarrolladores).


### **3. Análisis del Backend**

**3.1. Tecnologías y Arquitectura:**
*   **Stack:** Node.js (Express.js), TypeScript.
*   **Base de Datos:** PostgreSQL.
*   **Estructura:** Claramente definida en `src/controllers`, `src/services`, `src/models`, `src/routes`, `src/middleware`.
*   **Conexión a DB:** Uso de `pg` (Node-Postgres) con pool de conexiones para eficiencia.
*   **Seguridad:** Autenticación JWT, control de acceso basado en roles mediante middlewares (`authenticateToken`, `authorizeRoles`).
*   **Registro (Logging):** Utiliza un logger (`logger.ts`) para trazar eventos y errores.

**3.2. Esquema de la Base de Datos (`barberia_project_backend/src/database/db.sql`):**
El esquema es relacional, bien normalizado y robusto, con énfasis en la integridad y trazabilidad de los datos.

*   **Entidades Centrales:** `persons` (base para `users`, `clients`, `barbers`, `suppliers`).
*   **Inventario Avanzado:**
    *   `inventory_items`: Gestión granular de ítems físicos (`RAW_MATERIAL`, `CONSUMABLE_SUPPLY`, `OPERATIONAL_ASSET`, `RETAIL_PRODUCT`).
    *   `unit_types`, `item_categories`, `locations` para clasificación y organización.
    *   `consumption_unit_id` y `conversion_factor` en `inventory_items` permiten una gestión precisa de insumos y recetas.
    *   `acquisitions`, `acquisition_lines`, `disposals` para entradas y salidas de stock.
    *   `inventory_movements`: Registro auditable de todos los cambios de stock.
*   **Productos y Combos:**
    *   `menu_products`: Productos que se venden al cliente, pueden ser directos o compuestos.
    *   `product_recipes`: Define ingredientes para `menu_products` compuestos.
    *   `T_BAR_SERVICE_SUPPLIES`: Define insumos consumidos por servicios.
    *   `T_BAR_BUNDLES`, `T_BAR_BUNDLE_ITEMS`: Para la gestión de paquetes/combos.
*   **Reservas y Ventas Desacopladas:**
    *   `reservations`: Vinculadas a `clients`, `barbers`, `services`.
    *   `sales`: Vinculadas a `clients` y opcionalmente a `reservations`. El detalle de la venta (`sale_items`) es la fuente de verdad de montos.
    *   `sale_items`: Contiene servicios y productos vendidos, incluyendo manejo de cortesías.
*   **Finanzas y Personal:** `barbers`, `barber_advances`, `barber_commissions` para el cálculo y registro de pagos a barberos.
*   **Vistas:** `barber_sales_summary` y `v_inventory_stock` para cálculos agregados y stock en tiempo real.
*   **ENUM Types:** Para asegurar la validez de ciertos campos (ej. `movement_kind_enum`).

**3.3. Funcionalidades de la API (Endpoints):**
La API RESTful es completa y cubre todas las áreas de gestión de la barbería:

*   **Autenticación y Autorización:** `POST /auth/login`, `GET /auth/me`, `PUT /auth/change-password`, `CRUD /users`.
*   **Gestión de Entidades Base:** `CRUD /persons`, `CRUD /clients`, `CRUD /barbers`, `CRUD /stations`, `CRUD /services`, `CRUD /suppliers`.
*   **Gestión de Inventario:** `CRUD /unit-types`, `CRUD /item-categories`, `CRUD /locations`, `CRUD /inventory-items`, `CRUD /menu-products`, `CRUD /bundles`, `CRUD /acquisitions`, `CRUD /acquisition-lines`, `CRUD /disposals`, `GET/POST /inventory-movements`.
*   **Operaciones de Negocio:**
    *   **Reservas:** `CRUD /reservations`, `POST /reservations/:id/complete` (crea venta), `POST /reservations/:id/cancel`, `GET /reservations/view/calendar`.
    *   **Ventas:** `POST /sales` (directa), `GET /sales`, `GET /sales/:id`, `GET /sales/by-reservation/:reservationId`, `POST /sales/:id/anular`.
    *   **Comisiones:** `GET /barber-commissions/monthly-summary`, `POST /barber-commissions/finalize-payment`.
*   **Dashboard y Reportes:** `GET /dashboard/summary`, `GET /reports/*` (ventas, uso de estaciones, clientes, horas pico, etc.).
*   **Configuración:** `CRUD /settings`.
*   **Punto de Venta (POS):** `GET /pos/master-data` (datos maestros para el POS).

**3.4. Ausencias / Posibles Mejoras (Backend):**

*   **Tablas `purchases` y `purchase_details` (LEGACY):** El análisis del código (`acquisition.controller.ts`) sugiere que estas tablas no se utilizan. Se recomienda **eliminarlas del esquema de `db.sql`** para evitar confusiones y mantener la base de datos limpia. Esto requerirá una migración de base de datos si estas tablas existen en entornos de producción.
*   **Optimización `stock_quantity`:** La tabla `inventory_items` aún contiene `stock_quantity`. Si `v_inventory_stock` es la fuente de verdad del stock, este campo podría eliminarse y el stock siempre se calcularía a través de la vista, o se podría implementar un trigger para mantenerlo sincronizado, si es un requisito de rendimiento.
*   **Validación de Entrada (Backend):** Aunque hay validaciones básicas, la implementación de una librería de validación más robusta (ej. Joi, class-validator) en la capa de controladores o middlewares podría mejorar la fiabilidad y el mantenimiento del código.

### **4. Análisis del Frontend**

**4.1. Tecnologías y Arquitectura:**
*   **Stack:** Vue.js 3 (Composition API, `<script setup>`), Pinia, Vue Router 4, Tailwind CSS.
*   **Build Tool:** Vite.
*   **Cliente HTTP:** Axios (con interceptores para JWT y manejo de errores 401/403).
*   **Componentes UI:** Reutilizables y agnósticos al estado de Pinia cuando es posible.
*   **Gestión de Estado:** Pinia stores (`authStore`, `clientStore`, `barberStore`, etc.) centralizan el estado y la lógica de negocio del frontend.
*   **Navegación:** Vue Router con guardias para proteger rutas.

**4.2. Estructura y Flujo:**
El frontend sigue una estructura modular (`assets`, `components`, `router`, `services`, `stores`, `views`). El flujo de datos es unidireccional:
`Vista (interacción) -> Store (acción) -> Servicio API (Axios) -> Backend -> (respuesta) -> Store (mutación estado) -> Vista (actualización reactiva)`.

**4.3. Funcionalidades Principales (Interfaz de Usuario):**

*   **Autenticación y Perfiles:** `LoginView`, `ProfileView`, `SettingsView` (gestión de usuarios y reglas de pago).
*   **Dashboard:** `DashboardView` con métricas en tiempo real, gráficos (ventas, pagos a barberos).
*   **Gestión de Entidades:**
    *   **Barberos:** `BarbersView`, formularios para CRUD.
    *   **Estaciones:** `StationsView`, formularios para CRUD.
    *   **Servicios:** `ServicesView`, formularios para CRUD (con sección para insumos requeridos).
    *   **Personas:** `PeopleView`, formularios para CRUD.
    *   **Clientes:** `ClientsView`, `ClientDetailView` (historial, estadísticas).
    *   **Proveedores:** `SuppliersView`, formularios para CRUD.
*   **Inventario Avanzado:**
    *   `InventoryItemsView`, `MenuProductsView`, `AcquisitionsView`, `DisposalsView`, `InventoryMovementsView`, `UnitTypesView`, `ItemCategoriesView`, `LocationsView`.
    *   Formularios complejos para `MenuProduct` (tipo de producto, recetas).
*   **Combos:** `BundlesView`, `BundleForm` (para definir combos con ítems fijos y grupos de elección).
*   **Compras:** `PurchasesView`, formularios para registro de compras (con selección de proveedor e ítems).
*   **Reservas y Calendario:**
    *   `ReservationsView` (lista), `DailyCalendarView`, `WeeklyCalendarView`.
    *   `ReservationFormModal` (crear/editar reservas).
*   **Ventas (POS):**
    *   `POSView` (ventas rápidas), `ReservationPOSView` (completar reservas).
    *   `SaleRegistrationModal` (añadir servicios/productos, cortesías).
    *   `DirectSaleModal` (ventas directas).
*   **Reportes:** Múltiples vistas de reportes (ventas, comisiones, inventario, uso de estaciones, horas pico, frecuencia de clientes).
*   **Pagos a Barberos:** `BarberPaymentsReportView`, `PaymentConfirmationView` (con cálculo de adelantos, servicios y pago final).

**4.4. Ausencias / Posibles Mejoras (Frontend):**

*   **Pruebas Unitarias y de Integración (Frontend):** La documentación menciona Vitest o Jest para Pinia stores y componentes, pero no se ha verificado su implementación o cobertura.
*   **Lazy Loading de Rutas:** Mejorar el rendimiento inicial del frontend implementando la carga perezosa para las rutas no críticas.
*   **Validación de Formularios (Frontend):** Implementar una validación más robusta y unificada en el frontend para evitar envíos de datos inválidos al backend.
*   **Manejo de Errores Global:** Mejorar la visualización de errores de la API en la UI (ej. con notificaciones toast).
*   **Internacionalización (i18n):** Si la aplicación se va a usar en diferentes regiones.
*   **Accesibilidad (A11y):** Revisión de componentes para cumplir con estándares de accesibilidad.

---

### **5. Resumen de Funcionalidades Existentes**

El sistema cuenta con las siguientes funcionalidades clave:

1.  **Gestión de Usuarios y Roles:** Autenticación segura, autorización basada en roles (administrador, cajero), CRUD de usuarios y gestión de perfiles.
2.  **Gestión de Personal:** CRUD completo de personas, clientes, barberos y estaciones de trabajo.
3.  **Gestión de Servicios y Productos:**
    *   CRUD de servicios, productos del menú (con soporte para productos compuestos y recetas), y combos/paquetes.
    *   Definición de insumos consumibles por servicio.
4.  **Gestión de Inventario Integral:**
    *   Clasificación detallada de ítems (materias primas, insumos, productos de venta, activos).
    *   Gestión de unidades, categorías y ubicaciones.
    *   Control de stock con movimientos de entrada (adquisiciones), salida (ventas, bajas) y ajustes.
    *   Factor de conversión para unidades de compra/almacenamiento y consumo.
    *   Alertas de stock mínimo.
5.  **Gestión de Compras:** Registro detallado de adquisiciones a proveedores, con impacto directo en el inventario.
6.  **Gestión de Reservas y Agenda:**
    *   Calendario interactivo (diario, semanal).
    *   Creación, modificación, cancelación y completado de reservas (vinculadas a clientes, barberos y servicios).
7.  **Gestión de Ventas (POS):**
    *   Flujo de venta desde reserva y venta directa.
    *   Manejo de múltiples ítems (servicios, productos, combos).
    *   Soporte para cortesías (con motivo y descuento de stock).
    *   Anulación de ventas con reversión de stock y estado de reserva.
    *   Múltiples métodos de pago.
8.  **Gestión Financiera de Personal:**
    *   Cálculo de comisiones de barberos basado en un modelo mixto (salario base vs. porcentaje de ventas).
    *   Registro y gestión de adelantos a barberos.
    *   Finalización de pagos con historial y boleta.
9.  **Reportes y Análisis:** Amplia gama de reportes para la toma de decisiones (ventas por tipo, uso de estaciones, clientes, horas pico, resumen de inventario, etc.) y un dashboard con métricas clave.
10. **Configuración del Sistema:** Gestión de parámetros globales del negocio.

### **6. Resumen de Funcionalidades Ausentes (o no implementadas según documentación):**

1.  **Programa de Lealtad/Puntos:** Aunque la tabla `clients` tiene `loyalty_points`, la lógica de acumulación, canje o gestión de recompensas no parece estar implementada ni documentada en los manuales de usuario.
2.  **Notificaciones Automatizadas:** (SMS/Email) para recordatorios de citas o cambios.
3.  **Reservas Online para Clientes:** El sistema actual se centra en la gestión interna de reservas por el personal.
4.  **Integración con Pasarelas de Pago:** Aunque se registran métodos de pago, no se especifica una integración directa con terminales o pasarelas online.
5.  **Módulo de Activos Fijos:** `OPERATIONAL_ASSET` en `inventory_items` permite el registro de activos, pero no hay un módulo de gestión específico para su depreciación, mantenimiento o seguimiento individualizado (serial, garantías), más allá del control básico de stock.
6.  **Control por Lotes/Fechas de Vencimiento:** Para ítems de inventario perecederos, el sistema actual no ofrece esta funcionalidad.
7.  **Movimientos de Inventario entre Ubicaciones:** Aunque existe la tabla `locations`, la funcionalidad para transferir ítems entre ellas no está explícitamente detallada en los controladores ni manuales.

---

**Conclusión:**

El sistema de gestión de barbería es un producto maduro y funcional, con una arquitectura sólida y una cobertura exhaustiva de las necesidades operativas de una barbería moderna. La reciente refactorización de la base de datos y la implementación del módulo de inventario avanzado, junto con el sistema de combos, lo posicionan como una herramienta potente. Las áreas identificadas para la mejora continua se centran en la limpieza del esquema de base de datos (eliminación de tablas LEGACY), optimizaciones de rendimiento y la posible incorporación de funcionalidades adicionales que podrían enriquecer aún más la experiencia del usuario y la capacidad de negocio.

---