# Manual de Usuario: Sistema de Gestión de Barbería

## 1. Introducción

### 1.1. Propósito del Sistema

Bienvenido al Manual de Usuario del Sistema de Gestión de Barbería. Esta aplicación ha sido diseñada para optimizar y centralizar todas las operaciones clave de su negocio, desde la gestión de citas y personal hasta el control de inventario y la generación de reportes financieros. Nuestro objetivo es proporcionarle una herramienta intuitiva y eficiente que le permita enfocarse en lo que mejor sabe hacer: ofrecer un excelente servicio a sus clientes.

### 1.2. Audiencia

Este manual está dirigido a todos los usuarios del sistema, incluyendo:

*   **Administradores:** Encargados de la configuración general, gestión de usuarios, roles, y acceso a todos los módulos.
*   **Personal de Recepción/Caja:** Responsables de la programación de citas, registro de ventas y gestión de clientes.
*   **Barberos/Estilistas:** Usuarios que gestionarán sus citas, comisiones y podrán ver sus reportes.

### 1.3. Convenciones del Manual

Para una fácil comprensión, utilizamos las siguientes convenciones:

*   **`Texto en negrita`**: Indica elementos de la interfaz de usuario como botones, menús, campos de texto o títulos de secciones.
*   **`Texto en cursiva`**: Resalta términos importantes, conceptos clave o nombres de roles.
*   `>`: Indica una secuencia de navegación en el menú (ej. **Menú Principal > Inventario > Ítems**).
*   `[IMAGEN: ... ]`: Indica un lugar sugerido para insertar una captura de pantalla que ilustre la funcionalidad descrita.

---

## 2. Primeros Pasos

### 2.1. Acceso al Sistema

1.  Abra su navegador web preferido (Google Chrome, Firefox, Safari, etc.).
2.  Ingrese la URL de la aplicación proporcionada por su administrador.
3.  Será redirigido a la página de **Inicio de Sesión**.

![Pantalla de Inicio de Sesión](C:/Users/angel/.gemini/antigravity/brain/a82418e8-31db-410b-93c6-1ec2d0323797/login_page_mockup_1764223925188.png)

### 2.2. Inicio de Sesión

1.  En la página de **Inicio de Sesión**, ingrese su **Correo Electrónico** y **Contraseña**.
2.  Haga clic en el botón **`Iniciar Sesión`**.
3.  Si sus credenciales son correctas, será redirigido al **Dashboard** principal. Si olvida su contraseña, utilice la opción correspondiente para recuperarla.

### 2.3. Interfaz Principal

La interfaz se compone de tres áreas principales:

*   **Barra Lateral de Navegación (Menú):** A la izquierda, contiene los enlaces a todos los módulos del sistema. Los módulos visibles dependen de los permisos asignados a su rol.
*   **Barra Superior:** Muestra el nombre del usuario actual y un menú desplegable para acceder a su **Perfil** y **Cerrar Sesión**.
*   **Área de Contenido Principal:** La sección central donde se muestran los datos, formularios y gráficos del módulo que haya seleccionado.

![Vista General del Dashboard](C:/Users/angel/.gemini/antigravity/brain/a82418e8-31db-410b-93c6-1ec2d0323797/dashboard_mockup_1764223963685.png)

### 2.4. Cerrar Sesión

Para cerrar su sesión de forma segura:
1.  Haga clic en su nombre de usuario en la esquina superior derecha.
2.  Seleccione **`Cerrar Sesión`** en el menú desplegable.

---

## 3. Dashboard (Panel Principal)

El **Dashboard** es su pantalla de inicio y ofrece una visión general del estado del negocio en tiempo real. Es la primera pantalla que verá después de iniciar sesión.

*   **Tarjetas de Métricas Clave:** Resúmenes rápidos de:
    *   **Ventas de Productos (Hoy):** Total vendido en productos.
    *   **Ventas de Servicios (Hoy):** Total vendido en servicios.
    *   **Reservas para Hoy:** Número de citas agendadas.
    *   **Clientes Atendidos (Hoy):** Conteo de servicios completados.
*   **Resumen Financiero:** Muestra el total de ingresos y un desglose por método de pago (Efectivo, Tarjeta, Transferencia, Yape, Plin).
*   **Pagos a Barberos (Mes Actual):** Una tabla que muestra el total generado por cada barbero y su comisión calculada.
*   **Servicios Populares (Semana):** Un gráfico de dona que muestra los servicios más demandados.
*   **Ventas Generales (Últimos 30 Días):** Un gráfico de área que muestra la tendencia de ventas, con desglose entre productos y servicios.

![Dashboard Completo](C:/Users/angel/.gemini/antigravity/brain/a82418e8-31db-410b-93c6-1ec2d0323797/dashboard_mockup_1764223963685.png)

---

## 4. Módulo de Agenda y Citas

Este módulo es el centro neurálgico para la gestión diaria de citas.

