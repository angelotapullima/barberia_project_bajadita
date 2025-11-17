# Manual de Usuario del Sistema de Gestión de Barbería

## 1. Introducción

### 1.1 Propósito del Sistema

Bienvenido al Manual de Usuario del Sistema de Gestión de Barbería. Esta aplicación ha sido diseñada para optimizar y centralizar todas las operaciones clave de su negocio, desde la gestión de citas y personal hasta el control de inventario y la generación de reportes financieros. Nuestro objetivo es proporcionarle una herramienta intuitiva y eficiente que le permita enfocarse en lo que mejor sabe hacer: ofrecer un excelente servicio a sus clientes.

### 1.2 Audiencia

Este manual está dirigido a todos los usuarios del sistema, incluyendo:

*   **Administradores:** Encargados de la configuración general, gestión de usuarios, roles, y acceso a todos los módulos.
*   **Personal de Recepción/Caja:** Responsables de la programación de citas, registro de ventas y gestión de clientes.
*   **Barberos:** Usuarios que gestionarán sus citas, comisiones y podrán ver sus reportes.

### 1.3 Convenciones del Manual

*   **`Texto en negrita`**: Indica elementos de la interfaz de usuario como botones, menús, campos de texto o títulos de secciones.
*   **`Texto en cursiva`**: Resalta términos importantes o conceptos clave.
*   `>`: Indica una secuencia de navegación en el menú (ej. **Menú Principal** > **Inventario** > **Ítems de Inventario**).
*   `[IMAGEN: ... ]`: Indica un lugar sugerido para insertar una captura de pantalla que ilustre la funcionalidad descrita.

## 2. Primeros Pasos

### 2.1 Acceso al Sistema

1.  Abra su navegador web preferido (Google Chrome, Firefox, etc.).
2.  Ingrese la URL proporcionada por su administrador.
3.  Será redirigido a la página de **Inicio de Sesión**.

`[IMAGEN: Pantalla de inicio de sesión con campos para email y contraseña]`

### 2.2 Inicio de Sesión

1.  En la página de **Inicio de Sesión**, ingrese su **Correo Electrónico** y **Contraseña**.
2.  Haga clic en el botón **Iniciar Sesión**.
3.  Si sus credenciales son correctas, será redirigido al **Dashboard** principal.

### 2.3 Interfaz Principal

La interfaz se compone de tres áreas principales:

*   **Barra Lateral de Navegación:** A la izquierda, contiene los enlaces a todos los módulos del sistema. Los módulos visibles dependen de su rol.
*   **Barra Superior:** Muestra el nombre del usuario actual y el botón para acceder a su **Perfil** y **Cerrar Sesión**.
*   **Área de Contenido Principal:** La sección central donde se muestran los datos y formularios del módulo seleccionado.

`[IMAGEN: Vista general del Dashboard, resaltando la barra lateral, la barra superior y el área de contenido]`

### 2.4 Cerrar Sesión

1.  Haga clic en su nombre de usuario en la esquina superior derecha.
2.  Seleccione **Cerrar Sesión** en el menú desplegable.

## 3. Dashboard

El **Dashboard** es su pantalla de inicio y ofrece una visión general del estado del negocio en tiempo real.

*   **Tarjetas de Métricas Clave:** Resúmenes rápidos de **Ventas del Día**, **Reservas para Hoy**, **Clientes Atendidos Hoy** y **Productos Vendidos Hoy**.
*   **Ventas Generales (Últimos 30 Días):** Un gráfico de área que muestra la tendencia de ventas, con un resumen del **Total General**, **Ventas de Productos** y **Ventas de Servicios**.
*   **Ventas por Barbero (Últimos 30 Días):** Un gráfico de barras que compara el rendimiento de ventas entre los barberos.
*   **Servicios Más Populares (Últimos 30 Días):** Un gráfico de dona que muestra los servicios más demandados.
*   **Productos Más Vendidos (Últimos 30 Días):** Un gráfico de dona que muestra los productos más vendidos.

`[IMAGEN: Captura completa del Dashboard mostrando todas las tarjetas y gráficos]`

## 4. Módulo de Reservas

Este módulo es central para la gestión diaria de citas.

### 4.1 Calendario de Citas (`Reservas > Calendario`)

Ofrece una vista visual de todas las citas.

1.  Navegue a **Reservas** > **Calendario**.
2.  Puede cambiar entre la vista **Semanal** y **Diaria**.
3.  Use los controles de fecha para navegar al día o semana que desee consultar.
4.  Las citas se muestran en la columna del barbero y la hora correspondiente. Los colores indican el estado de la reserva (ej. Pendiente, Confirmada, Completada).

`[IMAGEN: Vista del calendario semanal con varias citas de diferentes colores]`

### 4.2 Crear una Nueva Reserva

1.  Desde el **Calendario**, haga clic en un espacio de tiempo vacío o en el botón **Añadir Reserva**.
2.  Se abrirá el formulario **Crear Nueva Reserva**.
3.  **Cliente:**
    *   Busque un cliente existente por nombre, email o teléfono.
    *   Si el cliente no existe, haga clic en **Crear Nuevo Cliente** y complete sus datos.
4.  **Barbero:** Seleccione el barbero que atenderá la cita.
5.  **Servicio:** Seleccione uno o más servicios que el cliente desea.
6.  **Fecha y Hora:** Se rellenarán automáticamente si hizo clic en el calendario, pero puede ajustarlos.
7.  **Notas:** Añada cualquier información relevante sobre la cita.
8.  Haga clic en **Guardar Reserva**. La cita aparecerá en el calendario.

`[IMAGEN: Modal 'Crear Nueva Reserva' con todos los campos para rellenar]`

### 4.3 Gestionar una Reserva Existente

1.  Haga clic sobre una cita en el **Calendario** o en la **Lista de Reservas**.
2.  Se abrirá un modal con las siguientes opciones:
    *   **Editar:** Modifica los detalles de la reserva.
    *   **Cancelar:** Cambia el estado de la reserva a "Cancelada".
    *   **Completar (Registrar Venta):** Inicia el proceso de cobro y convierte la reserva en una venta.

