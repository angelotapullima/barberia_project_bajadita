# Informe Detallado del Sistema de Gestión de Barbería Pro (v3.11)

## 📋 Índice
1.  Introducción y Visión General del Sistema
2.  Estado Actual de la Documentación
3.  Análisis del Backend (v3.11)
    3.1. Tecnologías y Arquitectura
    3.2. Esquema de la Base de Datos (Estructura Actualizada)
    3.3. Funcionalidades de la API (Endpoints)
4.  Análisis del Frontend
    4.1. Tecnologías y Arquitectura
    4.2. Estructura y Flujo
    4.3. Funcionalidades de Interfaz (Nuevos Módulos)
5.  Resumen de Funcionalidades Existentes (Operativas y Financieras)
6.  Resumen de Funcionalidades Ausentes

---

### **1. Introducción y Visión General del Sistema**

El sistema ha evolucionado de una herramienta de gestión de citas a una plataforma integral de **ERP (Enterprise Resource Planning)** para barberías. Combina la gestión operativa (citas, barberos) con un control financiero estricto (arqueos de caja, flujos multicuenta) y un inventario de unidad única optimizado para evitar errores de conversión.

### **2. Estado Actual de la Documentación**

La documentación técnica se mantiene sincronizada con la **v3.11** del esquema de base de datos. Se han purgado los flujos desfasados relacionados con factores de conversión complejos y tipos de inventario estáticos.

**Documentos de Referencia:**
*   `design-doc-backend.md` / `design-doc-frontend.md`: Arquitectura técnica.
*   `MANUAL_DE_USUARIO.md`: Manual operativo actualizado con flujos de caja y finanzas.
*   `barberia_project_backend/src/database/db.sql`: Definición maestra de la estructura de datos.

---

### **3. Análisis del Backend (v3.11)**

**3.1. Tecnologías y Arquitectura:**
*   **Core:** Node.js, TypeScript, Express.js.
*   **Persistencia:** PostgreSQL con zona horaria configurada en `America/Lima`.
*   **Arquitectura:** Basada en capas (Routes -> Controllers -> Services). La lógica de negocio pesada (como el completado de reservas y cálculo de comisiones) reside en los servicios.

**3.2. Esquema de la Base de Datos (Evolución v3.11):**
Se ha simplificado el modelo de inventario y se ha robustecido el módulo financiero.

*   **Módulo Financiero (Nuevo):**
    *   `financial_accounts`: Gestiona múltiples fuentes de dinero (Caja Principal, Yape, Bancos).
    *   `cash_box_sessions`: Controla los arqueos de caja (monto inicial, esperado, real y discrepancia).
    *   `financial_movements`: Registra cada entrada/salida de dinero, vinculándola a una sesión de caja y cuenta específica.
    *   `cost_centers`: Segmenta financieramente el negocio (Barbería, Cafetería, Retail).
*   **Inventario Simplificado (Modelo de Unidad Única):**
    *   Se eliminaron los factores de conversión complejos. Cada ítem de `inventory_items` se maneja en una única unidad base.
    *   Categorización dinámica mediante `item_categories`.
    *   `internal_consumptions`: Registro de uso de insumos por el personal (no ventas).
*   **Ventas y POS:**
    *   `sale_payments`: Permite pagos divididos (ej. parte efectivo, parte Yape).
    *   `sale_items`: Trazabilidad total, incluyendo asociación a `reservations` y `cost_centers`.

**3.3. Funcionalidades de la API (Endpoints Principales):**
*   **Caja y Finanzas:** `CRUD /financial-accounts`, `POST /cash-box/open`, `POST /cash-box/close`, `GET /cash-box/current-session`.
*   **Inventario:** `CRUD /products` (items), `CRUD /acquisitions`, `CRUD /internal-consumption`, `CRUD /menu-products` (con recetas).
*   **Comisiones:** `GET /barber-commissions/monthly-summary` (Calcula el mayor entre Sueldo Base y Comisión).
*   **POS:** `POST /sales` con soporte para múltiples métodos de pago y cuentas financieras.

---

### **4. Análisis del Frontend**

**4.1. Tecnologías:** Vue 3, Pinia (Estado), Tailwind CSS (Diseño "Clean & Bright" de alto contraste).

**4.2. Flujo de Datos:** El frontend consume el endpoint `/api/pos/master-data` para cargar de forma atómica servicios, productos y combos, minimizando la latencia en el Punto de Venta.

**4.3. Nuevas Funcionalidades de Interfaz:**
*   **Interfaz de Arqueo:** Pantalla dedicada para apertura y cierre de caja con calculadora de discrepancia.
*   **Selector Multicuenta:** En el POS, el usuario elige a qué cuenta entra el dinero.
*   **Gestión de Recetas:** UI para configurar qué ingredientes descuenta cada producto compuesto (ej. un café).

---

### **5. Resumen de Funcionalidades Existentes**

1.  **Gestión de Caja Pro:** Apertura, registro de ventas, egresos manuales y cierre con arqueo físico.
2.  **Finanzas Multicuenta:** Conciliación de saldos en efectivo y billeteras digitales (Yape/Plin).
3.  **Inventario de Unidad Única:** Control de stock sin errores de conversión. Gestión de Insumos y Materia Prima.
4.  **Productos Compuestos:** Descuento automático de inventario basado en recetas (cafetería).
5.  **Agenda Inteligente:** Calendario por barbero y estación con estados de pago sincronizados.
6.  **Comisiones Avanzadas:** Regla de protección al barbero (`MAX(Sueldo Base, Comisión)`).
7.  **Consumo Interno:** Auditoría de productos usados por el equipo.
8.  **Punto de Venta Versátil:** Soporte para cortesías, ventas directas y ventas desde reserva.
9.  **Centros de Costo:** Reportes de rentabilidad separados por área de negocio.

---

### **6. Resumen de Funcionalidades Ausentes**

1.  **Facturación Electrónica:** No hay integración directa con SUNAT (Perú) u otros entes tributarios; genera boletas internas.
2.  **Reservas Online Clientes:** El sistema es de uso interno exclusivo del personal.
3.  **Programa de Puntos (Lógica):** La tabla existe, pero la lógica de canje no está implementada.
4.  **Alertas Push:** No hay notificaciones automáticas por WhatsApp o SMS (solo visuales en el dashboard).

---

**Conclusión:**
El sistema ha alcanzado un nivel de madurez técnica elevado con la **v3.11**. La eliminación de flujos desfasados y la centralización en el control de caja lo convierten en una herramienta robusta para la gestión empresarial real, no solo operativa.

---
