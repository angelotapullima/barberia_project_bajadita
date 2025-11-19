# Guía de Configuración de Inventario con Conversión de Unidades

Esta guía detalla cómo configurar tu inventario para manejar ítems que se compran en una unidad (ej. paquetes de 1kg) pero se consumen en otra (ej. gramos), utilizando la nueva estructura de conversión de unidades.

---

## Paso 1: Configuración de Unidades y Categorías

Primero, asegúrate de tener las unidades de medida y las categorías necesarias.

### 1. Crear Tipos de Unidad (si no existen):
*   Navega a: `Inventario > Configuración > Tipos de Unidad`.
*   Crea los siguientes tipos de unidad (si no existen):
    *   `Unidad(es)`
    *   `Mililitro(s)`
    *   `Gramo(s)`
    *   `Litro(s)`
    *   `Kilogramo(s)`
    *   `Paquete(s) de 1kg`
    *   `Pote(s)`
    *   `Caja(s)`
*   Guarda cada uno.

### 2. Crear Categorías de Ítems (si no existen):
*   Navega a: `Inventario > Configuración > Categorías de Ítems`.
*   Crea las siguientes categorías:
    *   `Bebidas`
    *   `Materia Prima Café`
    *   `Productos de Venta Barbero`
    *   `Insumos de Servicio Barbero`
*   Guarda cada uno.

---

## Paso 2: Creación de Ítems de Inventario (para Bebidas, Materias Primas del Café y Productos de Barbería)

Ahora, registra todos tus productos como ítems físicos en tu inventario, definiendo sus tipos, unidades y factores de conversión.

### 1. Ítems de Inventario para Bebidas Directas:
*   **Jugo (Botella 300ml):**
    *   Nombre: `Jugo (Botella 300ml)`
    *   Tipo de Ítem: `RETAIL_PRODUCT`
    *   Categoría de Ítem: `Bebidas`
    *   Unidad de Consumo: `Unidad(es)`
    *   Guarda.
*   **Agua (Botella 500ml):**
    *   Nombre: `Agua (Botella 500ml)`
    *   Tipo de Ítem: `RETAIL_PRODUCT`
    *   Categoría de Ítem: `Bebidas`
    *   Unidad de Consumo: `Unidad(es)`
    *   Guarda.

### 2. Ítems de Inventario para Materias Primas del Café (Ingredientes):
*   **Grano de Café:**
    *   Nombre: `Grano de Café`
    *   Tipo de Ítem: `RAW_MATERIAL`
    *   Categoría de Ítem: `Materia Prima Café`
    *   Unidad de Compra/Almacenamiento: `Paquete(s) de 1kg` (o la unidad en que lo compras)
    *   Unidad de Consumo: `Gramo(s)`
    *   Factor de Conversión: `1000` (porque 1 Paquete de 1kg = 1000 Gramos)
    *   Guarda.
*   **Leche:**
    *   Nombre: `Leche`
    *   Tipo de Ítem: `RAW_MATERIAL`
    *   Categoría de Ítem: `Materia Prima Café`
    *   Unidad de Compra/Almacenamiento: `Litro(s)` (o la unidad en que la compras)
    *   Unidad de Consumo: `Mililitro(s)`
    *   Factor de Conversión: `1000` (porque 1 Litro = 1000 Mililitros)
    *   Guarda.
*   **Azúcar:**
    *   Nombre: `Azúcar`
    *   Tipo de Ítem: `RAW_MATERIAL`
    *   Categoría de Ítem: `Materia Prima Café`
    *   Unidad de Compra/Almacenamiento: `Kilogramo(s)` (o la unidad en que lo compras)
    *   Unidad de Consumo: `Gramo(s)`
    *   Factor de Conversión: `1000`
    *   Guarda.
*   **Agua Filtrada:**
    *   Nombre: `Agua Filtrada`
    *   Tipo de Ítem: `RAW_MATERIAL`
    *   Categoría de Ítem: `Materia Prima Café`
    *   Unidad de Compra/Almacenamiento: `Litro(s)`
    *   Unidad de Consumo: `Mililitro(s)`
    *   Factor de Conversión: `1000`
    *   Guarda.

### 3. Ítems de Inventario para Productos de Barbería (Venta y Consumibles):

*   **Cera Moldeadora (Pote 100g):**
    *   Nombre: `Cera Moldeadora (Pote 100g)`
    *   Tipo de Ítem: `RETAIL_PRODUCT`
    *   Categoría de Ítem: `Productos de Venta Barbero`
    *   Unidad de Consumo: `Unidad(es)`
    *   Guarda.
*   **Champú Profesional (Botella 1L):**
    *   Nombre: `Champú Profesional (Botella 1L)`
    *   Tipo de Ítem: `RETAIL_PRODUCT`
    *   Categoría de Ítem: `Productos de Venta Barbero`
    *   Unidad de Consumo: `Unidad(es)`
    *   Guarda.