### 4.4 Lista de Reservas (`Reservas > Lista`)

Ofrece una vista de tabla para buscar y filtrar reservas.

1.  Navegue a **Reservas** > **Lista**.
2.  Use los filtros en la parte superior para buscar por **Fecha**, **Barbero** o **Estado**.
3.  Desde esta tabla, también puede **Editar**, **Cancelar** o **Completar** una reserva usando los botones de acción en cada fila.

`[IMAGEN: Tabla de la lista de reservas con los filtros visibles]`

## 5. Módulo de Ventas (Punto de Venta)

Este módulo gestiona todas las transacciones financieras. No existe un menú "Ventas" directo en la barra lateral; la gestión de ventas se realiza a través de las reservas y el calendario, y el historial se consulta en los reportes.

### 5.1 Completar una Venta desde una Reserva

Este es el flujo más común.

1.  En el **Calendario** o la **Lista de Reservas**, seleccione una cita y haga clic en **Completar**.
2.  Se abrirá el modal **Registrar Venta**, precargado con los datos de la reserva (cliente, barbero, servicios).
3.  **Añadir Productos:** Si el cliente desea comprar productos, búsquelos y añádalos a la venta.
4.  **Verificar Total:** Revise el resumen de la venta. Puede aplicar descuentos si tiene los permisos.
5.  **Seleccionar Método de Pago:** Elija cómo pagará el cliente (Efectivo, Tarjeta, etc.).
6.  Haga clic en **Registrar Venta**. El sistema registrará la transacción, actualizará el estado de la reserva a "Completada" y descontará del inventario los productos vendidos y los insumos de los servicios prestados.

`[IMAGEN: Modal 'Registrar Venta' mostrando los servicios de la reserva y la opción de añadir productos]`

### 5.2 Registrar una Venta Directa (sin reserva)

Para clientes que llegan sin cita o solo compran productos.

1.  Navegue a **Agenda y Citas** > **Calendario**.
2.  Busque y haga clic en el botón para crear un nuevo evento (normalmente etiquetado como **"Nuevo"** o similar en la parte superior de la vista del calendario).
3.  En el menú desplegable, seleccione la opción **Nueva Venta**.
4.  Se abrirá el modal **Registrar Venta Directa**.
5.  **Cliente (Opcional):** Seleccione un cliente si lo desea.
6.  **Barbero:** A diferencia de una venta por reserva, aquí no se selecciona un barbero. Esto se debe a que la venta directa está diseñada para transacciones que no generan comisión, como la compra de un producto directamente en recepción.
7.  **Añadir Servicios y/o Productos:** Busque y añada los ítems a la venta.
8.  Complete el pago como en el flujo anterior.

`[IMAGEN: Captura de la vista del Calendario, resaltando el botón 'Nuevo' y la opción 'Nueva Venta']`

### 5.3 Historial de Ventas

Para ver el historial de todas las transacciones:

1.  Navegue a **Reportes** > **Ventas Detallado**.
2.  Esta vista funciona como su **Historial de Ventas**. Muestra un registro de todas las transacciones.
3.  Use los filtros para buscar ventas específicas por fecha, cliente, estado, etc.
4.  Haga clic en una venta para expandir y ver los **Detalles de Ítems**.

`[IMAGEN: Tabla del reporte de ventas detallado, que funciona como historial de ventas]`

    ### 4.9 Módulo de Inventario: Guía Detallada

El módulo de inventario es el corazón del control de existencias de su negocio. Entender cómo sus componentes se conectan es clave para una gestión exitosa. A continuación, se detalla el flujo lógico, desde la configuración hasta la operación diaria.

`[IMAGEN: Diagrama de flujo simple mostrando: Configuración -> Ítems de Inventario -> Entradas (Adquisiciones) / Salidas (Ventas, Bajas) -> Movimientos]`

#### **Paso 1: La Base - Configuración del Inventario**

Antes de añadir productos, debe establecer las bases para organizarlos. Estas configuraciones se encuentran en `Inventario > Configuración`.

*   **Tipos de Unidad (`Inventario > Configuración > Tipos de Unidad`):**
    *   **¿Qué es?** Define las unidades en las que mide sus productos.
    *   **Ejemplos:** "Unidad(es)", "Litro(s)", "Gramo(s)", "Caja(s)".
    *   **¿Por qué es importante?** Asegura que el stock se mida de forma consistente. No puede comprar en "Cajas" y vender en "Unidades" si no lo define correctamente.

*   **Categorías de Ítems (`Inventario > Configuración > Categorías de Ítems`):**
    *   **¿Qué es?** Permite agrupar sus ítems de inventario.
    *   **Ejemplos:** "Cuidado del Cabello", "Herramientas de Corte", "Bebidas", "Limpieza".
    *   **¿Por qué es importante?** Facilita la búsqueda, filtrado y generación de reportes.

*   **Ubicaciones (`Inventario > Configuración > Ubicaciones`):**
    *   **¿Qué es?** Define los lugares físicos donde almacena sus productos.
    *   **Ejemplos:** "Almacén Principal", "Estante A-1", "Recepción", "Nevera".
    *   **¿Por qué es importante?** Ayuda a su personal a encontrar productos rápidamente y a realizar inventarios físicos de forma ordenada.

#### **Paso 2: El Núcleo - Ítems de Inventario (`Inventario > Ítems`)**

Esta es la lista maestra de **todo lo que posee físicamente**. Cada producto, insumo o herramienta debe ser registrado aquí primero. Al crear un ítem, el campo más importante es el **Tipo de Ítem**.

`[IMAGEN: Formulario de 'Añadir Nuevo Ítem de Inventario' con el campo 'Tipo de Ítem' resaltado]`

##### **Explicación Detallada de los Tipos de Ítem:**