### 4.1. Calendario de Citas (`Agenda y Citas > Calendario`)

Ofrece una vista visual de todas las citas, organizadas por barbero y hora.

*   **Navegación:** Vaya a **`Agenda y Citas > Calendario`**.
*   **Vistas:** Puede cambiar entre la vista **Semanal** (por defecto), **Diaria** y **Lista**.
*   **Navegar Fechas:** Use los controles de flecha o el selector de fecha para ir al día o semana que desee consultar.
*   **Visualización:** Las citas se muestran como bloques de color en la columna del barbero y la franja horaria correspondiente. Los colores indican el estado de la reserva (ej. `Pendiente`, `Confirmada`, `Completada`, `Cancelada`).

![Calendario Semanal](C:/Users/angel/.gemini/antigravity/brain/a82418e8-31db-410b-93c6-1ec2d0323797/calendar_mockup_1764224006492.png)

### 4.2. Crear una Nueva Reserva

**Ejemplo:** *Ana, la recepcionista, necesita agendar un "Corte de Cabello" para un cliente existente, Juan Pérez, con el barbero Carlos para mañana a las 10:00 AM.*

1.  **Desde el Calendario:** Ana navega al día de mañana y hace clic directamente en el espacio de las 10:00 AM bajo la columna de "Carlos". Esto abre el formulario **`Crear Nueva Reserva`** con la fecha y hora ya seleccionadas.
    *   Alternativa: Puede hacer clic en el botón **`Añadir Reserva`** en la parte superior.
2.  **Formulario de Reserva:**
    *   **Cliente:** Ana empieza a escribir "Juan Pérez". El sistema lo encuentra y lo selecciona.
        *   Si fuera un cliente nuevo, haría clic en el botón **`+`** o **`Crear Nuevo Cliente`** para registrar sus datos básicos (nombre y teléfono) sin salir de esta pantalla.
    *   **Barbero:** "Carlos" ya está seleccionado.
    *   **Servicio:** Selecciona "Corte de Cabello" de la lista. Si el cliente quisiera un afeitado también, puede añadir múltiples servicios.
    *   **Fecha y Hora:** Ya están correctas (mañana, 10:00 AM).
    *   **Notas:** Juan menciona que prefiere no usar secador. Ana lo anota en el campo **Notas**.
3.  **Guardar:** Ana hace clic en **`Guardar Reserva`**. La cita aparece inmediatamente en el calendario.

`[IMAGEN: Modal 'Crear Nueva Reserva' con los campos del ejemplo de Juan Pérez]`

### 4.3. Gestionar una Reserva Existente

1.  Haga clic sobre una cita en el **Calendario**.
2.  Se abrirá un modal con los detalles y las siguientes opciones:
    *   **`Editar`**: Permite modificar cualquier detalle de la reserva (cambiar de hora, de barbero, de servicio, etc.).
    *   **`Cancelar`**: Cambia el estado de la reserva a "Cancelada" y libera el espacio. Es importante usar esta opción para mantener el historial limpio.
    *   **`Registrar Venta`**: Es el paso clave para cobrar. Inicia el proceso de cobro en el Punto de Venta y convierte la reserva en una venta (ver Módulo de Ventas).

### 4.4. Lista de Reservas (`Agenda y Citas > Lista`)

Ofrece una vista de tabla para buscar y filtrar todas las reservas. Es útil para encontrar rápidamente una cita sin navegar por el calendario.

1.  Navegue a **`Agenda y Citas > Lista`**.
2.  Use los filtros en la parte superior para buscar por **Rango de Fechas**, **Barbero**, **Cliente** o **Estado**.
3.  Desde esta tabla, también puede **Editar**, **Cancelar** o **Registrar Venta** usando los botones de acción en cada fila.

---

## 5. Módulo de Ventas (Punto de Venta - POS)

Este módulo gestiona todas las transacciones. El flujo de venta puede iniciar desde una reserva (lo más común) o como una venta directa.

### 5.1. Completar una Venta desde una Reserva (Flujo Principal)

**Ejemplo 1 (Servicio + Producto Barbero):** *Juan Pérez ha terminado su "Corte Fade" con Carlos y decide llevarse una "Cera Moldeadora".*

1.  **Iniciar el Cobro:** Ana, en recepción, busca la cita de Juan en el calendario y hace clic en **`Registrar Venta`**.
2.  **Pantalla de Venta (POS):** Se abre la interfaz de Punto de Venta.

    ![Punto de Venta](C:/Users/angel/.gemini/antigravity/brain/a82418e8-31db-410b-93c6-1ec2d0323797/pos_mockup_1764224041964.png)
    *   La información de la reserva ya está cargada: Cliente (Juan Pérez), Barbero (Carlos) y el servicio "Corte Fade" con su precio (ej. S/ 25).
3.  **Añadir Productos:**
    *   Ana hace clic en el botón **`Añadir Producto`**.
    *   Busca "Cera Moldeadora" y la agrega al carrito de la venta (ej. S/ 35).
