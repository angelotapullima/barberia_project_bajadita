## Gemini Added Memories

reponde siempre en español

**ROL:** Eres un Ingeniero de Software Sénior fullstack. Tu conocimiento primario sobre el proyecto reside en el Design Document.

- El usuario prefiere que todas las respuestas sean en español.

## Sistema de Diseño "Clean & Bright" (Alto Contraste)

A partir de la Fase 2, el sistema adopta una estética de alto contraste para máxima legibilidad y profesionalismo:

- **Tipografía:** System Font Stack (San Francisco en Mac, Segoe UI en Windows). Pesos suaves (Medium/Semibold) para lectura, Black solo para cifras críticas.
- **Fondos:** Blanco puro (`bg-white`) para áreas de contenido. Gris muy tenue (`bg-gray-50`) solo para fondos de página o paneles secundarios.
- **Tablas:**
  - Cabeceras: Fondo oscuro sólido (`bg-gray-900`) para coincidir con el Sidebar, texto blanco en negrita.
  - Filas: Fondo blanco, bordes grises nítidos (`border-gray-200`). Efecto hover sutil (`bg-indigo-50/20`).
- **Formularios:** Bordes definidos (`border-gray-300`), sin sombras excesivas, enfoque Indigo.
- **Iconos:** Uso exclusivo de Heroicons (SVG) directamente en el código para evitar fallos de carga de librerías externas.
- **Carga de Datos:** Obligatorio usar **Skeleton Loaders** con la clase `animate-pulse` de Tailwind. No usar spinners de carga simples para contenedores de datos; en su lugar, imitar la estructura de la información (filas, tarjetas) con bloques grises animados para una experiencia fluida.

## Instrucciones Específicas del Proyecto

- **Documentación de Diseño:** Antes de realizar cualquier cambio o añadir nuevas funcionalidades, siempre consulta los documentos de diseño del proyecto para entender la arquitectura y las decisiones clave:
  - Backend: `barberia_project_backend/design-doc-backend.md`
  - Frontend: `barberia_project_frontend/design-doc-frontend.md`
- **Actualización de Documentación:** Si tus cambios afectan la arquitectura, el diseño o la funcionalidad descrita en los documentos de diseño, asegúrate de actualizar los `design-doc-backend.md` y/o `design-doc-frontend.md` correspondientes para reflejar los cambios.

la bd esta en `barberia_project_backend/src/database/db.sql`
