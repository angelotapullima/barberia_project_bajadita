# 📦 Integración: Caja + Inventario + Centros de Costo

## 🎯 Objetivo

Unificar:

* Control de dinero (Caja)
* Control de productos (Inventario)
* Control de consumo interno
* Control de compras
* Control por centro de costos
* Base para cálculo de comisiones

Todo debe estar conectado, pero sin mezclar responsabilidades.

---

# 🧠 Principio General

Caja controla **dinero**.
Inventario controla **productos**.
Centros de costo controlan **rentabilidad y clasificación**.

Cada módulo impacta al otro mediante eventos, no mediante edición directa.

---

# 🏷 1️⃣ Módulo de Inventario – Concepto

## Productos

Cada producto debe existir como entidad básica:

* Información general
* Precio de compra
* Precio de venta
* Categoría
* Centro de costo asociado

El sistema debe diferenciar:

* Precio de compra (costo real)
* Precio de venta (precio al público)

---

## Compras de Productos

Una compra:

* Puede contener múltiples ítems.
* Representa ingreso de stock.
* Representa salida de dinero (si fue pagada).

Debe permitir:

* Registrar proveedor
* Registrar comprobante (boleta/factura)
* Registrar monto total
* Registrar detalle por producto (cantidad y precio unitario)
* Registrar origen del dinero

---

# 💰 Relación Compra → Caja

Cada compra debe:

1. Aumentar stock.
2. Generar movimiento financiero si fue pagada.

Casos posibles:

* Se paga con efectivo → impacta caja.
* Se paga con Yape → impacta billetera digital.
* Se paga desde banco → impacta banco.
* El dueño pone dinero personal → no afecta caja del negocio, se registra como aporte.

Ese último caso debe tratarse como:

* Aporte de capital temporal.
* O deuda del negocio hacia el dueño.

Pero no debe distorsionar el saldo operativo diario de la cajera.

---

# 📦 Flujo de Compras

Compra →
Aumenta stock →
Si pagada → genera egreso en cuenta correspondiente →
Si no pagada → queda como cuenta por pagar.

---

# 🔄 Caso Especial: Cierre Diario de Caja

La cajera:

* Cierra caja cada día.
* Entrega el dinero al dueño.
* Excepto viernes y sábado (retiene efectivo para pagar barberos).

Entonces debe existir el concepto de:

## Transferencia de Caja al Dueño

Cuando entrega dinero:

* Se genera un movimiento de salida de caja.
* Se registra como transferencia al dueño.
* No es gasto.
* Es retiro de fondos.

Debe quedar trazabilidad clara de cuánto se entregó y cuándo.

---

# 🧴 2️⃣ Entrega de Productos a Barberos (Consumo Interno)

Este es MUY importante.

No es venta.
No es gasto directo.
Es consumo interno.

Cuando un barbero solicita un producto:

* Se reduce el stock.
* No se mueve dinero.
* Se registra como “Consumo Interno”.
* Se asocia al barbero.
* Se registra el valor del producto a costo de compra.

Esto permite:

* Saber cuánto cuesta operar.
* Saber cuánto insumo consume cada barbero.
* Controlar pérdidas.
* Evaluar rentabilidad real.

Debe quedar registrado:

* Producto
* Cantidad
* Barbero
* Valor a costo
* Fecha

Esto impacta:

* Inventario (reduce stock).
* Reportes de centro de costo.
* No impacta caja.

---

# 🏢 3️⃣ Centros de Costo

Ahora entramos a nivel más empresarial 🔥

Cada venta debe pertenecer a un centro de costo.

Ejemplos:

* Barbería (servicios de corte)
* Cafetería (venta de café)
* Productos (venta de gel, shampoo, etc.)

Esto permite:

* Separar ingresos por unidad de negocio.
* Calcular comisiones.
* Analizar rentabilidad.

---

# 💼 Centro de Costo en Ventas

Cada venta debe tener:

* Centro de costo
* Tipo de operación

Ejemplos:

| Operación   | Centro    |
| ----------- | --------- |
| Corte       | Barbería  |
| Café        | Cafetería |
| Gel vendido | Productos |

---

# 💸 Comisión por Venta de Productos

Como la cajera genera comisión por productos:

El sistema debe poder:

* Filtrar ventas por centro de costo “Productos”.
* Calcular comisión según regla definida.
* Excluir servicios si no aplican.

---

# 📊 Relación Global entre Módulos

### Venta

* Impacta caja.
* Puede impactar inventario (si es producto).
* Pertenece a centro de costo.
* Puede generar comisión.

### Compra

* Aumenta inventario.
* Puede impactar caja.
* Puede generar deuda.
* Pertenece a centro de costo operativo.

### Entrega a Barbero

* Reduce inventario.
* No impacta caja.
* Impacta costo interno.

### Cierre Diario

* Consolida movimientos financieros.
* Permite transferir dinero al dueño.
* Bloquea sesión.

---

# 🧮 Visión Financiera Completa

El sistema debe poder responder:

* ¿Cuánto vendió la barbería?
* ¿Cuánto vendió la cafetería?
* ¿Cuánto vendió productos?
* ¿Cuánto costaron los insumos?
* ¿Cuánto se entregó al dueño?
* ¿Cuánto consumen los barberos?
* ¿Cuánto queda realmente como utilidad?

---

# 🏗 Estructura Conceptual Final

Tienes 4 dominios conectados:

1. Caja (dinero)
2. Inventario (productos)
3. Operación Interna (consumo barberos)
4. Centros de Costo (clasificación y análisis)

Todos generan eventos.
Ninguno modifica directamente el estado del otro.
Todo se conecta mediante movimientos.

---

# 🚀 Nivel Empresarial

Con esto puedes evolucionar a:

* Estado de resultados real
* Rentabilidad por unidad
* Costo por barbero
* Margen por producto
* Control de pérdidas
* Flujo de caja semanal
* Control de aportes del dueño
* Gestión de cuentas por pagar
 