4.  **Verificar el Total y Aplicar Descuentos:** El sistema muestra el total (ej. S/ 25 + S/ 35 = S/ 60).
5.  **Seleccionar Método de Pago:** Juan paga con tarjeta. Ana selecciona **`Tarjeta`**. El sistema también soporta **Efectivo**, **Transferencia**, **Yape** y **Plin**.
6.  **Confirmar Venta:** Ana hace clic en **`Registrar Venta`**.
    *   **¿Qué pasa en el sistema?**
        *   La transacción financiera queda registrada.
        *   El estado de la reserva de Juan cambia a **`Completada`**.
        *   El stock de "Cera Moldeadora (Pote 100g)" se descuenta en 1 unidad.
        *   El stock de los insumos del "Corte Fade" (ej. 1 "Navaja de Afeitar (Unidad)", 10ml de "Champú Profesional (Botella 1L)") se descuenta automáticamente.
        *   La venta se asocia a Carlos para el cálculo de su comisión.

**Ejemplo 2 (Venta de Combo Fijo):** *María ha agendado un "Corte Fade" y, al llegar, decide que también quiere un "Capuchino". En lugar de venderlos por separado, Ana le ofrece el combo "Corte Fade + Capuchino".*

1.  **Iniciar el Cobro:** Ana busca la cita de María y hace clic en **`Registrar Venta`**.
2.  **Pantalla de Venta (POS):**
    *   El servicio "Corte Fade" de la reserva ya está cargado.
    *   Ana **elimina** el servicio individual "Corte Fade" para vender el combo.
    *   Hace clic en el botón **`Añadir Combo`**.
    *   Busca y selecciona el combo "Corte Fade + Capuchino" (ej. S/ 33).
3.  **Verificar el Total y Seleccionar Método de Pago:** María paga el total (S/ 33).
4.  **Confirmar Venta:** Ana hace clic en **`Registrar Venta`**.
    *   **¿Qué pasa en el sistema?**
        *   El sistema registra la venta del combo.
        *   El estado de la reserva de María cambia a **`Completada`**.
        *   **Deducción de inventario del Combo:**
            *   Los insumos del "Corte Fade" (Navaja de Afeitar, Champú Profesional) se descuentan.
            *   Los ingredientes del "Capuchino" (Grano de Café, Leche, Azúcar, Agua Filtrada) se descuentan según la receta, utilizando las unidades base definidas.

### 5.2. Registrar una Venta Directa (Walk-in)

**Ejemplo (Productos de Barbería y Cafetería):** *Un cliente entra sin cita, compra un "Champú Profesional" y un "Capuchino".*

1.  **Iniciar Venta Directa:** Ana va a **`POS > Nueva Venta`**.
2.  **Pantalla de Venta (POS):**
    *   **Cliente (Opcional):** El cliente es nuevo y prefiere no registrarse. Ana procede con una venta anónima.
    *   **Barbero:** No es necesario asignar un barbero para esta venta, ya que no incluye servicios comisionables.
    *   **Añadir Productos:**
        *   Ana hace clic en **`Añadir Producto`**, busca "Champú Profesional" (ej. S/ 45) y lo añade.
        *   Vuelve a hacer clic en **`Añadir Producto`**, busca "Capuchino" (ej. S/ 8) y lo añade.
    *   El total es S/ 45 + S/ 8 = S/ 53.
3.  **Completar el Pago:** El cliente paga en efectivo. Ana selecciona **`Efectivo`** y registra el pago.
    *   **¿Qué pasa en el sistema?**
        *   La transacción se registra.
        *   El stock de "Champú Profesional (Botella 1L)" se descuenta en 1 unidad.
        *   El stock de los ingredientes del "Capuchino" (Grano de Café, Leche, Azúcar, Agua Filtrada) se descuentan según la receta y unidades base.


### 5.3. Anular una Venta

**Ejemplo:** *Ana se equivocó y cobró un producto incorrecto a Juan. Necesita anular la venta para rehacerla.*

1.  **Buscar la Venta:** Ana va a **`Reportes > Ventas Detallado`**, que funciona como el historial de ventas.
2.  Utiliza el filtro por fecha y cliente para encontrar la venta de Juan Pérez.
3.  **Anular:** En la fila de la venta, hace clic en el botón de opciones y selecciona **`Anular Venta`**.
4.  **Motivo:** El sistema le pide un motivo para la anulación (ej. "Error en cobro de ítem"). Esto es obligatorio y queda registrado para auditoría.
5.  **Confirmar:** Tras confirmar, el sistema realiza una **reversión completa**:
    *   El estado de la venta cambia a **`Anulada`**.
    *   **El stock se devuelve:** La "Cera Moldeadora" y los insumos del servicio vuelven a estar disponibles en el inventario.
    *   La reserva de Juan vuelve al estado **`Reservado`**, lista para que Ana inicie el proceso de venta de nuevo, esta vez correctamente.

