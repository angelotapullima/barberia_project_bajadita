# Manual de Usuario del Sistema de Gestión de Barbería

## 1. Introducción

### 1.1 Propósito del Sistema

Bienvenido al Manual de Usuario del Sistema de Gestión de Barbería. Esta aplicación ha sido diseñada para optimizar y centralizar todas las operaciones clave de su negocio de barbería, desde la gestión de citas y personal hasta el control de inventario y la generación de reportes financieros. Nuestro objetivo es proporcionarle una herramienta intuitiva y eficiente que le permita enfocarse en lo que mejor sabe hacer: ofrecer un excelente servicio a sus clientes.

### 1.2 Audiencia

Este manual está dirigido a todos los usuarios del sistema, incluyendo:

*   **Administradores:** Encargados de la configuración general, gestión de usuarios, roles, servicios, inventario y reportes.
*   **Personal de Recepción/Caja:** Responsables de la programación de citas, registro de ventas y gestión de clientes.
*   **Barberos:** Usuarios que gestionarán sus citas y comisiones.

### 1.3 Convenciones del Manual

*   **`Texto en negrita`**: Indica elementos de la interfaz de usuario como botones, menús, campos de texto o títulos de secciones.
*   **`Texto en cursiva`**: Resalta términos importantes o conceptos clave.
*   `Código` o `Rutas`: Se utiliza para referenciar rutas de navegación o nombres de archivos/componentes internos del sistema.
*   `>`: Indica una secuencia de navegación en el menú o la interfaz (ej. **Menú Principal** > **Inventario** > **Ítems de Inventario**).

## 2. Requisitos del Sistema

Para garantizar una experiencia óptima con el Sistema de Gestión de Barbería, asegúrese de cumplir con los siguientes requisitos:

### 2.1 Navegadores Soportados

Se recomienda utilizar las versiones más recientes de los siguientes navegadores web:

*   Google Chrome
*   Mozilla Firefox
*   Microsoft Edge
*   Safari

### 2.2 Recomendaciones de Hardware

*   **Procesador:** Intel Core i3 o equivalente (o superior).
*   **RAM:** 4 GB (8 GB o más recomendado para un rendimiento óptimo).
*   **Almacenamiento:** No se requiere almacenamiento local significativo, ya que la aplicación es basada en la web.
*   **Conexión a Internet:** Se requiere una conexión a Internet estable para acceder al sistema.

## 3. Primeros Pasos

### 3.1 Acceso al Sistema

1.  Abra su navegador web preferido.
2.  Ingrese la URL proporcionada por su administrador (ej. `http://localhost:5173/login` si está ejecutando localmente).
3.  Será redirigido a la página de **Inicio de Sesión**.

### 3.2 Inicio de Sesión

1.  En la página de **Inicio de Sesión**, ingrese su **Correo Electrónico** y **Contraseña** en los campos correspondientes.
2.  Haga clic en el botón **Iniciar Sesión**.
3.  Si sus credenciales son correctas, será redirigido al **Dashboard** principal del sistema. En caso contrario, se mostrará un mensaje de error.

### 3.3 Descripción General de la Interfaz de Usuario

Una vez que haya iniciado sesión, la interfaz principal del sistema consta de los siguientes elementos clave:

*   **Barra Lateral de Navegación (Sidebar):** Ubicada a la izquierda, contiene los enlaces a todos los módulos y funcionalidades del sistema (Dashboard, Reservas, Inventario, Ventas, etc.). Los elementos visibles pueden variar según su rol y permisos.
*   **Barra Superior (Header):** En la parte superior, muestra información del usuario actual y un botón para **Cerrar Sesión**.
*   **Área de Contenido Principal:** La sección central y más grande de la pantalla, donde se muestran los datos y formularios del módulo seleccionado en la barra lateral.

## 4. Módulos del Sistema

A continuación, se detalla el uso de cada módulo del sistema.

### 4.1 Autenticación

#### 4.1.1 Inicio de Sesión

(Ver sección 3.2)

#### 4.1.2 Cierre de Sesión

