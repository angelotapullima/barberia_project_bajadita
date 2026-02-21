# Guía de Integración: Google Wallet para Fidelización de Clientes

Esta guía detalla los pasos técnicos para implementar un sistema de tarjetas de fidelización digitales en la barbería, permitiendo a los clientes descargar una tarjeta a su Google Wallet y recibir notificaciones por proximidad (Geofencing).

---

## 1. Configuración en Google Cloud & Wallet Console

### 1.1 Preparar la Cuenta de Servicio (Service Account)
1.  En [Google Cloud Console](https://console.cloud.google.com/), ve a **IAM y administración > Cuentas de servicio**.
2.  Crea una nueva cuenta de servicio llamada `google-wallet-integrator`.
3.  Genera una **clave JSON** para esta cuenta y descárgala. *Guárdala de forma segura; no la subas al repositorio.*
4.  Copia el email de la cuenta de servicio (ej: `google-wallet-integrator@tu-proyecto.iam.gserviceaccount.com`).

### 1.2 Autorizar en Google Pay & Wallet Console
1.  Entra a la [Google Pay & Wallet Console](https://pay.google.com/business/console/).
2.  Ve a **Users** y añade el email de la cuenta de servicio que copiaste arriba con permisos de **Editor**.
3.  Anota tu **Issuer ID** (ubicado en la parte superior o en la configuración).

### 1.3 Crear una Clase de Objeto Genérico (Generic Class)
Las "clases" definen la plantilla visual de la tarjeta (colores, logo, nombre de la barbería).
1.  En la consola de Wallet, ve a **Wallet API > Manage > Classes**.
2.  Crea una nueva **Generic Class**.
3.  Define:
    *   **Class ID:** `[IssuerID].BarberiaFidelidad`
    *   **Issuer Name:** Nombre de tu Barbería.
    *   **Logo:** URL de una imagen cuadrada (PNG/JPG).
4.  Guarda la clase.

---

## 2. Implementación en el Backend (Node.js/TypeScript)

### 2.1 Variables de Entorno
Añade a tu archivo `.env`:
```env
GOOGLE_WALLET_ISSUER_ID=tu_issuer_id
GOOGLE_WALLET_CLASS_ID=BarberiaFidelidad
GOOGLE_APPLICATION_CREDENTIALS=ruta/a/tu/archivo-credenciales.json
```

### 2.2 Dependencias
Instalar la librería oficial de Google:
```bash
npm install googleapis
```

### 2.3 Servicio de Wallet (`src/services/wallet.service.ts`)
El servicio se encargará de:
1.  Autenticarse con Google.
2.  Crear el objeto de la tarjeta para el cliente específico.
3.  Configurar las coordenadas para el **Geofencing**.
4.  Generar un JWT firmado que el frontend usará para mostrar el botón "Add to Google Wallet".

### 2.4 Geofencing (Notificaciones por Proximidad)
En la creación del objeto, se debe incluir el array `locations`:
```typescript
locations: [
  {
    latitude: -12.046374, // Coordenadas de tu barbería
    longitude: -77.042793,
  }
]
```
Google Wallet mostrará una notificación automática cuando el usuario esté a menos de ~100-150 metros de estas coordenadas.

---

## 3. Implementación en el Frontend (Vue.js)

### 3.1 Vista de Registro Pública
Crear una nueva ruta en `router/index.js` que sea accesible sin autenticación: `/fidelizacion`.

### 3.2 Formulario de Captura
La vista `WalletRegistrationView.vue` debe tener:
1.  Campos: Nombre, Apellido, Teléfono.
2.  Botón "Registrar y Obtener mi Tarjeta".
3.  Al recibir éxito del backend, mostrar el botón oficial de Google Wallet.

### 3.3 Botón oficial de Google Wallet
Usa la URL generada por el backend:
```html
<a :href="saveUrl">
  <img src="https://storage.googleapis.com/wallet-console-assets/en-US/add-to-google-wallet.svg" alt="Add to Google Wallet">
</a>
```

---

## 4. Generación del Código QR

1.  Genera un QR que apunte a la URL de tu frontend: `https://tu-barberia.com/fidelizacion`.
2.  Coloca el QR en espejos o recepción de la barbería.

---

## 5. Flujo de Datos
1.  **Cliente** escanea el QR.
2.  **Frontend** muestra formulario de registro.
3.  **Backend** recibe datos, crea/actualiza cliente en DB, genera tarjeta en Google Wallet con Geofencing y devuelve el link de guardado.
4.  **Cliente** hace clic en "Add to Google Wallet".
5.  **Smartphone** guarda la tarjeta.
6.  **Notificación:** Cuando el cliente pase cerca de la barbería, recibirá un mensaje en su pantalla de bloqueo.

---

## Siguientes Pasos Recomendados
1.  Configurar la cuenta de servicio y obtener el JSON.
2.  Implementar el endpoint en el backend para generar el JWT.
3.  Diseñar la landing page de registro en el frontend.