### 5.4. Cortesías

Cuando decides regalar un producto o servicio a un cliente:

1.  Durante el proceso de venta, en el carrito, cada ítem (servicio o producto) tiene una opción para ser marcado como **`Cortesía`** (ej. un checkbox o un botón).
2.  Al marcarlo, su precio cambia a **cero**.
3.  El sistema pedirá un **motivo** para la cortesía (ej. "Compensación", "Promoción").
4.  **Importante:** Aunque el precio sea cero, el ítem **sí se descuenta del inventario**. Esto permite tener un control de los costos asociados a las cortesías.

---

## 6. Módulo de Inventario: Guía Completa

El módulo de inventario es el corazón del control de existencias. Entender su estructura es clave para una gestión exitosa.

`[IMAGEN: Diagrama de flujo simple mostrando: Configuración -> Ítems de Inventario -> Entradas (Adquisiciones) / Salidas (Ventas, Bajas) -> Movimientos]`

### **Paso 1: La Base - Configuración del Inventario**

Antes de añadir productos, debes establecer las bases para organizarlos. Ve a `Inventario > Configuración`.

*   **`Tipos de Unidad`**:
    *   **¿Qué es?** Define las unidades en las que mides tus productos.
    *   **Ejemplos:** "Unidad(es)", "Litro(s)", "Gramo(s)", "Caja(s)", "Mililitro(s)".
    *   **Importancia:** Es esencial para la consistencia y el control preciso del stock. La clave es elegir la **unidad base** más pequeña en la que consumes o utilizas el producto.

    *   **Concepto de Unidad Base (Factor de Conversión):**
        *   El sistema no realiza conversiones automáticas entre unidades (ej. no sabe que 1 litro = 1000 mililitros si no lo indicas).
        *   Por lo tanto, la **mejor práctica es registrar cada `Ítem de Inventario` en la unidad más pequeña** en la que lo vas a utilizar o consumir.
        *   **Ejemplo 1 (Leche):** Si compras leche por litros (en cajas de 6 x 1L) pero la usas en cafés en porciones de 100ml, tu unidad base para el ítem "Leche Fresca" debería ser **"Mililitro(s)"**.
        *   **Ejemplo 2 (Café):** Si compras café en paquetes de 500g o 1kg, pero cada taza de café consume 18g, tu unidad base para el ítem "Café en Grano" debería ser **"Gramo(s)"**.

    *   Al registrar tus adquisiciones o consumos, siempre deberás ingresar las cantidades en esta unidad base. Esto es fundamental para que el stock refleje la realidad.

*   **`Categorías de Ítems`**:
    *   **¿Qué es?** Permite agrupar tus ítems de inventario.
    *   **Ejemplos:** "Cuidado del Cabello", "Herramientas", "Bebidas", "Limpieza".
    *   **Importancia:** Facilita la búsqueda, filtrado y generación de reportes.

*   **`Ubicaciones`**:
    *   **¿Qué es?** Define los lugares físicos donde almacenas tus productos.
    *   **Ejemplos:** "Almacén Principal", "Estante A-1", "Recepción", "Nevera".
    *   **Importancia:** Ayuda al personal a encontrar productos y a realizar inventarios físicos.

### **Paso 2: El Núcleo - Ítems de Inventario (`Inventario > Ítems`)**

Esta es la lista maestra de **todo lo que posees físicamente**. Cada producto, insumo o herramienta debe ser registrado aquí primero.

![Lista de Ítems de Inventario](C:/Users/angel/.gemini/antigravity/brain/a82418e8-31db-410b-93c6-1ec2d0323797/inventory_items_mockup_1764224063636.png)

#### **Tipos de Ítem Explicados:**

*   **`Insumo Consumible (CONSUMABLE_SUPPLY)`**:
    *   **¿Qué es?** Un producto que se gasta o consume al realizar un servicio.
    *   **Ejemplos:** El champú para lavar el cabello, la cera para un peinado, una navaja desechable.
    *   **Uso en el sistema:** Se vinculan a un `Servicio` en "Insumos Requeridos". Al vender el servicio, el stock de estos insumos se descuenta automáticamente.

*   **`Producto de Venta (RETAIL_PRODUCT)`**:
    *   **¿Qué es?** Un producto que compras y vendes directamente al cliente.
    *   **Ejemplos:** Botellas de cera de marca, latas de cerveza, champús en empaque original.
    *   **Uso en el sistema:** Se vincula a un `Producto del Menú` de tipo "Directo". Al venderse, el stock se descuenta 1 a 1.

*   **`Materia Prima (RAW_MATERIAL)`**:
    *   **¿Qué es?** Un ingrediente usado para crear otro producto. No se vende tal cual ni se usa directamente en un servicio estándar.
    *   **Ejemplo:** Compras "pigmento rojo" y "peróxido" por separado. Los mezclas para crear un "tinte rojo personalizado". El pigmento y el peróxido son Materia Prima.
    *   **Uso en el sistema:** Se usarían en la "receta" de un `Producto del Menú` de tipo "Compuesto".