Para cerrar su sesión de forma segura:

1.  Haga clic en el botón **Cerrar Sesión** ubicado en la **Barra Superior**.
2.  Será redirigido a la página de **Inicio de Sesión**.

### 4.2 Dashboard

El **Dashboard** es la página principal que se muestra al iniciar sesión. Proporciona una visión general rápida del rendimiento del negocio a través de métricas clave y gráficos.

*   **Métricas Clave:** Muestra resúmenes de ventas, reservas, etc.
*   **Gráficos:** Visualizaciones de datos como ventas generales, ventas por servicio/producto, etc.

### 4.3 Gestión de Personas y Usuarios

Este módulo permite administrar la información de las personas asociadas al negocio y las cuentas de usuario con sus respectivos roles.

#### 4.3.1 Gestión de Personas

1.  Navegue a **Configuración** > **Personas**.
2.  La tabla de **Personas** muestra un listado de todas las personas registradas.
3.  Para **Crear una nueva persona**:
    *   Haga clic en el botón **Añadir Persona**.
    *   Complete los campos requeridos en el formulario (Nombre, Apellido, Email, Teléfono, Dirección).
    *   Haga clic en **Guardar**.
4.  Para **Editar una persona existente**:
    *   Haga clic en el botón **Editar** en la fila de la persona que desea modificar.
    *   Realice los cambios necesarios en el formulario.
    *   Haga clic en **Guardar**.
5.  Para **Eliminar una persona**:
    *   Haga clic en el botón **Eliminar** en la fila de la persona.
    *   Confirme la eliminación cuando se le solicite.

#### 4.3.2 Gestión de Usuarios

1.  Navegue a **Configuración** > **Usuarios**.
2.  La tabla de **Usuarios** muestra un listado de todas las cuentas de usuario.
3.  Para **Crear un nuevo usuario**:
    *   Haga clic en el botón **Añadir Usuario**.
    *   Complete los campos requeridos (Persona asociada, Email, Contraseña, Rol).
    *   Haga clic en **Guardar**.
4.  Para **Editar un usuario existente**:
    *   Haga clic en el botón **Editar** en la fila del usuario que desea modificar.
    *   Realice los cambios necesarios en el formulario.
    *   Haga clic en **Guardar**.
5.  Para **Eliminar un usuario**:
    *   Haga clic en el botón **Eliminar** en la fila del usuario.
    *   Confirme la eliminación cuando se le solicite.

### 4.4 Gestión de Barberos

Este módulo permite administrar la información de los barberos y sus configuraciones de comisión.

1.  Navegue a **Personal** > **Barberos**.
2.  La tabla de **Barberos** muestra un listado de todos los barberos.
3.  Para **Crear un nuevo barbero**:
    *   Haga clic en el botón **Añadir Barbero**.
    *   Complete los campos requeridos (Persona asociada, Porcentaje de Comisión).
    *   Haga clic en **Guardar**.
4.  Para **Editar un barbero existente**:
    *   Haga clic en el botón **Editar** en la fila del barbero.
    *   Realice los cambios necesarios.
    *   Haga clic en **Guardar**.
5.  Para **Eliminar un barbero**:
    *   Haga clic en el botón **Eliminar** en la fila del barbero.
    *   Confirme la eliminación.

### 4.5 Gestión de Estaciones

Este módulo permite administrar las estaciones de trabajo disponibles en la barbería.

1.  Navegue a **Configuración** > **Estaciones**.
2.  La tabla de **Estaciones** muestra un listado de todas las estaciones.
3.  Para **Crear una nueva estación**:
    *   Haga clic en el botón **Añadir Estación**.
    *   Ingrese el **Nombre** de la estación.
    *   Haga clic en **Guardar**.
4.  Para **Editar una estación existente**:
    *   Haga clic en el botón **Editar** en la fila de la estación.
    *   Realice los cambios necesarios.
    *   Haga clic en **Guardar**.
5.  Para **Eliminar una estación**:
    *   Haga clic en el botón **Eliminar** en la fila de la estación.
    *   Confirme la eliminación.

