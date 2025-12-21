# 1. Listado de Clientes
## 1.1. Objetivo

Mostrar todos los clientes registrados, permitir búsqueda rápida, visualizar datos clave y acceder al detalle.

## 1.2. Componentes y Contenido
### 🔹 Header

Título: Clientes

Botón destacado: Agregar Cliente

Campo de búsqueda por:

Nombre

DNI

Teléfono

Correo

### 🔹 Filtros adicionales

Selector de estado:

Activo

Inactivo

Ordenar por:

Fecha de registro

Nombre

Nº de visitas

Total gastado

Rango de fechas (Registro o últimas visitas)

### 🔹 Tabla/Listado de clientes

Cada fila debe mostrar:

Campo	Descripción
Foto	Avatar del cliente (opcional)
Nombre Completo	first_name + last_name
DNI	persons.dni
Teléfono	persons.phone (click → WhatsApp)
Última Visita	Última reserva/venta
Total Gastado	SUM ventas
Puntos	loyalty_points
Acciones	Ver → Detalle de cliente
### 🔹 Acciones por fila

Ver cliente (lleva al perfil)

Editar cliente

Desactivar cliente

Registrar venta rápida (shortcut)

# 2. Pantalla de Detalle del Cliente
## 2.1. Objetivo

Visualizar toda la información del cliente, su actividad, su historial y estadísticas de consumo.

## 2.2. Diseño General

Dividido en dos columnas:

[ Panel Izquierdo ] — Información del perfil
[ Panel Derecho   ] — Actividad, reservas y estadísticas

## 2.3. Panel Izquierdo — Información del Cliente
### 🔹 Card: Información Personal

Foto / Avatar

Nombre completo

DNI

Teléfono (botón WhatsApp)

Correo

Dirección

Fecha de nacimiento

Fecha de registro como cliente (start_date)

### 🔹 Card: Notas y Observaciones

Campo multilinea con notas internas (clients.notes)

Lista de notas anteriores (si luego se agrega tabla)

Botones:

Agregar Nota

Editar Nota

### 🔹 Card: Preferencias (opcional)

Barbero favorito

Servicio favorito

Historial de evaluaciones internas (si se implementa)

### 🔹 Card: Puntos y Fidelización

Puntos actuales

Representación visual (barra/medidor)

Próxima recompensa sugerida

Historial de puntos (si se agrega tabla futura)

## 2.4. Panel Derecho — Actividad del Cliente

Organizado en Tabs:

[ Reservas | Historial de Servicios | Compras | Estadísticas ]

---
TAB A — RESERVAS
## 3.1. Próximas Reservas

Mostrar todas las reservas con status = 'reservado'.

Campos:

Fecha

Hora

Barbero asignado

Servicio reservado

Estación (si aplica)

Precio del servicio

Estado actual

Acciones:

Ver reserva

Cancelar reserva

Marcar como pagado (si procede)

## 3.2. Historial de Reservas

Tabla con:

Campo	Descripción
Fecha	Fecha de reserva
Servicio	Nombre del servicio
Barbero	Barbero que atendió
Duración	duration_minutes
Estado	pagado/cancelado
Venta asociada	Link a la venta
---
TAB B — HISTORIAL DE SERVICIOS

Fuente: sales + sale_items (item_type = 'service')

## 4.1. Timeline o tabla

Cada entrada debe incluir:

Fecha de servicio

Servicio realizado

Barbero

Monto pagado

Productos usados (si se implementa consumo por receta)

Notas del servicio (desde reservations.notes)

Botón: Ver venta completa

## 4.2. Indicadores rápidos

Total de servicios realizados

Servicio más frecuente

Barbero más frecuente

Frecuencia promedio de visita (cada X días)

---
TAB C — COMPRAS DE PRODUCTOS

(Fuente: sale_items con item_type = 'product')

## 5.1. Tabla con:

Fecha de compra

Producto

Cantidad

Precio unitario

Total

Barbero/vendedor asociado

Venta relacionada

## 5.2. Totales

Total gastado en productos

Producto más comprado

---
TAB D — ESTADÍSTICAS DEL CLIENTE
## 6.1. Gráficos / Cards informativas

Cards:

💰 Total gastado

✂️ Servicios totales

🛒 Productos comprados

📊 Ticket promedio

⭐ Servicio más solicitado

🧑‍🔧 Barbero más frecuente

📅 Frecuencia de visitas

## 6.2. Gráfico de línea (opcional)

Evolución mensual del gasto

## 6.3. Gráfico de barras

Servicios más consumidos

## 6.4. RFM Score (si el negocio lo usa)

Recency (última visita)

Frequency (número de visitas)

Monetary (monto gastado)

## 7. Acciones Globales del Cliente (botonera superior)

En la parte superior del detalle del cliente:

Nueva Reserva

Nueva Venta

Editar Cliente

Agregar Nota

Ver Historial Completo

Eliminar Cliente

## 8. Pantalla: Crear / Editar Cliente
### Campos:

Nombre

Apellido

DNI

Teléfono

Correo

Dirección

Fecha de nacimiento

Notas iniciales

Activar/Desactivar cliente

## 9. Pantalla: Confirmación de Eliminación

Debe indicar:

¿Seguro que deseas eliminar al cliente?
Se eliminarán también:
- Reservas
- Ventas
- Historial


Botones:

Cancelar

Eliminar definitivamente