*   **`Activo Operacional (OPERATIONAL_ASSET)`**:
    *   **¿Qué es?** Un artículo propiedad del negocio, de uso repetido, pero que no se consume ni se vende.
    *   **Ejemplos:** Máquinas de cortar, tijeras, toallas, sillas de barbero.
    *   **Uso en el sistema:** Se registran para control de patrimonio. Su stock no se descuenta automáticamente con las ventas.

### **Paso 3: Las Entradas - Adquisiciones (`Inventario > Adquisiciones`)**

Aquí se registra toda la mercancía que entra al negocio. Es crucial que las cantidades se ingresen siempre en la **unidad base** definida para cada ítem de inventario.

**Ejemplo de Negocio (Leche):** *Has comprado un paquete de 6 tarros de leche, donde cada tarro contiene 1 Litro. En tu sistema, el ítem "Leche Fresca" está configurado con la unidad base "**Mililitro(s)**".*

1.  **Crear la Adquisición:**
    *   Ve a `Inventario > Adquisiciones` y haz clic en `Registrar Adquisición`.
    *   **Proveedor:** Selecciona el proveedor correspondiente.
    *   **Fecha:** La fecha de hoy.
    *   **Referencia:** El número de factura o guía.
    *   Guarda el encabezado.
2.  **Añadir las Líneas de Detalle:**
    *   En la tabla, busca la adquisición creada y expande sus detalles.
    *   Haz clic en `Añadir Ítem a la Adquisición`.
    *   **Ítem de Inventario:** Selecciona "Leche Fresca".
    *   **Cantidad:** Debes convertir la cantidad comprada a la unidad base (mililitros): 6 tarros * 1 Litro/tarro * 1000 ml/Litro = **6000 mililitros**. Ingresa `6000`.
    *   **Precio Unitario:** El costo de cada mililitro de leche (costo total de la compra / 6000).
    *   Guarda la línea.
3.  **Resultado:** El stock de "Leche Fresca" ha aumentado en 6000 mililitros.

**Ejemplo de Negocio (Café):** *Compraste un paquete de 1 Kilogramo de café en grano. El ítem "Café en Grano" está configurado con la unidad base "**Gramo(s)**".*

1.  **Añadir la Línea de Detalle:** (Asumiendo que ya creaste la adquisición)
    *   Haz clic en `Añadir Ítem a la Adquisición`.
    *   **Ítem de Inventario:** Selecciona "Café en Grano".
    *   **Cantidad:** Convierte el kilogramo a gramos: 1 Kilogramo * 1000 gramos/Kilogramo = **1000 gramos**. Ingresa `1000`.
    *   **Precio Unitario:** El costo por gramo de café.
    *   Guarda la línea.
2.  **Resultado:** El stock de "Café en Grano" ha aumentado en 1000 gramos.

### **Paso 4: Las Salidas - Ventas y Bajas**

El stock disminuye de tres maneras:

1.  **Por Venta de Servicios:** Al vender un servicio, el sistema descuenta los **Insumos Consumibles** definidos en la configuración de ese servicio.
2.  **Por Venta de Productos del Menú:** Al vender un producto del POS, el sistema descuenta el **Ítem de Inventario** asociado.
3.  **Por Bajas Manuales (`Inventario > Bajas`):** Para registrar productos rotos, caducados o robados. Vas a `Inventario > Bajas`, seleccionas el ítem, la cantidad y el motivo. El stock se reduce y queda registrado.

### **Paso 5: El Historial - Movimientos de Inventario (`Inventario > Movimientos`)**

Esta sección es tu libro contable de stock. Es una vista de **solo lectura** que unifica todos los pasos anteriores. Aquí puedes auditar cada entrada (por Adquisición), salida (por Venta o Baja) y ajuste, dándote una trazabilidad completa.

#### **Ajuste de Inventario**

Si tu stock físico no coincide con el del sistema, debes hacer un ajuste:
1.  Cuenta físicamente el producto.
2.  Ve a `Inventario > Movimientos` y haz clic en **`Registrar Movimiento`**.
3.  Selecciona el ítem y el tipo de movimiento **`ADJUSTMENT`**.
4.  En **Cantidad**, ingresa la **diferencia**:
    *   Si tienes **más** producto del que dice el sistema (físico: 12, sistema: 10), haz un ajuste de `+2`.
    *   Si tienes **menos** producto (físico: 7, sistema: 10), haz un ajuste de `-3`.
5.  Añade una nota explicando el motivo (ej. "Conteo físico de fin de mes").

### **Paso 6: Los Productos del Menú (`Inventario > Productos del Menú`)**

Esta es la lista de artículos que ofreces en tu Punto de Venta (POS).