### 4.6 Gestión de Servicios

Este módulo permite administrar los servicios que ofrece la barbería y vincularlos con los ítems de inventario que consumen.

1.  Navegue a **Configuración** > **Servicios**.
2.  La tabla de **Servicios** muestra un listado de todos los servicios.
3.  Para **Crear un nuevo servicio**:
    *   Haga clic en el botón **Añadir Servicio**.
    *   Complete los campos (Nombre, Descripción, Precio, Duración estimada).
    *   **Consumo de Inventario (Insumos):** Si este servicio consume ítems de inventario (ej. una cuchilla, gel, champú), puede añadir los **Insumos** requeridos y sus **Cantidades** en la sección correspondiente del formulario. Estos ítems se descontarán automáticamente del stock cuando el servicio sea vendido.
    *   Haga clic en **Guardar**.
4.  Para **Editar un servicio existente**:
    *   Haga clic en el botón **Editar** en la fila del servicio.
    *   Realice los cambios necesarios, incluyendo la adición, modificación o eliminación de los insumos que consume el servicio.
    *   Haga clic en **Guardar**.
5.  Para **Eliminar un servicio**:
    *   Haga clic en el botón **Eliminar** en la fila del servicio.
    *   Confirme la eliminación.

### 4.7 Gestión de Reservas

Este módulo es el corazón de la programación de citas, permitiendo gestionar las reservas de los clientes.

#### 4.7.1 Ver Lista de Reservas

1.  Navegue a **Reservas** > **Lista de Reservas**.
2.  La tabla muestra todas las reservas, con opciones de filtro por fecha, barbero y estado.
3.  Puede hacer clic en una fila para ver más detalles de la reserva.

#### 4.7.2 Ver Calendario

1.  Navegue a **Reservas** > **Calendario Diario** o **Calendario Semanal**.
2.  El **Calendario Diario** muestra las citas para un día específico, organizadas por hora y barbero.
3.  El **Calendario Semanal** muestra una vista de las citas para la semana, útil para una planificación a más largo plazo.
4.  Puede navegar entre fechas o semanas utilizando los controles del calendario.

#### 4.7.3 Crear/Editar Reserva

1.  Para **Crear una nueva reserva**:
    *   Desde la **Lista de Reservas**, haga clic en **Añadir Reserva**.
    *   Desde el **Calendario**, haga clic en un espacio disponible o en el botón **Añadir Reserva**.
    *   Complete los campos requeridos:
        *   **Cliente:** Seleccione un cliente existente o cree uno nuevo.
        *   **Barbero:** Asigne un barbero.
        *   **Servicio:** Elija el servicio a realizar.
        *   **Fecha y Hora:** Seleccione la fecha y hora de la cita.
        *   **Estado:** (Opcional, por defecto "Pendiente").
    *   Haga clic en **Guardar**.
2.  Para **Editar una reserva existente**:
    *   Haga clic en el botón **Editar** en la fila de la reserva en la **Lista de Reservas** o haga clic en la cita en el **Calendario**.
    *   Realice los cambios necesarios.
    *   Haga clic en **Guardar**.

#### 4.7.4 Cancelar Reserva

1.  En la **Lista de Reservas**, haga clic en el botón **Cancelar** en la fila de la reserva.
2.  Confirme la cancelación. La reserva cambiará su estado a "Cancelada".

#### 4.7.5 Completar Reserva (Generar Venta)

Cuando un cliente ha completado su servicio, la reserva puede convertirse en una venta:

1.  En la **Lista de Reservas**, haga clic en el botón **Completar** en la fila de la reserva.
2.  Se abrirá un modal de **Registro de Venta**.
3.  Verifique los **Servicios** asociados a la reserva. Puede añadir **Productos del Menú** adicionales a la venta si el cliente ha comprado algo más.
    *   Para añadir un producto, use el campo de búsqueda y selección.
    *   Puede ajustar la cantidad y marcar ítems como cortesía (requiere un motivo).
4.  Seleccione el **Método de Pago**.
5.  Haga clic en **Registrar Venta**. La reserva cambiará su estado a "Completada" y se generará un registro de venta.