*   **Materia Prima (`RAW_MATERIAL`):**
    *   **¿Qué es?** Un ingrediente que se usa para *crear* otro producto dentro de su local. No se usa directamente en un servicio ni se vende tal cual.
    *   **Ejemplo de Barbería:** Usted compra "pigmento de color rojo" y "peróxido" por separado. En su local, un barbero los mezcla para crear un "tinte rojo personalizado". El pigmento y el peróxido son **Materia Prima**.
    *   **Uso en el sistema:** Se usarían en la "receta" de un `Producto del Menú` de tipo "Compuesto".

*   **Insumo Consumible (`CONSUMABLE_SUPPLY`):**
    *   **¿Qué es?** Un producto que se gasta o consume directamente al realizar un servicio. Es el tipo más común para el día a día.
    *   **Ejemplos de Barbería:**
        *   El champú que se usa para lavar el cabello.
        *   La cera que se aplica en un peinado.
        *   Una navaja de afeitar desechable.
        *   El papel de cuello.
    *   **Uso en el sistema:** Estos ítems se vinculan a un `Servicio` en la sección "Insumos Requeridos". Cuando ese servicio se vende, el stock de estos insumos se descuenta automáticamente.

*   **Activo Operacional (`OPERATIONAL_ASSET`):**
    *   **¿Qué es?** Un artículo que es propiedad del negocio, se usa repetidamente, pero no se consume con cada servicio ni se vende.
    *   **Ejemplos de Barbería:**
        *   Máquinas de cortar cabello (clippers).
        *   Tijeras.
        *   Toallas.
        *   Las propias sillas de barbero.
    *   **Uso en el sistema:** Se registran para tener un inventario de los activos del negocio. **Generalmente, su stock no se descuenta automáticamente**, ya que no se "gastan" en una venta. Sirve para control de patrimonio.

*   **Producto de Venta (`RETAIL_PRODUCT`):**
    *   **¿Qué es?** Un producto que usted compra y vende directamente al cliente, usualmente sin modificación.
    *   **Ejemplos de Barbería:**
        *   Botellas de cera para el cabello de una marca específica.
        *   Latas de cerveza artesanal que ofrece a la venta.
        *   Champús o acondicionadores en su empaque original.
    *   **Uso en el sistema:** Un `Ítem de Inventario` de este tipo se vincula a un `Producto del Menú` de tipo "Directo". Cuando se vende, el stock se descuenta 1 a 1.

#### **Paso 3: Las Entradas - Guía Detallada de Adquisiciones (`Inventario > Adquisiciones`)**

El módulo de Adquisiciones es donde se registra toda la mercancía que entra a su negocio, ya sea por compra, donación u otro medio. Este proceso es fundamental para aumentar el stock de sus `Ítems de Inventario`.

El registro de una adquisición es un proceso de **dos pasos**:
1.  **Crear el registro principal de la adquisición:** Contiene la información general (proveedor, fecha, factura).
2.  **Añadir las líneas de detalle:** Especificar qué ítems y en qué cantidad y costo se recibieron en esa adquisición.

**Guía Paso a Paso:**

1.  Navegue a `Inventario > Adquisiciones`.
2.  Haga clic en el botón **`Registrar Adquisición`**. Se abrirá un formulario.
3.  **Complete los datos del encabezado:**
    *   **Proveedor:** Seleccione el proveedor de la lista. Si no existe, puede crearlo desde el módulo de `Proveedores`.
    *   **Fecha de Adquisición:** La fecha en que recibió los productos.
    *   **Tipo de Adquisición:** Generalmente será `PURCHASE` (Compra).
    *   **Referencia de Documento:** Ingrese un número de factura, guía de remisión o cualquier identificador único.
    *   **Monto Total:** Puede ingresarlo ahora si lo conoce, o el sistema puede calcularlo después basado en las líneas de detalle.
4.  Haga clic en **`Guardar`**. Con esto, ha creado el contenedor de la adquisición. Ahora falta "llenarlo".

`[IMAGEN: Tabla de adquisiciones, mostrando una flecha que apunta al botón para expandir los detalles de una adquisición recién creada]`

5.  **Añada los productos recibidos:**
    *   En la tabla de adquisiciones, busque el registro que acaba de crear.
    *   Haga clic en el botón **`Ver Detalles`** o en el icono de flecha en esa fila para expandir la sección de "Líneas de Adquisición".
    *   Verá un botón que dice **`Añadir Ítem a la Adquisición`**. Haga clic en él.
    *   Se abrirá un nuevo formulario para la línea de detalle.
    *   **Ítem de Inventario:** Seleccione el producto que recibió (ej. "Cera Moldeadora Profesional").
    *   **Cantidad:** Ingrese la cantidad que ha recibido en la unidad base del ítem (ej. si su unidad base es "ml" y recibió un pote de 100ml, ingrese `100`).
    *   **Precio Unitario:** Ingrese el costo por unidad base (ej. el costo por cada "ml").
6.  Haga clic en **`Guardar`** en el formulario de la línea de detalle.
7.  Repita el paso 5 y 6 por cada producto diferente que haya recibido en esta misma compra.

**Resultado Final:**
Una vez que añade las líneas de detalle, el sistema automáticamente crea un movimiento de inventario de tipo `IN` (Entrada) por cada línea. Esto **incrementa el stock** de sus `Ítems de Inventario`, y todo el historial queda registrado en la sección de `Movimientos`.

#### **Paso 4: Las Salidas - Conexiones con Ventas y Bajas**

El stock disminuye principalmente de tres maneras:

1.  **Por Venta de Servicios:**
    *   **Conexión:** En `Configuración > Servicios`, usted define qué **Insumos Consumibles** y en qué cantidad se usan para un servicio (ej. "Corte de Cabello" consume 1 navaja y 10ml de gel).
    *   **Flujo:** Cuando se completa una venta que incluye ese servicio, el sistema busca los insumos vinculados y **descuenta las cantidades especificadas del stock** de los `Ítems de Inventario` correspondientes.

