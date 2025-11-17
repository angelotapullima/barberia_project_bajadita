## Manual de Inicio Rápido: Configuración y Operación del Sistema de Gestión de Barbería

Este manual te guiará paso a paso para poner en marcha y operar tu sistema de gestión de barbería, desde la configuración inicial hasta las tareas diarias.

### **Parte 1: Configuración Inicial del Sistema (Una Sola Vez)**

Esta sección cubre los pasos que realizarás una única vez para preparar el sistema.

**1. Acceso al Sistema:**
*   Abre tu navegador web e ingresa la URL proporcionada.
*   Inicia sesión con tus credenciales de **Administrador**.

**2. Configuración Base del Inventario:**
*   **Tipos de Unidad:** Define las unidades de medida (ej. "Unidad(es)", "Mililitro(s)").
    *   *Navegación:* `Inventario > Configuración > Tipos de Unidad`.
    *   *Consejo Clave:* Usa la unidad más pequeña de consumo para mayor precisión y control (ej. "Mililitro" si usas 5ml de un producto de 100ml). Esto es fundamental para ítems que se venden y también se usan en servicios.
*   **Categorías de Ítems:** Organiza tus productos (ej. "Cuidado del Cabello", "Herramientas").
    *   *Navegación:* `Inventario > Configuración > Categorías de Ítems`.
*   **Ubicaciones:** Define dónde almacenas tus productos (ej. "Almacén Principal", "Recepción").
    *   *Navegación:* `Inventario > Configuración > Ubicaciones`.

**3. Registro de Personas:**
*   Crea un registro para cada individuo relacionado con tu negocio (empleados, clientes).
    *   *Navegación:* `Configuración > Personas`.
    *   *Datos:* Nombre, DNI, Email, Teléfono.

**4. Creación de Barberos:**
*   Vincula las `Personas` creadas con el rol de `Barbero`.
    *   *Navegación:* `Personal > Barberos`.
    *   *Acción:* Selecciona la `Persona`, establece su **Porcentaje de Comisión** y **Sueldo Base**. Asegúrate de que esté `Activo`.

**5. Creación de Ítems de Inventario:**
*   Registra **todo lo que tienes físicamente** en tu barbería (productos, insumos, herramientas).
    *   *Navegación:* `Inventario > Ítems`.
    *   *Tipos Clave:*
        *   **`RETAIL_PRODUCT`:** Productos que vendes directamente.
        *   **`CONSUMABLE_SUPPLY`:** Insumos que se gastan al realizar un servicio.
        *   **`OPERATIONAL_ASSET`:** Herramientas o equipos que no se consumen.
    *   *Acción:* Para cada ítem, selecciona su `Categoría` y `Tipo de Unidad`.

**6. Definición de Servicios:**
*   Crea los servicios que ofrece tu barbería y especifica los insumos que consumen.
    *   *Navegación:* `Configuración > Servicios`.
    *   *Acción:* Completa **Nombre**, **Descripción**, **Precio** y **Duración**. En "Insumos del Servicio", añade los `Ítems de Inventario` (`CONSUMABLE_SUPPLY`) y la **Cantidad** que se usa por servicio.

**7. Creación de Productos del Menú:**
*   Define los artículos que aparecerán en tu punto de venta para ser cobrados.
    *   *Navegación:* `Inventario > Productos del Menú`.
    *   *Acción:* Crea un `Producto del Menú` y vincúlalo a un `Ítem de Inventario` (si es un producto de venta directa) o define su "receta" (si es compuesto).
    *   *Diferencia Clave:* `Ítem de Inventario` es lo físico; `Producto del Menú` es lo que se vende.

    *   **Nota Importante: Manejo de Ítems para Venta y Consumo (Ej. Cera):**
        Para productos como la cera que se venden directamente al cliente y también son usados por los barberos en servicios, la clave es:
        1.  **Un Único Ítem de Inventario:** Crea un solo `Ítem de Inventario` (Paso 5) para el producto (ej. "Cera Moldeadora Profesional") usando la unidad más pequeña (ej. "Mililitro").
        2.  **Vincular a Servicios:** En la definición del `Servicio` (Paso 6), añade este `Ítem de Inventario` como insumo, especificando la cantidad que se consume por cada servicio.
        3.  **Vincular a Producto del Menú:** Crea un `Producto del Menú` (Paso 7) para la venta directa del producto (ej. "Pote de Cera 100ml") y vincúlalo al mismo `Ítem de Inventario`. Al venderlo, asegúrate de que la cantidad descontada del inventario sea la correcta en la unidad base (ej. 100 mililitros por un pote de 100ml).
        Esto asegura un control preciso del stock para ambos usos.

**8. Carga Inicial de Inventario (Adquisiciones):**
*   Registra tu stock existente para que el sistema refleje tus cantidades reales.
    *   *Navegación:* `Inventario > Adquisiciones`.
    *   *Acción:*
        1.  Haz clic en **Registrar Adquisición**.
        2.  Completa los datos (Proveedor, Fecha, Referencia). Puedes usar un proveedor genérico como "Stock Inicial".
        3.  **Guarda** la adquisición.
        4.  En la tabla, haz clic en **Ver Detalles** de la adquisición recién creada.
        5.  Haz clic en **Añadir Ítem a la Adquisición**.
        6.  Selecciona el `Ítem de Inventario` y la **Cantidad** total que tienes de ese ítem (en su unidad base).
        7.  Ingresa el **Precio Unitario** (costo por unidad base).
        8.  **Guarda**. Repite para cada ítem de tu stock inicial.