### 4.8 Gestión de Ventas

Este módulo permite visualizar y gestionar todas las transacciones de venta.

#### 4.8.1 Ver Lista de Ventas

1.  Navegue a **Ventas** > **Lista de Ventas**.
2.  La tabla muestra un listado de todas las ventas realizadas, con detalles como fecha, cliente, total y método de pago.
3.  Puede usar los filtros de búsqueda y paginación para encontrar ventas específicas.
4.  **Nota Importante:** Cuando se registra una venta que incluye **Servicios** con insumos asociados o **Productos del Menú** de tipo "Compuesto", el sistema descuenta automáticamente los ítems de inventario correspondientes de su stock, basándose en los insumos definidos para el servicio o la receta del producto compuesto.

#### 4.8.2 Crear Venta Directa

Para registrar una venta que no proviene de una reserva:

1.  Navegue a **Ventas** > **Lista de Ventas**.
2.  Haga clic en el botón **Registrar Venta Directa**.
3.  Se abrirá un modal de **Registro de Venta**.
4.  Seleccione el **Cliente** (opcional).
5.  Añada los **Servicios** y/o **Productos del Menú** a la venta, ajustando cantidades y precios si es necesario.
6.  Seleccione el **Método de Pago**.
7.  Haga clic en **Registrar Venta**.

#### 4.8.3 Ver Detalles de Venta

1.  En la **Lista de Ventas**, haga clic en el botón **Ver Detalles** en la fila de la venta.
2.  Se abrirá un modal mostrando un resumen completo de la venta, incluyendo los ítems vendidos, precios, descuentos y método de pago.

### 4.9 Módulo de Inventario

El módulo de inventario ha sido refactorizado para ofrecer una gestión más granular y organizada de sus existencias. Ahora se divide en varias secciones accesibles desde la barra lateral.

#### 4.9.1 Ítems de Inventario (Materias Primas)

Aquí se gestionan los componentes básicos que utiliza su barbería (ej. champú, tintes, navajas).

1.  Navegue a **Inventario** > **Ítems de Inventario**.
2.  La tabla muestra un listado de todos los ítems, incluyendo SKU, nombre, stock actual, stock mínimo, etc.
3.  Utilice el campo de **Búsqueda** para filtrar ítems por nombre o SKU.
4.  Utilice los **Controles de Paginación** para navegar entre las páginas de resultados.
5.  Para **Crear un nuevo ítem**:
    *   Haga clic en el botón **Añadir Ítem de Inventario**.
    *   Complete los campos (SKU, Nombre, Tipo, Categoría, Stock Mínimo, Unidad de Medida, Rastreable).
    *   Haga clic en **Guardar**.
6.  Para **Editar un ítem existente**:
    *   Haga clic en el botón **Editar** en la fila del ítem.
    *   Realice los cambios necesarios.
    *   Haga clic en **Guardar**.
7.  Para **Eliminar un ítem**:
    *   Haga clic en el botón **Eliminar** en la fila del ítem.
    *   Confirme la eliminación.

#### 4.9.2 Productos del Menú

Aquí se gestionan los productos finales que vende a sus clientes (ej. cera para el cabello, loción aftershave) o los servicios compuestos que utilizan ítems de inventario.

1.  Navegue a **Inventario** > **Productos del Menú**.
2.  La tabla muestra un listado de todos los productos, incluyendo nombre, precio y si está activo.
3.  Utilice el campo de **Búsqueda** para filtrar productos por nombre.
4.  Utilice los **Controles de Paginación** para navegar entre las páginas de resultados.
5.  Para **Crear un nuevo producto**:
    *   Haga clic en el botón **Añadir Producto del Menú**.
    *   Complete los campos (Nombre, Precio, Activo).
    *   **Tipo de Producto:** Seleccione entre "Directo" (se vende tal cual), "Compuesto" (consume ítems de inventario) o "Servicio" (representa un servicio que puede tener un costo asociado a inventario).
    *   Si el producto es de tipo "Compuesto", podrá definir su **Receta** añadiendo ítems de inventario y sus cantidades. Estos ítems se descontarán automáticamente del stock cuando se venda el producto compuesto.
    *   Haga clic en **Guardar**.