*   **Acondicionador Profesional (Botella 1L):**
    *   Nombre: `Acondicionador Profesional (Botella 1L)`
    *   Tipo de Ítem: `RETAIL_PRODUCT`
    *   Categoría de Ítem: `Productos de Venta Barbero`
    *   Unidad de Consumo: `Unidad(es)`
    *   Guarda.
*   **Navaja de Afeitar (Unidad):**
    *   Nombre: `Navaja de Afeitar (Unidad)`
    *   Tipo de Ítem: `CONSUMABLE_SUPPLY`
    *   Categoría de Ítem: `Insumos de Servicio Barbero`
    *   Unidad de Consumo: `Unidad(es)`
    *   Guarda.
*   **Gel de Afeitar (Pote 500ml):**
    *   Nombre: `Gel de Afeitar (Pote 500ml)`
    *   Tipo de Ítem: `CONSUMABLE_SUPPLY`
    *   Categoría de Ítem: `Insumos de Servicio Barbero`
    *   Unidad de Compra/Almacenamiento: `Pote(s)`
    *   Unidad de Consumo: `Mililitro(s)`
    *   Factor de Conversión: `500` (porque 1 Pote = 500 Mililitros)
    *   Guarda.
*   **Loción Post-Afeitado (Botella 200ml):**
    *   Nombre: `Loción Post-Afeitado (Botella 200ml)`
    *   Tipo de Ítem: `CONSUMABLE_SUPPLY`
    *   Categoría de Ítem: `Insumos de Servicio Barbero`
    *   Unidad de Compra/Almacenamiento: `Botella(s)`
    *   Unidad de Consumo: `Mililitro(s)`
    *   Factor de Conversión: `200`
    *   Guarda.

*   **Importante:** Después de crear estos ítems, deberás cargarlos en tu inventario inicial a través de `Inventario > Adquisiciones` para que tengan stock disponible. Recuerda que al registrar una adquisición, la cantidad se ingresa en la **Unidad de Compra/Almacenamiento** del ítem.

    **Ejemplo de Adquisición de Café:**
    Si compras 6 paquetes de café, cada uno de 1kg, y tu "Grano de Café" está configurado con "Unidad de Compra/Almacenamiento: Paquete(s) de 1kg", entonces en el formulario de adquisición, en el campo "Cantidad", ingresarías `6`. El sistema internamente sabrá que esto equivale a 6000 gramos para fines de consumo.

    **Ejemplo de Adquisición de Gel de Afeitar:**
    Si compras 10 potes de Gel de Afeitar (500ml c/u), y tu "Gel de Afeitar" está configurado con "Unidad de Compra/Almacenamiento: Pote(s)", entonces en el formulario de adquisición, en el campo "Cantidad", ingresarías `10`. El sistema internamente sabrá que esto equivale a 5000 mililitros para fines de consumo.

---

## Paso 3: Creación de Productos del Menú (para Bebidas Directas, Café Compuesto y Productos de Venta de Barbería)

Estos son los ítems que aparecerán en tu punto de venta.

### 1. Productos del Menú para Bebidas Directas:
*   **Jugo:**
    *   Nombre: `Jugo`
    *   Precio: `3.00` (S/ 3)
    *   Tipo: `Directo`
    *   Ítem de Inventario Asociado: Selecciona `Jugo (Botella 300ml)`
    *   Guarda.
*   **Agua:**
    *   Nombre: `Agua`
    *   Precio: `2.00` (S/ 2)
    *   Tipo: `Directo`
    *   Ítem de Inventario Asociado: Selecciona `Agua (Botella 500ml)`
    *   Guarda.

### 2. Producto del Menú para Café (Compuesto):
*   Navega a: `Inventario > Productos del Menú`.
*   Haz clic en `Añadir Producto del Menú`.
*   Nombre: `Capuchino`
*   Descripción: `Delicioso capuchino preparado al momento.`
*   Precio: `8.00` (S/ 8)
*   Tipo: `Compuesto` (¡Esta es la clave!)
*   Receta (Añadir Ítems de Inventario):
    *   Haz clic en `Añadir Ingrediente`.
    *   Selecciona `Grano de Café`. La interfaz te indicará que la cantidad se ingresa en "gramos". Ingresa la Cantidad: (ej. `18`).
    *   Selecciona `Leche`. La interfaz te indicará que la cantidad se ingresa en "mililitros". Ingresa la Cantidad: (ej. `120`).
    *   Selecciona `Azúcar`. La interfaz te indicará que la cantidad se ingresa en "gramos". Ingresa la Cantidad: (ej. `7`).
    *   Selecciona `Agua Filtrada`. La interfaz te indicará que la cantidad se ingresa en "mililitros". Ingresa la Cantidad: (ej. `50`).
    *   (Ajusta las cantidades según tu receta real).