2.  **Por Venta de Productos del Menú:**
    *   **Conexión:** En `Inventario > Productos del Menú`, usted crea los productos que ofrece en su punto de venta.
        *   Si el producto es de tipo **"Directo"**, lo vincula a un `Ítem de Inventario` de tipo `Producto de Venta`.
        *   Si el producto es de tipo **"Compuesto"**, le crea una "receta" usando varios `Ítems de Inventario` (ej. "Kit de Viaje" = 1 mini-champú + 1 mini-cera).
    *   **Flujo:** Cuando vende un `Producto del Menú`, el sistema **descuenta el stock del ítem o los ítems de la receta** correspondientes.

3.  **Por Bajas Manuales (`Inventario > Bajas`):**
    *   **Conexión:** Esta es la forma manual de reducir el stock.
    *   **Flujo:** Si un producto se rompe, caduca o se usa para limpieza, usted va a `Inventario > Bajas`, selecciona el `Ítem de Inventario`, la cantidad y el motivo (Pérdida, Desperdicio, etc.). El sistema **reduce el stock** y lo registra.

#### **Paso 5: El Historial - Movimientos de Inventario (`Inventario > Movimientos`)**

Esta sección es su libro de contabilidad de stock. Es una vista de **solo lectura** que unifica todos los pasos anteriores. Por cada ítem, podrá ver un historial completo de cada entrada (por Adquisición) y cada salida (por Venta o Baja), permitiéndole tener una trazabilidad total de sus existencias.

#### **Preguntas Frecuentes y Casos de Uso**

##### **Pregunta 1: ¿Por qué a veces una ventana (modal) se abre debajo de otra?**

Esto era un error de apilamiento visual. Cuando se abren múltiples ventanas una encima de la otra, el sistema necesita saber cuál debe ir al frente. El problema que experimentó, donde el modal para crear un ítem nuevo aparecía "detrás" del modal de selección, ya ha sido **solucionado**. Se ha ajustado el orden para que las ventanas nuevas siempre aparezcan al frente.

##### **Pregunta 2: ¿Cómo se calcula exactamente el pago a los barberos?**

El sistema tiene una regla de negocio específica para determinar el ingreso de un barbero, comparando sus ventas de servicios con su sueldo base.

**La Regla:**
1.  El sistema suma el total de **ventas por servicios** que el barbero ha generado en el mes.
2.  Compara este total con el doble de su sueldo base (`Sueldo Base * 2`).
    *   **Si las ventas son MAYORES o IGUALES que el doble del sueldo base:** El barbero gana una comisión. Su ingreso ese mes es `(Total Ventas Servicios * Tasa de Comisión)`.
    *   **Si las ventas son MENORES que el doble del sueldo base:** El barbero no comisiona. Su ingreso ese mes es simplemente su `Sueldo Base`.
3.  Finalmente, al ingreso calculado se le restan los adelantos que haya pedido en el mes. `Pago Final = Ingreso Calculado - Total de Adelantos`.

**Ejemplo Práctico:**
- **Sueldo Base:** S/ 1200
- **Tasa de Comisión:** 40% (0.40)
- **Adelantos del Mes:** S/ 200

*   **Escenario A: Barbero vende S/ 3000 en servicios.**
    *   ¿Es `3000 >= (1200 * 2)`? Sí, `3000 >= 2400`.
    *   Ingreso = `3000 * 0.40` = S/ 1200.
    *   Pago Final = `1200 - 200` = **S/ 1000**.

*   **Escenario B: Barbero vende S/ 2000 en servicios.**
    *   ¿Es `2000 >= (1200 * 2)`? No, `2000 < 2400`.
    *   Ingreso = `Sueldo Base` = S/ 1200.
    *   Pago Final = `1200 - 200` = **S/ 1000**.

**¿Cómo funcionan los combos y cómo afectan mi inventario?**

Los combos (o bundles) le permiten agrupar varios servicios y/o productos en un solo paquete con un precio especial.

**¿Cómo se crean?**
1.  Navegue a `Configuración > Combos`.
2.  Haga clic en **Añadir Combo**.
3.  Asigne un nombre (ej. "Paquete Premium de Afeitado") y un precio total para el combo.
4.  Use los selectores para añadir los `Servicios` (ej. "Afeitado Clásico") y/o `Productos del Menú` (ej. "Lata de Cerveza Artesanal") que formarán parte del paquete.
5.  Guarde el combo. Ahora estará disponible para ser añadido a una venta.

`[IMAGEN: Formulario de creación de un Combo, mostrando cómo añadir servicios y productos al paquete]`

#### **Preguntas Frecuentes y Casos de Uso**

##### **Pregunta 1: ¿Por qué a veces una ventana (modal) se abre debajo de otra?**

Esto era un error de apilamiento visual. Cuando se abren múltiples ventanas una encima de la otra, el sistema necesita saber cuál debe ir al frente. El problema que experimentó, donde el modal para crear un ítem nuevo aparecía "detrás" del modal de selección, ya ha sido **solucionado**. Se ha ajustado el orden para que las ventanas nuevas siempre aparezcan al frente.

##### **Pregunta 2: ¿Cómo se calcula exactamente el pago a los barberos?**

El sistema tiene una regla de negocio específica para determinar el ingreso de un barbero, comparando sus ventas de servicios con su sueldo base.

**La Regla:**
1.  El sistema suma el total de **ventas por servicios** que el barbero ha generado en el mes.
2.  Compara este total con el doble de su sueldo base (`Sueldo Base * 2`).
    *   **Si las ventas son MAYORES o IGUALES que el doble del sueldo base:** El barbero gana una comisión. Su ingreso ese mes es `(Total Ventas Servicios * Tasa de Comisión)`.
    *   **Si las ventas son MENORES que el doble del sueldo base:** El barbero no comisiona. Su ingreso ese mes es simplemente su `Sueldo Base`.
3.  Finalmente, al ingreso calculado se le restan los adelantos que haya pedido en el mes. `Pago Final = Ingreso Calculado - Total de Adelantos`.

**Ejemplo Práctico:**
- **Sueldo Base:** S/ 1200
- **Tasa de Comisión:** 40% (0.40)
- **Adelantos del Mes:** S/ 200