6.  Para **Editar un producto existente**:
    *   Haga clic en el botón **Editar** en la fila del producto.
    *   Realice los cambios necesarios, incluyendo la modificación de la receta si es un producto compuesto.
    *   Haga clic en **Guardar**.
7.  Para **Eliminar un producto**:
    *   Haga clic en el botón **Eliminar** en la fila del producto.
    *   Confirme la eliminación.

#### 4.9.3 Adquisiciones

Este módulo registra la entrada de ítems de inventario a su stock (compras a proveedores, donaciones, etc.).

1.  Navegue a **Inventario** > **Adquisiciones**.
2.  La tabla muestra un listado de todas las adquisiciones, con detalles como proveedor, fecha, tipo y monto total.
3.  Utilice el campo de **Búsqueda** para filtrar adquisiciones por proveedor o referencia de documento.
4.  Utilice los **Controles de Paginación** para navegar entre las páginas de resultados.
5.  Para ver los **Detalles de las Líneas de Adquisición** (qué ítems se adquirieron en esa transacción), haga clic en el botón **Ver Detalles** en la fila de la adquisición. Esto expandirá una sección con los ítems.
6.  Para **Registrar una nueva adquisición**:
    *   Haga clic en el botón **Registrar Adquisición**.
    *   Complete los campos (Proveedor, Fecha de Adquisición, Tipo de Adquisición, Referencia del Documento, Notas).
    *   Haga clic en **Guardar**.
    *   Después de guardar la adquisición, se le permitirá añadir **Líneas de Adquisición** (los ítems específicos y sus cantidades/costos) a esa adquisición.
7.  Para **Editar una adquisición existente**:
    *   Haga clic en el botón **Editar** en la fila de la adquisición.
    *   Realice los cambios necesarios.
    *   Haga clic en **Guardar**.
    *   Puede editar las líneas de adquisición desde la vista de detalles expandida.
8.  Para **Eliminar una adquisición**:
    *   Haga clic en el botón **Eliminar** en la fila de la adquisición.
    *   Confirme la eliminación.

#### 4.9.4 Bajas de Inventario

Este módulo registra la salida de ítems de inventario de su stock (ventas, daños, uso interno, etc.).

1.  Navegue a **Inventario** > **Bajas de Inventario**.
2.  La tabla muestra un listado de todas las bajas, con detalles como ítem, fecha, tipo y cantidad.
3.  Utilice el campo de **Búsqueda** para filtrar bajas por ítem o SKU.
4.  Utilice los **Controles de Paginación** para navegar entre las páginas de resultados.
5.  Para **Registrar una nueva baja**:
    *   Haga clic en el botón **Registrar Baja**.
    *   Seleccione el **Ítem de Inventario** (utilizando el modal de selección de ítems).
    *   Complete los campos (Tipo de Baja, Cantidad, Fecha de Baja, Notas).
    *   Haga clic en **Guardar**.
6.  Para **Editar una baja existente**:
    *   Haga clic en el botón **Editar** en la fila de la baja.
    *   Realice los cambios necesarios.
    *   Haga clic en **Guardar**.
7.  Para **Eliminar una baja**:
    *   Haga clic en el botón **Eliminar** en la fila de la baja.
    *   Confirme la eliminación.

#### 4.9.5 Movimientos de Inventario

Este módulo proporciona un registro detallado de todos los cambios en el stock de sus ítems de inventario.

1.  Navegue a **Inventario** > **Movimientos de Inventario**.
2.  La tabla muestra un listado de todos los movimientos, incluyendo ítem, tipo de movimiento, cantidad, fecha y referencia.
3.  Utilice el campo de **Búsqueda** para filtrar movimientos por ítem o SKU.
4.  Utilice los **Controles de Paginación** para navegar entre las páginas de resultados.
5.  Los movimientos se generan automáticamente por adquisiciones, bajas y ventas. No se crean directamente desde esta vista.