*   **`Ítems de Inventario` vs. `Productos del Menú`**:
    *   **Ítem de Inventario:** Es lo físico, lo que está en tu almacén (ej. "Gramos de café en grano").
    *   **Producto del Menú:** Es lo que vendes al cliente (ej. "Taza de Café Americano"). Al venderlo, se descuentan X gramos de café del inventario.

Al crear un `Producto del Menú`, lo vinculas a uno o más `Ítems de Inventario`.

---

## 7. Módulo de Personal y Clientes

### 7.1. Gestión de Personas (`Configuración > Personas`)

Este es el directorio central de **todos los individuos** relacionados con tu negocio.

*   **Persona:** Es la entidad base con datos como nombre, DNI, email, teléfono. **Toda entidad humana** (empleado, cliente, contacto de proveedor) debe ser primero una `Persona`.
*   **Cliente:** Es una `Persona` que compra o recibe servicios. Se le pueden asignar notas o puntos de lealtad.
*   **Usuario:** Es una `Persona` con acceso al sistema (puede iniciar sesión). Se le asigna un `Rol` que define sus permisos.
*   **Barbero:** Es un `Usuario` con el rol específico de barbero, habilitado para ser asignado a citas y generar comisiones.

### 7.2. Gestión de Barberos (`Personal > Barberos`)

Aquí administras a tu personal de barbería.
1.  Navega a **`Personal > Barberos`**.
2.  Para añadir un nuevo barbero, este ya debe existir como `Persona` y `Usuario`.
3.  Aquí puedes definir su **Sueldo Base**, **Tasa de Comisión** y marcarlo como **Activo** o **Inactivo**.

#### **Cálculo de Pagos a Barberos (`Personal > Pagos`)**

El sistema calcula el pago a los barberos basado en una regla de negocio específica, ya explicada anteriormente. Aquí se detalla el proceso en el sistema.

**Ejemplo Práctico:** *Carlos debe recibir su pago de comisiones y ya solicitó dos adelantos durante el mes.*

1.  **Navegar al Módulo:** Vaya a **`Personal > Pagos`**.
2.  **Seleccionar Barbero y Periodo:**
    *   En el campo **`Barbero`**, seleccione "Carlos García".
    *   En **`Rango de Fechas`**, seleccione el mes correspondiente (ej. "Noviembre 2025").
3.  **Visualizar Resultados:** El sistema cargará automáticamente:
    *   Todas las ventas de servicios asociadas a Carlos en ese periodo.
    *   Los adelantos que Carlos ha solicitado y que aún no han sido pagados (ej. S/ 100 y S/ 150).
    *   El **`Total Ventas Servicios`** de Carlos (ej. S/ 3100).
    *   El **`Sueldo Base`** configurado para Carlos (ej. S/ 1200).
    *   La **`Tasa de Comisión`** (ej. 40%).
    *   El sistema aplicará la regla de negocio:
        *   Doble de Sueldo Base = `1200 * 2 = S/ 2400`.
        *   Como `3100 >= 2400`, Carlos comisiona.
        *   Comisión = `3100 * 0.40 = S/ 1240`.
        *   Ingreso Calculado = `S/ 1240`.
    *   El sistema mostrará el **`Total Adelantos`** (S/ 250).
    *   El **`Monto Final a Pagar`** = `1240 - 250 = S/ 990`.
4.  **Registrar Pago:**
    *   Revise todos los detalles. Si es correcto, haga clic en **`Finalizar y Registrar Pago`**.
    *   El sistema le pedirá confirmar y registrará la transacción de pago, marcando los adelantos como "pagados" y generando un registro histórico.

**Importante:** Las comisiones se calculan **únicamente sobre los servicios**. La venta de productos no contribuye a la comisión del barbero.

### 7.3. Gestión de Clientes (`Clientes`)

Este módulo permite administrar la base de datos de clientes y ver información detallada de cada uno.

1.  **Lista de Clientes:** Navega a **`Clientes`** para ver la lista completa. Puedes buscar por nombre, teléfono o email.
2.  **Perfil del Cliente (Detalle):** Al hacer clic en un cliente, accederás a su perfil completo, que incluye:
    *   **Información Personal:** Datos de contacto y fecha de nacimiento.
    *   **Puntos de Fidelización:** Una barra de progreso visualizando sus puntos acumulados.
    *   **Pestañas de Actividad:**
        *   **Reservas:** Historial de citas pasadas y futuras.
        *   **Historial de Servicios:** Lista detallada de servicios recibidos.
        *   **Compras de Productos:** Historial de productos adquiridos.
        *   **Estadísticas:** Métricas clave como "Total Gastado", "Ticket Promedio", "Servicio Más Solicitado" y "Barbero Más Frecuente".
3.  **Acciones Rápidas:** Desde el perfil, puedes iniciar rápidamente una **Nueva Reserva** o **Nueva Venta** para ese cliente específico.

---

## 8. Módulo de Configuración

Aquí se gestionan los parámetros fundamentales del sistema.

### 8.1. Servicios (`Configuración > Servicios`)