*   **Escenario A: Barbero vende S/ 3000 en servicios.**
    *   ¿Es `3000 >= (1200 * 2)`? Sí, `3000 >= 2400`.
    *   Ingreso = `3000 * 0.40` = S/ 1200.
    *   Pago Final = `1200 - 200` = **S/ 1000**.

*   **Escenario B: Barbero vende S/ 2000 en servicios.**
    *   ¿Es `2000 >= (1200 * 2)`? No, `2000 < 2400`.
    *   Ingreso = `Sueldo Base` = S/ 1200.
    *   Pago Final = `1200 - 200` = **S/ 1000**.

##### **Pregunta 3: ¿Los barberos reciben comisión por la venta de productos (ej. ceras, champús)?**

No. Según la lógica de negocio actual del sistema, las comisiones de los barberos se calculan **únicamente sobre el total de los servicios que realizan**. La venta de productos de reventa (`RETAIL_PRODUCT`) no contribuye al cálculo de su comisión.

##### **Pregunta 4: ¿Cómo funcionan los combos y cómo afectan mi inventario?**

Los combos (o bundles) le permiten agrupar varios servicios y/o productos en un solo paquete con un precio especial.

**¿Cómo se crean?**
1.  Navegue a `Configuración > Combos`.
2.  Haga clic en **Añadir Combo**.
3.  Asigne un nombre (ej. "Paquete Premium de Afeitado") y un precio total para el combo.
4.  Use los selectores para añadir los `Servicios` (ej. "Afeitado Clásico") y/o `Productos del Menú` (ej. "Lata de Cerveza Artesanal") que formarán parte del paquete.
5.  Guarde el combo. Ahora estará disponible para ser añadido a una venta.

`[IMAGEN: Formulario de creación de un Combo, mostrando cómo añadir servicios y productos al paquete]`

**Gestión de Inventario con Combos:**
Cuando se vende un combo, el sistema ahora **descuenta automáticamente el inventario** de todos los componentes del paquete.
*   **Insumos de Servicios:** El sistema buscará los insumos requeridos para cada servicio dentro del combo y reducirá el stock correspondiente.
*   **Productos:** El sistema reducirá el stock de cada producto incluido en el combo.

##### **Pregunta 5: ¿Cómo manejo un producto que se vende y también se usa en servicios? (Ej: Un gel)**

Esta es una situación muy común. La solución es registrar un único `Ítem de Inventario` y conectarlo a dos salidas diferentes.

**Solución:**
1.  **Cree el Ítem de Inventario:**
    *   Vaya a `Inventario > Ítems` y cree "Gel Fijador Marca X".
    *   **Tipo de Ítem:** Puede elegir `Insumo Consumible` o `Producto de Venta`. Recomendamos **`Insumo Consumible`** para mayor claridad, ya que el sistema le permitirá usarlo en ambos flujos sin importar la elección.
    *   **Unidad de Medida:** Use la unidad más pequeña que vaya a controlar (ej. "Mililitro").

2.  **Conéctelo a un Servicio (para uso):**
    *   Vaya a `Configuración > Servicios` y edite el servicio "Peinado".
    *   En la sección "Insumos Requeridos", seleccione el ítem "Gel Fijador Marca X" y ponga la cantidad usada por servicio, por ejemplo, **10** (ml).
    *   Ahora, cada vez que venda un servicio de "Peinado", el sistema descontará 10ml del stock total de gel.

3.  **Conéctelo a un Producto del Menú (para venta):**
    *   Vaya a `Inventario > Productos del Menú` y cree "Botella de Gel Marca X".
    *   **Tipo:** Seleccione **"Directo"**.
    *   **Ítem de Inventario Asociado:** Vincúlelo al mismo "Gel Fijador Marca X".
    *   **Importante:** Al vender este producto, el sistema descontará la cantidad que usted especifique al momento de la venta del `Ítem de Inventario` en su unidad base (ml). Si vende una botella de 500ml, debe asegurarse de que la venta descuente 500 unidades (ml) del inventario. Para simplificar, se recomienda el enfoque de la siguiente pregunta.

##### **Pregunta 6: ¿Cómo manejo la compra en cajas, almacenamiento en potes y uso en mililitros? (Ej: Cera)**

El sistema no realiza conversiones de unidades automáticas. La práctica recomendada es **registrar el ítem en la unidad más pequeña que consume**.

**Escenario:** Compra 1 caja con 10 potes de cera. Cada pote tiene 100ml. En cada servicio de peinado se usan 5ml.

**Solución Paso a Paso:**

1.  **Defina la Unidad Base:** Su unidad más pequeña de consumo es el **mililitro (ml)**. Esta será su unidad de medida en el sistema.

2.  **Cree el Ítem de Inventario:**
    *   Vaya a `Inventario > Ítems` y cree el ítem "Cera Moldeadora Profesional".
    *   En `Tipo de Unidad`, seleccione "Mililitro" (si no existe, créela en la configuración).

3.  **Registre la Adquisición (Compra):**
    *   Vaya a `Inventario > Adquisiciones`.
    *   Usted compró 1 caja, que son 10 potes, que son un total de `10 potes * 100 ml/pote = 1000 ml`.
    *   Cree la adquisición y añada la línea de detalle para "Cera Moldeadora Profesional" con una **Cantidad de 1000**.
    *   Su stock ahora será de 1000 ml.

4.  **Configure el Consumo en el Servicio:**
    *   Vaya a `Configuración > Servicios` y edite el servicio "Peinado con Cera".
    *   En "Insumos Requeridos", seleccione "Cera Moldeadora Profesional" y establezca la **Cantidad Usada en 5** (porque se usan 5 ml).

**Resultado:** Con esta configuración, cada vez que venda un "Peinado con Cera", su stock de cera disminuirá en 5 ml, dándole un control preciso y real de sus existencias.

##### **Pregunta 7: ¿Cuál es la diferencia entre "Persona", "Cliente" y "Usuario"?**

Esta es una distinción clave para organizar su información en el sistema:

*   **Persona:** Es la entidad base. Un registro de un individuo con sus datos básicos (nombre, DNI, email, teléfono, dirección, fecha de nacimiento). Piense en ello como la "ficha personal" en un archivador. **Toda entidad humana** que interactúa con su negocio (empleados, clientes, contactos de proveedores) debe ser primero una `Persona`.
*   **Cliente:** Es una `Persona` que recibe servicios o compra productos en su barbería. Al crear un `Cliente`, se vincula a una `Persona` existente y se le pueden asignar datos específicos de cliente como `Puntos de Lealtad` o `Notas`.
*   **Usuario:** Es una `Persona` que tiene acceso al sistema (puede iniciar sesión). A un `Usuario` se le asigna un `Rol` (`administrador`, `cajero`) que define qué módulos y funcionalidades puede ver y utilizar. Un `Usuario` es siempre un empleado o alguien del equipo, no un cliente final.

**En resumen:** Se crea una `Persona` y luego se le "asigna un rol" o "tipo de relación" convirtiéndola en `Cliente` (para agendarle citas y registrar sus compras) o en `Usuario` (para darle acceso al sistema). Una misma `Persona` podría ser un `Cliente` y un `Usuario` (ej. un barbero que también es cliente).

##### **Pregunta 8: Cometí un error en una venta. ¿Cómo la corrijo o la anulo?**

El sistema no permite "editar" una venta una vez que ha sido registrada para mantener la integridad de los datos. Sin embargo, sí permite **anular** una venta.

**Para anular una venta:**
1.  Vaya a `Reportes > Ventas Detallado`.
2.  Busque la venta específica que desea anular utilizando los filtros de fecha, cliente, etc.
3.  En la fila de la venta, haga clic en el botón de acción (generalmente un icono de "más opciones" o "ver detalles") y seleccione **Anular Venta**.
4.  El sistema le pedirá que proporcione un **Motivo de Anulación**. Esto es importante para la auditoría.
5.  **¿Qué sucede al anular una venta?**
    *   El estado de la venta cambia a "Anulada".
    *   **El stock se revierte:** Todos los productos e insumos que se descontaron automáticamente al registrar esa venta son devueltos al inventario. Esto asegura que su control de existencias sea preciso.
    *   Si la venta provenía de una reserva, el estado de la reserva asociada vuelve a "Reservado", permitiendo que pueda ser completada nuevamente (si el error fue en el proceso de venta) o cancelada.

##### **Pregunta 9: ¿Qué pasa si cambio el precio de un servicio? ¿Afecta a las citas ya agendadas?**

No, no afecta a las citas ya existentes.

Cuando usted crea una reserva, el sistema **guarda el precio del servicio en ese momento** junto con los detalles de la reserva. Si más tarde usted actualiza el precio de un servicio (ej. sube el precio de "Corte de Cabello" de S/ 20 a S/ 25), todas las reservas que ya estaban agendadas mantendrán el precio original de S/ 20. Solo las **nuevas reservas** que se creen a partir de ese momento usarán el nuevo precio de S/ 25. Esto asegura que los clientes paguen el precio acordado al momento de la reserva.

##### **Pregunta 10: ¿Para qué sirve el campo "Puntos de Lealtad" en el perfil del cliente?**

El campo `Puntos de Lealtad` existe en el perfil del cliente y en la base de datos para **futuras funcionalidades**. Actualmente, la lógica para **acumular o canjear estos puntos todavía no ha sido implementada** en el sistema. Es una característica planificada para el futuro que permitirá crear programas de fidelización para sus clientes.

##### **Pregunta 11: ¿Qué pasa si elimino una "Persona"?**

Esta es una acción con consecuencias importantes que debe realizarse con mucho cuidado.

Debido a que la `Persona` es la entidad central, eliminarla provoca un **borrado en cascada**. Esto significa que si elimina el registro de una persona, el sistema también eliminará **automáticamente** todos los registros asociados a ella, incluyendo:
*   Su cuenta de **Usuario** (si la tuviera).
*   Su perfil de **Cliente** (borrando su historial de citas).
*   Su registro de **Barbero** (si fuera un empleado).

**Recomendación:** En lugar de eliminar a un empleado que ya no trabaja en el local, es mejor ir a `Personal > Barberos` y marcarlo como **inactivo**. De esta forma, no aparecerá en las listas para nuevas reservas, pero conservará todo su historial de ventas y comisiones para futuras consultas. Elimine una `Persona` solo si el registro se creó por error y no tiene historial.

##### **Pregunta 12: Mi stock físico no coincide con el stock del sistema. ¿Cómo lo corrijo?**

Esto es normal en cualquier negocio y se soluciona realizando un **Ajuste de Inventario**.

1.  **Realice un conteo físico:** Primero, cuente las unidades reales que tiene de un ítem específico en su almacén.
2.  **Calcule la diferencia:** Compare su conteo físico con lo que muestra el sistema en `Inventario > Ítems`.
3.  **Registre el Ajuste:**
    *   Vaya a `Inventario > Movimientos de Inventario`.
    *   Haga clic en **Registrar Movimiento**.
    *   **Ítem de Inventario:** Seleccione el producto que desea ajustar.
    *   **Tipo de Movimiento:** Elija **`ADJUSTMENT` (Ajuste)**.
    *   **Cantidad:** Ingrese la diferencia que calculó.
        *   Si tiene **más** producto del que dice el sistema (ej. sistema dice 10, pero tiene 12), haga un ajuste positivo de **+2**.
        *   Si tiene **menos** producto (ej. sistema dice 10, pero tiene 7), haga un ajuste negativo de **-3**.
    *   **Notas:** Es muy recomendable que explique el motivo del ajuste (ej. "Ajuste por conteo físico anual", "Error en ingreso de adquisición anterior").
4.  Guarde el movimiento. El stock del sistema se actualizará para coincidir con la realidad.

##### **Pregunta 13: ¿Qué es una "Cortesía" y cómo funciona?**

Una "Cortesía" es cuando decides regalar un producto o servicio a un cliente sin costo alguno.

