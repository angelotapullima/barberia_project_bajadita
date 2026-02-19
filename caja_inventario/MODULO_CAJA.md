 
# 📦 Módulo: Flujo de Caja y Cierre Diario – Sistema de Barbería

## 🎯 Propósito

Implementar un módulo que permita gestionar, visualizar y controlar el flujo de dinero del negocio en tiempo real, asegurando que la cajera pueda:

* Saber cuánto dinero existe en total.
* Identificar dónde está distribuido (efectivo, bancos, billeteras digitales).
* Abrir y cerrar la caja diariamente.
* Detectar diferencias entre lo que el sistema calcula y lo que realmente existe físicamente.
* Mantener trazabilidad completa de todos los movimientos financieros.

---

# 🧠 Enfoque Conceptual

El sistema debe basarse en un modelo de **movimientos financieros**, no en saldos fijos.

Cada ingreso o egreso genera un movimiento que impacta una cuenta financiera.
Los saldos deben calcularse dinámicamente a partir del historial de movimientos.

El sistema nunca debe depender de un saldo manual editable, sino del acumulado de operaciones registradas.

---

# 💰 Concepto de Cuentas

Todo el dinero del negocio debe estar representado como una “cuenta”.

Ejemplos conceptuales:

* Caja física (efectivo)
* Billeteras digitales (Yape, Plin)
* Cuentas bancarias

Cada cuenta representa un lugar donde el dinero puede estar almacenado o moverse.

El sistema debe permitir visualizar el saldo individual por cuenta y el total consolidado.

---

# 🔄 Flujo Operativo Diario

## 1️⃣ Apertura de Caja

Al iniciar la jornada:

* Se registra el monto inicial en efectivo.
* Se crea una sesión diaria activa.
* Desde ese momento, todas las operaciones del día pertenecen a esa sesión.

Esto establece el punto de partida del cálculo financiero del día.

---

## 2️⃣ Operación Durante el Día

Durante la jornada pueden ocurrir:

### Ventas

Cada venta:

* Registra un ingreso.
* Impacta directamente la cuenta correspondiente según el método de pago.
* Aumenta el saldo de esa cuenta.

### Egresos

Cada gasto:

* Reduce el saldo de la cuenta desde donde se paga.
* Debe quedar registrado como movimiento financiero.

### Transferencias (si se implementa)

Mover dinero entre cuentas:

* Reduce el saldo de la cuenta origen.
* Incrementa el saldo de la cuenta destino.
* No afecta el total general del negocio.

---

## 3️⃣ Vista de Flujo de Caja

La vista principal debe mostrar:

### Resumen del Día

* Total de ingresos
* Total de egresos
* Resultado neto del día

### Saldo por Medio

* Efectivo
* Billeteras digitales
* Bancos
* Total consolidado

### Detalle de Movimientos

* Lista cronológica de ingresos y egresos.
* Posibilidad de filtrar por fecha o tipo.

---

## 4️⃣ Cierre de Caja

Al finalizar la jornada:

1. El sistema calcula cuánto debería existir en cada cuenta.
2. La cajera registra cuánto dinero realmente tiene (principalmente efectivo).
3. El sistema compara ambos valores.
4. Si existe diferencia:

   * Se registra como incidencia.
   * Se almacena para control administrativo.

Una vez cerrada la caja:

* No se deben permitir nuevas operaciones en esa sesión.
* Cualquier ajuste posterior debe realizarse como movimiento correctivo.

---

# 🔐 Principios de Control

* No se deben editar movimientos históricos.
* Los errores deben corregirse con movimientos compensatorios.
* El saldo siempre debe calcularse desde los movimientos.
* El cierre diario debe bloquear la jornada.
* Toda operación debe quedar registrada con usuario responsable.

---

# 📊 Resultado Esperado

Al terminar el día el sistema debe poder responder claramente:

* ¿Cuánto dinero ingresó hoy?
* ¿Cuánto se gastó hoy?
* ¿Cuánto dinero hay en total?
* ¿Dónde está ese dinero?
* ¿La caja cuadra o hay diferencia?

---

# 🚀 Escalabilidad Futura

El módulo debe permitir crecer hacia:

* Reportes mensuales
* Análisis de rentabilidad
* Control por múltiples sucursales
* Historial de diferencias
* Indicadores financieros
* Dashboard gráfico
* Exportación de reportes

---

# 🏁 Visión Final

Este módulo convierte la barbería en un negocio con control financiero real, trazabilidad completa y reducción de pérdidas por descuadres.

No es solo una caja.
Es un sistema de control financiero operativo diario.
 