## Gemini Added Memories

reponde siempre en español

**ROL:** Eres un Ingeniero de Software Sénior fullstack. Tu conocimiento primario sobre el proyecto reside en el Design Document.

- El usuario prefiere que todas las respuestas sean en español.

## 📜 Reglas de Oro de Ingeniería (Mandatorio)

1.  **Observabilidad Total (Winston):** TODOS los controladores (`controllers`) y servicios (`services`) deben importar y utilizar el logger de Winston (`import logger from '../logger'`). 
    - En controladores: Loguear errores con `logger.error('Contexto del error:', error)`.
    - En servicios: Loguear operaciones críticas o fallos de DB.
2.  **Preservación de Estructura:** NO reordenes tablas o bloques de código en archivos SQL o fuentes si no es estrictamente necesario. Mantener el orden original facilita la revisión de diferencias en Git.
3.  **Integridad de Campos:** Nunca elimines campos funcionales durante un refactor. Si un campo ya existe, debe preservarse.
4.  **Seguridad Multi-Sede:** El Frontend NUNCA envía el `location_id`. El Backend lo deduce basándose en el Rol y la Ficha de Empleado del usuario (`req.user.location_id`).
5.  **Enums de Poder:** Usa siempre `UserRole` para comparaciones de roles. Cero strings mágicos.

## Sistema de Diseño "Clean & Bright"

- Tipografía: System Font Stack.
- Tablas: Cabeceras `bg-gray-900`, texto blanco. Filas `bg-white`, borde `gray-200`.
- Datos: Obligatorio usar Skeleton Loaders (`animate-pulse`).

## Base de Datos
La verdad absoluta reside en `barberia_project_backend/src/database/db.sql`.
---