*   **¿Cómo se marca?** Durante el proceso de registrar una venta (ya sea desde una reserva o una venta directa), en la lista de ítems a cobrar, verá una opción (probablemente una casilla de verificación o un botón) para marcar cualquier ítem como **Cortesía**.
*   **¿Qué sucede?**
    *   Al marcar un ítem como cortesía, su precio cambia a **cero** y no se suma al monto total a pagar por el cliente.
    *   El sistema le pedirá un **motivo** para la cortesía (ej. "Promoción", "Compensación por espera", "Cliente frecuente").
    *   Aunque el precio es cero, el ítem **sí se descuenta del inventario**. Si regala una botella de cera, el stock de esa cera disminuirá en uno.
    *   La venta queda registrada con el detalle de la cortesía, lo que le permite generar reportes para saber cuánto está "invirtiendo" en estos regalos.

##### **Pregunta 14: ¿Cuál es la diferencia entre "Ítems de Inventario" y "Productos del Menú"?**

Esta es una de las distinciones más importantes para usar el inventario correctamente.

*   **`Ítems de Inventario` (`Inventario > Ítems`):**
    *   **¿Qué son?** Son sus existencias físicas, la materia prima, lo que usted tiene en sus estantes y almacenes.
    *   **Ejemplos:** "Botella de Champú Anti-caspa (500ml)", "Gramos de café en grano", "Navaja de afeitar desechable".
    *   **Propósito:** Controlar el stock real. Su cantidad sube con las `Adquisiciones` y baja con las `Ventas` y `Bajas`.

*   **`Productos del Menú` (`Inventario > Productos del Menú`):**
    *   **¿Qué son?** Son los artículos que aparecen en su punto de venta (POS), lo que usted le ofrece y le cobra al cliente.
    *   **Ejemplos:** "Venta de Champú Anti-caspa", "Taza de Café Americano", "Servicio de Afeitado Clásico".
    *   **Propósito:** Ser la cara visible en una transacción. Un `Producto del Menú` está conectado a uno o varios `Ítems de Inventario` y actúa como un "disparador" que descuenta el stock de ellos.

**Analogía:** Piense en un restaurante. Los `Ítems de Inventario` son los kilos de harina, los tomates y el queso en la despensa. El `Producto del Menú` es la "Pizza Margarita" que el cliente ordena. Al vender una pizza, se descuentan las cantidades correspondientes de harina, tomate y queso del inventario.

##### **Pregunta 15: ¿Puedo registrar gastos como el alquiler o los sueldos en el sistema?**

No. El sistema está especializado en la **gestión de inventario y los costos asociados a la mercancía (Costo de Bienes Vendidos - COGS)**. El módulo de `Adquisiciones` está diseñado para registrar la compra de productos que afectan su stock.

Para gastos operativos que no son de inventario, como el alquiler del local, facturas de servicios (luz, agua), marketing o los sueldos del personal, deberá utilizar un software de contabilidad general o un método de seguimiento externo.

##### **Pregunta 16: ¿Por qué no puedo eliminar un Servicio, Proveedor o Categoría?**

El sistema protege la integridad de sus datos históricos. Si usted intenta eliminar un registro que está siendo utilizado en otra parte del sistema, la base de datos lo impedirá para evitar inconsistencias.

*   **Ejemplo 1:** No puede eliminar un `Servicio` si este ya ha sido parte de alguna `Reserva` o `Venta` pasada. Borrarlo dejaría esas ventas históricas "huérfanas", sin saber qué servicio se vendió.
*   **Ejemplo 2:** No puede eliminar un `Proveedor` si ya le ha registrado alguna `Adquisición`.
*   **Ejemplo 3:** No puede eliminar una `Categoría de Ítem` si al menos un `Ítem de Inventario` pertenece a esa categoría.

**La Solución Correcta: Desactivar.**
En lugar de eliminar, utilice la casilla **`Activo`**. Si desmarca esta casilla en un servicio, barbero, producto, etc., el ítem desaparecerá de las listas y selectores para futuras transacciones, pero se mantendrá en el sistema para que sus reportes históricos sigan siendo precisos.

##### **Pregunta 17: ¿Para qué sirve la casilla "Activo"?**

La casilla `Activo`, presente en casi todos los módulos (Servicios, Barberos, Productos, etc.), es la forma correcta de gestionar el ciclo de vida de sus registros. Es su "interruptor de encendido y apagado".

*   **Si está marcada (`Activo`):** El ítem está disponible para ser usado en el día a día. Un servicio activo puede ser reservado, un producto activo puede ser vendido, un barbero activo aparece en el calendario.
*   **Si no está marcada (`Inactivo`):** El ítem se oculta de las operaciones nuevas, pero no se borra.
    *   Un servicio inactivo no aparecerá en la lista al crear una nueva reserva.
    *   Un producto de menú inactivo no podrá ser añadido a una nueva venta.
    *   Un barbero inactivo no podrá ser seleccionado para nuevas citas.

Usar el estado `Activo`/`Inactivo` en lugar de `Eliminar` le garantiza que nunca perderá información histórica valiosa para sus reportes y análisis.

---

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

## 7. Módulo de Personal

### 7.1 Barberos (`Personal > Barberos`)

Gestiona la información de los barberos.

1.  Navegue a **Personal** > **Barberos**.
2.  Para **Añadir un Barbero**, debe existir previamente como una "Persona" en el sistema.
3.  Asocie la persona a un registro de barbero y establezca su **Porcentaje de Comisión** por servicios y productos.

### 7.2 Pagos a Barberos (`Personal > Pagos`)

Calcula y registra el pago de comisiones.

1.  Seleccione un **Barbero** y un **Rango de Fechas**.
2.  El sistema mostrará todas las ventas asociadas y calculará la comisión total.
3.  Puede registrar **Adelantos** si es necesario.
4.  Haga clic en **Finalizar y Registrar Pago** para marcar las comisiones como pagadas y generar un recibo.

`[IMAGEN: Vista de Pagos a Barberos con el detalle de comisiones y el botón para finalizar el pago]`

## 8. Módulo de Configuración

