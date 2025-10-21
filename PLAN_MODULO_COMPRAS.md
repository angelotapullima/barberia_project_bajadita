# Plan de Implementación: Módulo de Compras

## 1. Análisis y Objetivo

El sistema actual carece de una funcionalidad para registrar la compra de productos, insumos y otros gastos operativos. El objetivo de este plan es diseñar e implementar un **Módulo de Compras** que permita:

- Registrar todas las compras a proveedores.
- Clasificar los artículos comprados (productos para venta, insumos para servicios, gastos/activos).
- Actualizar automáticamente el stock de productos e insumos.
- Llevar un registro de los gastos totales para futuros reportes financieros.

## 2. Propuesta de Diseño

La implementación se dividirá en tres capas principales: Base de Datos, Backend (API) y Frontend (UI).

### 2.1. Cambios en la Base de Datos

Se crearán nuevas tablas y se podrían modificar algunas existentes para soportar la nueva funcionalidad.

**a. Nueva Tabla: `proveedores`**

Para almacenar la información de los proveedores.

```sql
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    ruc VARCHAR(20) NULL,
    documento_identidad VARCHAR(20) NULL,
    telefono VARCHAR(50) NULL,
    email VARCHAR(100) NULL,
    direccion TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

**b. Nueva Tabla: `compras`**

Representa la cabecera de una transacción de compra.

```sql
CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT NOT NULL,
    fecha_compra DATE NOT NULL,
    total_compra DECIMAL(10, 2) NOT NULL,
    numero_comprobante VARCHAR(100) NULL,
    estado VARCHAR(50) DEFAULT 'Recibida', -- Ej: Recibida, Pendiente, Cancelada
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);
```

**c. Nueva Tabla: `detalles_compra`**

Almacena cada línea de artículo dentro de una compra.

```sql
CREATE TABLE detalles_compra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT NOT NULL,
    descripcion_item VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario_compra DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    -- Columna clave para la lógica de negocio
    tipo_item VARCHAR(50) NOT NULL, -- 'producto_venta', 'insumo_servicio', 'gasto_activo'
    -- ID opcional para vincular con el inventario existente
    referencia_id INT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (compra_id) REFERENCES compras(id)
);
```

### 2.2. Lógica del Backend (API)

Se desarrollarán nuevos servicios y controladores para manejar la lógica de negocio.

**a. Nuevos Endpoints**

- `GET /api/proveedores`: Listar todos los proveedores.
- `POST /api/proveedores`: Crear un nuevo proveedor.
- `PUT /api/proveedores/:id`: Actualizar un proveedor.
- `DELETE /api/proveedores/:id`: Eliminar un proveedor.
- `GET /api/compras`: Listar todas las compras con sus detalles.
- `POST /api/compras`: Registrar una nueva compra.
- `GET /api/compras/:id`: Obtener el detalle de una compra específica.

**b. Lógica de Negocio Clave (`POST /api/compras`)**

El servicio que maneje la creación de una compra deberá:
1.  Validar los datos de entrada.
2.  Crear el registro en la tabla `compras`.
3.  Iterar sobre cada ítem en `detalles_compra` del request.
4.  Por cada ítem, realizar una acción según el `tipo_item`:
    - **Si es `producto_venta`**: Usar `referencia_id` para encontrar el producto en la tabla `products` y sumar la `cantidad` a su stock. Opcionalmente, actualizar un campo `costo_adquisicion`.
    - **Si es `insumo_servicio`**: Usar `referencia_id` para encontrar el insumo en la tabla `inventory_items` y sumar la `cantidad` a su stock.
    - **Si es `gasto_activo`**: No se realiza ninguna acción sobre el inventario. El registro sirve para la contabilidad de gastos.
5.  Guardar cada ítem en la tabla `detalles_compra`.

### 2.3. Interfaz de Usuario (Frontend)

Se crearán nuevas vistas y componentes en Vue.js.

**a. Nueva Sección en el Menú:**
   - Añadir "Gestión de Compras" en el `Sidebar.vue`.

**b. Módulo de Proveedores:**
   - Una nueva vista con una tabla para el CRUD de proveedores.

**c. Módulo de Compras:**
   - **Vista Principal:** Una tabla listando todas las compras realizadas. Cada fila mostrará datos clave (ID, Proveedor, Fecha, Total) y tendrá un botón para ver el detalle.
   - **Formulario "Registrar Nueva Compra":**
     - Un modal o una nueva página.
     - Campos para seleccionar `Proveedor`, `Fecha` y `Nro. Comprobante`.
     - Una tabla dinámica para añadir los `detalles_compra`:
       - Columnas: `Descripción`, `Cantidad`, `Precio Unitario`, `Subtotal`.
       - **Columna "Clasificación"**: Un dropdown para seleccionar el `tipo_item` (`Producto para Venta`, `Insumo para Servicio`, `Gasto/Activo`).
       - **Columna "Asociar a"**: Un campo de autocompletado que permitirá buscar en `products` o `inventory_items` si el tipo seleccionado lo requiere.
     - El formulario calculará el total automáticamente.

## 3. Resumen y Beneficios

Este módulo centralizará la gestión de adquisiciones y gastos, proporcionando:
- **Trazabilidad:** Control total sobre las compras y los gastos.
- **Automatización:** Actualización automática del stock al registrar una compra.
- **Inteligencia de Negocio:** Datos para calcular la rentabilidad y analizar los gastos operativos.

## 4. Plan de Implementación por Fases

Para un desarrollo ordenado, el proyecto se dividirá en dos fases.

### Fase 1: Módulo de Compras (Cimientos)
Corresponde a todo lo descrito en la sección 2. El objetivo es controlar las adquisiciones, registrar gastos y automatizar la carga de stock de productos e insumos.

### Fase 2: Consumo de Insumos en Servicios (Inteligencia de Negocio)
Una vez completada la Fase 1, se añadirá la lógica para calcular la rentabilidad real de los servicios.

1.  **Base de Datos:** Crear una tabla de unión `servicio_insumos` (`servicio_id`, `insumo_id`, `cantidad_consumida`).
2.  **Backend:** Al registrar la venta de un servicio, descontar automáticamente el stock de los insumos asociados.
3.  **Frontend:** En el formulario de `Servicio`, añadir una UI para seleccionar los insumos que consume.

## 5. Próximos Pasos (Fase 1)

Los siguientes pasos se centran en la implementación de la **Fase 1: Módulo de Compras**.

1.  **Validación del Plan:** Revisar y aprobar este documento.
2.  **Base de Datos:** Ejecutar los scripts SQL para crear las tablas `proveedores`, `compras` y `detalles_compra`.
3.  **Desarrollo Backend:** Implementar los nuevos endpoints y la lógica de negocio para el CRUD de proveedores y el registro de compras.
4.  **Desarrollo Frontend:** Construir las vistas y componentes para la gestión de proveedores y el formulario de registro de compras.
5.  **Pruebas:** Realizar pruebas unitarias y de integración para la Fase 1.