**9. Creación de Usuarios:**
*   Otorga acceso al sistema a tu personal.
    *   *Navegación:* `Configuración > Usuarios`.
    *   *Acción:* Selecciona la `Persona`, define su **Email** y **Contraseña**, y asigna el **Rol** (Administrador, Barbero, Recepción).

**10. Creación de Combos (Paquetes de Servicios/Productos):**
*   Agrupa varios servicios y/o productos en un solo paquete con un precio especial. Esto es ideal para ofertas y promociones.
    *   *Navegación:* `Configuración > Combos`.
    *   *Acción:*
        1.  Haz clic en **Añadir Combo**.
        2.  Asigna un **Nombre** (ej. "Corte Fade + Bebida") y una **Descripción**.
        3.  Asegúrate de que esté `Activo`.
        4.  **Añade los ítems fijos:** Usa **Añadir Servicio** o **Añadir Producto** para ítems que siempre se incluyen.
            *   *Ejemplo:* Añade el servicio **"Corte Fade"** (precio S/ 25). Deja su campo `Grupo` vacío.
        5.  **Añade los ítems con opción a elegir (Grupos de Elección):** Para ítems donde el cliente elige solo uno de varias opciones:
            *   Añade cada opción como un `Producto del Menú` al combo.
            *   En el campo **`Grupo`**, escribe **el mismo nombre** para todas las opciones de ese grupo (ej. "Bebida").
            *   *Ejemplo para las bebidas (todas con precio S/ 10):*
                *   Añade el `Producto del Menú` "Jugo" (Grupo: "Bebida").
                *   Añade el `Producto del Menú` "Café" (Grupo: "Bebida").
                *   Añade el `Producto del Menú` "Agua" (Grupo: "Bebida").
        6.  El sistema calculará automáticamente el **Precio de Venta** del combo.
            *   *Cálculo del Ejemplo:* S/ 25 (Corte Fade) + S/ 10 (la bebida más cara del grupo "Bebida") = **S/ 35**.
        7.  **Guarda el Combo.**
    *   *Funcionamiento en Venta:* Al vender el combo, el sistema te pedirá seleccionar la opción elegida por el cliente del "Grupo de Elección" y descontará el inventario solo de ese ítem.

### **Parte 2: Operación Diaria del Sistema (Uso Cotidiano)**

Una vez configurado, así es como usarás el sistema día a día.

**1. Gestión de Reservas:**
*   **Calendario:** Visualiza y gestiona todas las citas.
    *   *Navegación:* `Reservas > Calendario`.
*   **Crear Reserva:** Haz clic en un espacio vacío del calendario o en **Añadir Reserva**.
    *   *Acción:* Selecciona Cliente, Barbero, Servicios, Fecha y Hora.
*   **Gestionar Reserva:** Haz clic en una cita para **Editar**, **Cancelar** o **Completar** (para iniciar la venta).

**2. Gestión de Ventas (Punto de Venta - POS):**
*   **Venta desde Reserva:** La forma más común.
    *   *Acción:* En el calendario, selecciona una cita y haz clic en **Completar**.
    *   *Proceso:* Verifica servicios, añade productos adicionales, aplica descuentos, selecciona método de pago y **Registra Venta**. El inventario se descontará automáticamente.
*   **Venta Directa (sin reserva):** Para clientes sin cita o solo compra de productos.
    *   *Navegación:* `Agenda y Citas > Calendario`, luego busca el botón **"Nuevo"** y selecciona **Nueva Venta**.
    *   *Proceso:* Añade servicios/productos, selecciona cliente (opcional) y completa el pago.

**3. Gestión Continua del Inventario:**
*   **Nuevas Adquisiciones:** Cada vez que recibas mercancía, regístrala para actualizar el stock.
    *   *Navegación:* `Inventario > Adquisiciones`.
*   **Bajas Manuales:** Registra productos dañados, caducados o usados internamente.
    *   *Navegación:* `Inventario > Bajas`.
*   **Ajustes de Inventario:** Corrige discrepancias entre el stock físico y el del sistema.
    *   *Navegación:* `Inventario > Movimientos de Inventario`, luego **Registrar Movimiento** con tipo `ADJUSTMENT`.

**4. Consulta de Reportes:**
*   Analiza el rendimiento de tu negocio (ventas, inventario, barberos, etc.).
    *   *Navegación:* `Reportes`.

**5. Pagos a Barberos:**
*   Calcula y registra las comisiones de tu personal.
    *   *Navegación:* `Personal > Pagos`.
    *   *Acción:* Selecciona Barbero y Rango de Fechas, verifica el cálculo y **Finaliza y Registra Pago**.

### **Consejos Clave para el Éxito:**

*   **Unidades:** Siempre registra las cantidades en la unidad más pequeña de consumo.
*   **Activo/Inactivo:** En lugar de eliminar registros (servicios, barberos, productos), desactívalos (`Activo` = no marcado) para preservar el historial.
*   **Inventario Preciso:** La clave de un buen control es registrar todas las entradas (adquisiciones) y salidas (ventas, bajas, ajustes).

---