Define los servicios que ofreces. Al crear o editar un servicio:
*   **Nombre, Descripción, Precio, Duración:** Información básica.
*   **Insumos del Servicio:** ¡Sección clave! Aquí especificas qué **`Ítems de Inventario`** y en qué **`cantidad`** se consumen al realizar este servicio (ej. "Corte Premium" consume 10ml de champú y 1 navaja). Estos se descontarán automáticamente del stock cuando el servicio se venda.

`[IMAGEN: Formulario de creación de servicio, resaltando la sección 'Insumos del Servicio']`

### 8.2. Guía Detallada de Combos (`Configuración > Combos`)

El módulo de **Combos** (o Bundles) es una herramienta de marketing que te permite agrupar varios servicios y/o productos en un solo paquete, facilitando su venta.

#### **Concepto Clave de un Combo**

En este sistema, un combo es un **paquete con ítems fijos**. Piense en él como una "canasta" pre-armada que se vende como una sola unidad.

*   **Ejemplo:** Creas un "Paquete de Afeitado Premium" que siempre incluirá:
    *   1 x Servicio de "Afeitado Clásico con Toallas Calientes"
    *   1 x Producto "Loción After-Shave Marca X"

No es posible crear opciones donde el cliente elija entre un producto u otro dentro del mismo combo.

#### **Guía Paso a Paso para Crear un Combo**

**Ejemplo de Negocio:** *Queremos crear un nuevo paquete llamado "Experiencia de Relajación Total" para venderlo como un solo producto en el POS.*

1.  Navegue a **`Configuración > Combos`**.
2.  Haga clic en el botón **`Añadir Combo`**. Se abrirá el formulario de creación.

![Formulario de Creación de Combo](C:/Users/angel/.gemini/antigravity/brain/a82418e8-31db-410b-93c6-1ec2d0323797/bundle_form_mockup_1764224100973.png)

3.  **Complete los Detalles Principales:**
    *   **Nombre del Combo:** Escriba "Experiencia de Relajación Total".
    *   **Descripción:** Añada un texto atractivo, como "Incluye un corte de cabello profesional y un tratamiento facial revitalizante".
    *   **Activo:** Asegúrese de que esta casilla esté marcada para que el combo esté disponible para la venta.

4.  **Añada los Ítems al Combo:**
    *   Haga clic en el botón **`Añadir Servicio`** y seleccione "Corte de Cabello Profesional" de la lista.
    *   Vuelva a hacer clic en **`Añadir Servicio`** y seleccione "Tratamiento Facial".
    *   Si quisiera añadir un producto, usaría el botón **`Añadir Producto`**.

5.  **Ajuste las Cantidades (si es necesario):**
    *   Para cada ítem en la lista, puede definir la **`Cantidad`**. En este caso, para ambos servicios, la cantidad será `1`.

`[IMAGEN: Lista de ítems dentro de la creación del combo, mostrando los dos servicios añadidos]`

6.  **Verifique el Precio (Importante):**
    *   Verá un campo **`Precio de Venta`** que **no se puede editar**.
    *   El sistema calcula este precio automáticamente, sumando los precios de todos los ítems que ha incluido. Si el corte cuesta S/ 30 y el tratamiento S/ 50, el precio del combo será **S/ 80**.
    *   **Nota sobre descuentos:** Para ofrecer un "precio de paquete" con descuento, actualmente no es posible asignar un precio personalizado directamente al combo. El descuento debería aplicarse manualmente al momento de realizar la venta total en el POS.

7.  Haga clic en **`Guardar Combo`**.

**Resultado Final:**
Su combo "Experiencia de Relajación Total" está ahora disponible como un único artículo para ser añadido a cualquier venta desde el **`POS`**. Al venderlo, el sistema descontará automáticamente del inventario todos los insumos de los servicios y/o los productos incluidos en el paquete.

### 8.3. Otros Ajustes

*   **`Estaciones`**: Define las sillas o estaciones de trabajo físicas.
*   **`Proveedores`**: Administra la información de tus proveedores de productos.
*   **`Usuarios`**: Gestiona las cuentas de acceso al sistema y sus roles (permisos).

---

## 9. Módulo de Reportes

Ofrece análisis detallados sobre el rendimiento del negocio.

*   **`Ventas Detallado`**: El historial completo de ventas, con filtros avanzados. Es la herramienta principal para buscar y anular transacciones.
*   **`Ventas por Tipo`**: Compara ingresos de servicios vs. productos.
*   **`Inventario`**: Muestra el valor del stock actual, alertas de stock bajo y un resumen de movimientos.
*   **`Pagos a Barberos`**: Un historial de todos los pagos de comisiones realizados.
*   **`Uso de Estaciones`**: Analiza qué estaciones de trabajo son las más utilizadas.
*   **`Frecuencia de Clientes`**: Identifica a tus clientes más leales.
*   **`Horas Pico`**: Muestra qué días y horas tienen más demanda para optimizar horarios.