*   Guarda.

### 3. Producto del Menú para Productos de Venta de Barbería:
*   Navega a: `Inventario > Productos del Menú`.
*   Haz clic en `Añadir Producto del Menú`.
*   Nombre: `Cera Moldeadora`
*   Descripción: `Cera de fijación fuerte para cabello.`
*   Precio: `35.00` (S/ 35)
*   Tipo: `Directo`
*   Ítem de Inventario Asociado: Selecciona `Cera Moldeadora (Pote 100g)`
*   Guarda.
*   Repite para `Champú Profesional` y `Acondicionador Profesional`.

---

## Paso 4: Creación de Servicios (y sus Insumos)

Crea los servicios que ofreces en la barbería y define los insumos que consumen.

### 1. Crear Servicio "Corte Fade":
*   Navega a: `Configuración > Servicios`.
*   Haz clic en `Añadir Servicio`.
*   Nombre: `Corte Fade`
*   Descripción: `Corte de cabello moderno estilo fade.`
*   Precio: `25.00` (S/ 25)
*   Duración: `30 minutos`
*   **Insumos del Servicio:**
    *   Haz clic en `Añadir Insumo`.
    *   Selecciona `Navaja de Afeitar (Unidad)`. Cantidad: `1`.
    *   Selecciona `Champú Profesional (Botella 1L)`. Cantidad: `10` (mililitros, asumiendo que el ítem está configurado en ml para el consumo).
    *   (Ajusta las cantidades según tu uso real).
*   Guarda.

### 2. Crear Servicio "Afeitado Clásico":
*   Navega a: `Configuración > Servicios`.
*   Haz clic en `Añadir Servicio`.
*   Nombre: `Afeitado Clásico`
*   Descripción: `Afeitado tradicional con toallas calientes.`
*   Precio: `20.00` (S/ 20)
*   Duración: `25 minutos`
*   **Insumos del Servicio:**
    *   Haz clic en `Añadir Insumo`.
    *   Selecciona `Navaja de Afeitar (Unidad)`. Cantidad: `1`.
    *   Selecciona `Gel de Afeitar (Pote 500ml)`. Cantidad: `15` (mililitros).
    *   Selecciona `Loción Post-Afeitado (Botella 200ml)`. Cantidad: `5` (mililitros).
    *   (Ajusta las cantidades según tu uso real).
*   Guarda.

---

## Paso 5: Creación del Combo "Corte Fade + Capuchino"

Ahora, ensamblaremos un combo utilizando un servicio de barbería y un producto compuesto de la cafetería. **Recuerda que los combos son paquetes fijos; no se permiten grupos de elección.**

### 1. Navega a: `Configuración > Combos`.
### 2. Haz clic en el botón `Añadir Combo`.
### 3. Completa los Detalles Principales:
*   Nombre del Combo: `Corte Fade + Capuchino`
*   Descripción: `Disfruta de un Corte Fade moderno y un delicioso Capuchino.`
*   Asegúrate de que la casilla `Activo` esté marcada.

### 4. Añade los Ítems Fijos al Combo:
*   Haz clic en `Añadir Servicio`.
*   Busca y selecciona el servicio `Corte Fade`. Cantidad: `1`.
*   Haz clic en `Añadir Producto`.
*   Busca y selecciona el Producto del Menú `Capuchino`. Cantidad: `1`.

### 5. Verifica el Precio del Combo:
*   El sistema calculará automáticamente el **Precio de Venta** del combo.
*   **Importante:** Este precio es la suma de los precios de sus componentes (ej. S/ 25 por el Corte Fade + S/ 8 por el Capuchino = S/ 33). El precio del combo no se puede editar manualmente para ofrecer descuentos directos; estos se aplicarían al momento de la venta.

### 6. Haz clic en `Guardar Combo`.

---

## Paso 6: Prueba del Combo en una Venta

### 1. Navega a `Agenda y Citas > Calendario` y crea una nueva venta directa o completa una reserva.
### 2. Al añadir ítems a la venta, busca y selecciona el combo `Corte Fade + Capuchino`.
### 3. Una vez añadido a la venta y esta sea completada, el sistema:
*   Descontará los insumos del servicio `Corte Fade` (ej. 1 Navaja de Afeitar, 10ml de Champú Profesional) según su configuración.
*   Descontará los ingredientes del `Capuchino` (ej. 18g de Grano de Café, 120ml de Leche, 7g de Azúcar, 50ml de Agua Filtrada) según su receta.

*   **Clave:** La deducción de inventario se realiza automáticamente para **todos los componentes fijos** del combo, en sus respectivas unidades de consumo.
