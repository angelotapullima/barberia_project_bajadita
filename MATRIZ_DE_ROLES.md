# Matriz de Roles y Permisos (Arquitectura Multi-Sede)

La seguridad del sistema se basa primordialmente en el **Rol** del usuario. La sede (`location_id`) define el alcance operativo para roles que no sean el mando global.

## 1. Cuadro de Jerarquía

| Módulo / Acción | Super Admin (Angelo) | Admin de Sede | Cajero / Recepción | Barbero |
| :--- | :--- | :--- | :--- | :--- |
| **Rol en DB** | **`superadmin`** | **`administrador`** | **`cajero`** | **`barbero`** |
| **Sede (Scope)** | **Cualquiera / Global** | **Fijo (Obligatorio)** | **Fijo (Obligatorio)** | **Fijo (Obligatorio)** |
| **Dashboard** | Comparativo Global | Local (Su sede) | Local (Su sede) | Lectura Limitada |
| **Gestión Usuarios** | Crea en cualquier sede | Solo en SU sede | Bloqueado | Bloqueado |
| **Barberos / Personal** | Gestión Global | Gestión Local | **Lectura Local** | Solo su perfil |
| **Sedes (CRUD)** | TOTAL | Bloqueado | Bloqueado | Bloqueado |
| **Caja / POS** | Auditoría Global | Operación Local | Operación Local | Bloqueado |
| **Agenda / Citas** | Auditoría Global | Gestión Local | Gestión Local | Sus propias citas |
| **Reportes BI** | Global con Filtros | Local (Sin filtros) | Bloqueado | Bloqueado |

---

## 2. Validación Técnica (Backend)

El sistema valida el acceso en este orden:

1. **¿Es `superadmin`?** 
   - Si **SÍ** -> Acceso total concedido. Se ignora el `location_id` (puede ser NULL).
2. **¿Es otro rol?**
   - El sistema **EXIGE** un `location_id` válido en la base de datos.
   - Si no tiene `location_id` -> **BLOQUEO 403 (Forbidden)** por error de configuración.
3. **Filtrado:**
   - Para `superadmin`: Query sin filtros de sede (o con filtro opcional de reporte).
   - Para otros: Query forzada con `WHERE location_id = req.user.location_id`.

---

## 3. Regla de Oro
El Frontend nunca envía la sede. El Backend extrae el **Rol** y la **Sede** de la base de datos tras verificar el token JWT.