`[IMAGEN: Página principal de Reportes, mostrando las diferentes opciones de reportes disponibles]`

---

## 10. Preguntas Frecuentes (FAQ) y Casos de Uso

**P1: ¿Cómo manejo un producto que se vende y también se usa en servicios? (Ej: Un gel)**
*R:* Registra un único `Ítem de Inventario` (ej. "Gel Fijador Marca X" en mililitros) y conéctalo a dos sitios:
1.  **Para uso:** En `Configuración > Servicios`, añádelo como insumo al servicio "Peinado" con la cantidad usada (ej. 10 ml).
2.  **Para venta:** En `Inventario > Productos del Menú`, crea "Botella de Gel Marca X", vincúlalo al mismo ítem de inventario y asegúrate de que la venta descuente la cantidad correcta (ej. 500 ml si es una botella de ese tamaño).

**P2: Compro en cajas, almaceno en potes y uso en mililitros. ¿Cómo lo registro?**
*R:* El sistema no hace conversiones automáticas. **Siempre registra el ítem en la unidad más pequeña que consumes**.
*   **Ejemplo:** Compras 1 caja (10 potes de 100ml c/u). Tu unidad base es **mililitro**.
    1.  **Ítem de Inventario:** Crea "Cera Pro" con unidad "Mililitro".
    2.  **Adquisición:** Registra una entrada de `10 * 100 = 1000` ml.
    3.  **Servicio:** Configura el servicio para que consuma `5` ml.
    *Así, tu control de stock será exacto.*

**P3: ¿Qué pasa si cambio el precio de un servicio? ¿Afecta a las citas ya agendadas?**
*R:* No. El sistema guarda el precio del servicio **en el momento de crear la reserva**. Las citas ya agendadas mantendrán el precio antiguo. Solo las **nuevas reservas** usarán el precio actualizado.

**P4: ¿Por qué no puedo eliminar un Servicio, Proveedor o Categoría?**
*R:* Para proteger la integridad de tus datos históricos. Si un servicio ya se vendió, no puede ser eliminado. La **solución correcta es desactivarlo**. Ve al ítem que quieres ocultar (servicio, producto, barbero) y desmarca la casilla **`Activo`**. Esto lo ocultará de futuras transacciones, pero mantendrá tu historial intacto.

**P5: ¿Para qué sirve el campo "Puntos de Lealtad"?**
*R:* Es una característica planificada para un futuro programa de fidelización. Actualmente, el campo existe pero la lógica para acumular o canjear puntos **no está implementada**.

**P6: ¿Puedo registrar gastos como el alquiler o los sueldos en el sistema?**
*R:* No. El sistema está especializado en la gestión operativa y de inventario (Costo de Bienes Vendidos). Para gastos administrativos y operativos (alquiler, servicios, etc.), deberás usar un software de contabilidad externo.

**P7: ¿Cómo funcionan los combos y cómo afectan mi inventario?**
*R:* Los combos son paquetes fijos de servicios y/o productos que se venden como una sola unidad.
*   **Creación:** Se crean en `Configuración > Combos` añadiendo los ítems deseados (ej. 1 servicio "Corte" + 1 producto "Cera").
*   **Precio:** El precio del combo se calcula automáticamente como la suma de los precios de todos los ítems que contiene. No se puede asignar un precio personalizado al paquete.
*   **Gestión de Inventario:** Al vender un combo, el sistema descuenta automáticamente el stock de **todos** los componentes del paquete. Si el combo incluye un servicio, se descontarán los insumos de ese servicio. Si incluye un producto, se descontará una unidad de ese producto.

**P8: ¿Cómo se descuenta el inventario de insumos (ej. leche o café) cuando se usa en un servicio o se vende como parte de un producto del menú?**
*R:* El sistema descuenta el inventario de los insumos basándose en la **unidad base** que definiste para cada ítem de inventario.

*   **Ejemplo (Leche en un servicio):** Si tu ítem "Leche Fresca" tiene como unidad base "Mililitro(s)", y configuraste un servicio "Café con Leche" para que consuma **100** (mililitros) de leche:
    1.  Cuando vendes el servicio "Café con Leche", el sistema automáticamente descontará **100 mililitros** del stock total de "Leche Fresca".

*   **Ejemplo (Café en un producto del menú):** Si tu ítem "Café en Grano" tiene como unidad base "Gramo(s)", y creaste un "Producto del Menú" llamado "Taza de Café Americano" que vinculaste al ítem "Café en Grano" con una cantidad de **18** (gramos) por taza:
    1.  Cuando vendes una "Taza de Café Americano", el sistema descontará **18 gramos** del stock total de "Café en Grano".

*   **Clave:** La consistencia en el uso de la unidad base a lo largo de la configuración (tipo de unidad del ítem, cantidad en adquisiciones, cantidad en consumos de servicios o productos del menú) es lo que garantiza un control de inventario preciso.

---
**Fin del Manual de Usuario**