#### 4.9.6 Configuración de Inventario

Estas secciones permiten gestionar los datos maestros relacionados con el inventario.

##### 4.9.6.1 Tipos de Unidad

1.  Navegue a **Inventario** > **Configuración** > **Tipos de Unidad**.
2.  La tabla muestra los tipos de unidad (ej. "Unidad", "Litro", "Gramo").
3.  **CRUD** (Crear, Leer, Actualizar, Eliminar) es similar a otras tablas de configuración.

##### 4.9.6.2 Categorías de Ítems

1.  Navegue a **Inventario** > **Configuración** > **Categorías de Ítems**.
2.  La tabla muestra las categorías de ítems (ej. "Cuidado del Cabello", "Herramientas").
3.  **CRUD** es similar a otras tablas de configuración.

##### 4.9.6.3 Ubicaciones

1.  Navegue a **Inventario** > **Configuración** > **Ubicaciones**.
2.  La tabla muestra las ubicaciones de almacenamiento (ej. "Almacén Principal", "Estante 1").
3.  **CRUD** es similar a otras tablas de configuración.

### 4.10 Gestión de Proveedores

Este módulo permite administrar la información de sus proveedores.

1.  Navegue a **Inventario** > **Proveedores**.
2.  La tabla de **Proveedores** muestra un listado de todos los proveedores.
3.  Para **Crear un nuevo proveedor**:
    *   Haga clic en el botón **Añadir Proveedor**.
    *   Complete los campos (Nombre, Contacto, Teléfono, Email, Dirección).
    *   Haga clic en **Guardar**.
4.  Para **Editar un proveedor existente**:
    *   Haga clic en el botón **Editar** en la fila del proveedor.
    *   Realice los cambios necesarios.
    *   Haga clic en **Guardar**.
5.  Para **Eliminar un proveedor**:
    *   Haga clic en el botón **Eliminar** en la fila del proveedor.
    *   Confirme la eliminación.

### 4.11 Reportes

El sistema ofrece varios reportes para analizar el rendimiento del negocio.

#### 4.11.1 Reporte de Ventas

1.  Navegue a **Reportes** > **Reporte de Ventas**.
2.  Puede filtrar el reporte por rango de fechas, servicios, productos, barberos y clientes.
3.  El reporte mostrará un resumen de las ventas, incluyendo totales y detalles por categoría.

#### 4.11.2 Reporte de Comisiones de Barberos

1.  Navegue a **Reportes** > **Comisiones de Barberos**.
2.  Seleccione un rango de fechas y un barbero para generar el reporte.
3.  El reporte mostrará las comisiones devengadas por el barbero en el período seleccionado.
4.  Puede **Finalizar Pago** para registrar que las comisiones han sido pagadas.

#### 4.11.3 Reporte de Inventario

1.  Navegue a **Reportes** > **Reporte de Inventario**.
2.  Este reporte proporciona una visión general del estado actual del inventario, incluyendo stock, valor y movimientos recientes.

## 5. Preguntas Frecuentes (FAQ) y Solución de Problemas

*   **¿Qué hago si olvido mi contraseña?**
    *   Contacte a su administrador del sistema para que le restablezca la contraseña.
*   **¿Por qué no puedo ver ciertas opciones en el menú?**
    *   La visibilidad de las opciones depende de su rol y permisos. Si cree que debería tener acceso a una función, contacte a su administrador.
*   **¿Cómo puedo corregir un error en una venta o reserva ya registrada?**
    *   La mayoría de los registros pueden ser editados desde sus respectivas tablas. Para ventas o reservas completadas, es posible que necesite contactar a un administrador para realizar ajustes o reversiones.
*   **El sistema está lento o no carga los datos.**
    *   Verifique su conexión a Internet.
    *   Intente recargar la página.
    *   Si el problema persiste, contacte a soporte técnico.

## 6. Soporte y Contacto

Si tiene alguna pregunta, problema o necesita asistencia adicional, por favor contacte a su equipo de soporte técnico o administrador del sistema.

---
**Fin del Manual de Usuario**