Aquí se gestionan los parámetros fundamentales del sistema.

### 8.1 Personas (`Configuración > Personas`)

Es la base de datos central de todos los individuos relacionados con el negocio (empleados, clientes, contactos de proveedores). Antes de crear un usuario, cliente o barbero, debe existir un registro de persona.

### 8.2 Usuarios (`Configuración > Usuarios`)

Crea y gestiona las cuentas de acceso al sistema.

1.  Haga clic en **Añadir Usuario**.
2.  **Persona:** Seleccione una persona existente.
3.  **Email y Contraseña:** Defina las credenciales de inicio de sesión.
4.  **Rol:** Asigne un rol (Administrador, Barbero, Recepción) que determinará sus permisos.

### 8.3 Estaciones (`Configuración > Estaciones`)

Crea y gestiona las estaciones de trabajo físicas de la barbería.

### 8.4 Servicios (`Configuración > Servicios`)

Define los servicios que ofrece la barbería.

1.  Haga clic en **Añadir Servicio**.
2.  Complete **Nombre**, **Descripción**, **Precio** y **Duración**.
3.  **Insumos del Servicio:** Especifique qué **Ítems de Inventario** y en qué **cantidad** se consumen al realizar este servicio (ej. 10ml de champú, 1 navaja desechable). Estos se descontarán automáticamente del stock cuando el servicio se venda.

`[IMAGEN: Formulario de creación de servicio, resaltando la sección 'Insumos del Servicio']`

### 8.5 Guía Detallada de Combos (`Configuración > Combos`)

El módulo de **Combos** (o Bundles) es una herramienta poderosa para crear paquetes de marketing atractivos, agrupando servicios y productos a un precio especial.

#### **Conceptos Clave de los Combos**

*   **Paquete Fijo:** Puede crear un combo donde todos los ítems son fijos. Ejemplo: "Paquete Básico" = 1 Corte de Cabello + 1 Afeitado de Barba.
*   **Paquete con Opciones (Grupos de Elección):** Esta es la funcionalidad más avanzada. Puede definir un grupo de ítems donde el cliente final solo puede elegir **uno**. Ejemplo: "Paquete Premium" = 1 Corte de Cabello + 1 Bebida a elección (donde "Bebida" puede ser una Cerveza, un Refresco o un Agua).

#### **Guía Paso a Paso para Crear un Combo**

1.  Navegue a **Configuración** > **Combos**.
2.  Haga clic en el botón **`Añadir Combo`**. Se abrirá el formulario de creación.

`[IMAGEN: Formulario de 'Añadir Combo' vacío]`

3.  **Complete los Detalles Principales:**
    *   **Nombre del Combo:** Un nombre descriptivo y atractivo (ej. "Experiencia VIP", "Tratamiento Facial Completo").
    *   **Descripción:** Explique brevemente qué incluye el combo.
    *   **Activo:** Marque esta casilla para que el combo esté disponible para la venta.

4.  **Añada los Ítems al Combo:**
    *   Utilice los botones **`Añadir Servicio`** o **`Añadir Producto`** para abrir un selector.
    *   Busque y seleccione el ítem que desea incluir. Puede añadir tantos como necesite.

5.  **Configure cada Ítem del Combo:**
    Una vez añadido, cada ítem en la lista tendrá las siguientes opciones:
    *   **Cantidad:** El número de unidades de ese ítem que se incluirán. Para un servicio, esto suele ser `1`.
    *   **Grupo (Opcional):** Aquí es donde se configura la magia de los ítems opcionales.
        *   **Para crear un grupo de elección:** Asigne el mismo nombre de grupo a varios ítems. Por ejemplo, si quiere que el cliente elija entre una Cerveza o un Refresco, añada ambos productos al combo y en el campo `Grupo` escriba "Bebida" para los dos.
        *   Al momento de la venta, el sistema le pedirá al cajero que seleccione solo uno de los ítems del grupo "Bebida".
        *   Si un ítem no pertenece a ningún grupo de elección, deje este campo vacío.

`[IMAGEN: Lista de ítems dentro de un combo, mostrando dos productos con el mismo 'Grupo' ("Bebida") y un servicio sin grupo]`

6.  **Verifique el Precio:**
    *   El **Precio de Venta** del combo se calcula automáticamente como la **suma de los precios base** de todos los ítems fijos más el precio del ítem **más caro** de cada grupo de elección.
    *   **Importante:** Actualmente, el precio es calculado y no se puede sobrescribir manualmente. Si desea ofrecer un descuento, el precio de los ítems individuales debe ser ajustado o se debe aplicar un descuento general al momento de la venta.

7.  Haga clic en **`Guardar Combo`**.

**Resultado Final:**
Su combo está listo para ser seleccionado en el punto de venta. Al venderlo, el sistema descontará correctamente el stock del ítem elegido de cada `Grupo de Elección`, así como de todos los ítems fijos.

## 9. Módulo de Reportes

Ofrece análisis detallados sobre el rendimiento del negocio.

*   **Reporte Detallado de Ventas:** Un análisis exhaustivo de las ventas filtrable por fecha, barbero, cliente, etc.
*   **Reporte de Ventas por Tipo:** Compara ingresos por servicios vs. productos.
*   **Reporte de Inventario:** Muestra el valor del stock actual, alertas de stock bajo y movimientos.
*   **Reporte de Uso de Estaciones:** Analiza qué estaciones son las más utilizadas.
*   **Reporte de Frecuencia de Clientes:** Identifica a sus clientes más leales.
*   **Reporte de Horas Pico:** Muestra qué días y horas tienen más demanda.
*   **Reporte de Pagos a Barberos:** Un historial de todos los pagos de comisiones realizados.

`[IMAGEN: Página principal de Reportes, mostrando las diferentes opciones de reportes disponibles]`

## 10. Perfil de Usuario

1.  Haga clic en su nombre en la esquina superior derecha y seleccione **Mi Perfil**.
2.  Aquí puede ver su información personal y cambiar su contraseña.

---
**Fin del Manual de Usuario**