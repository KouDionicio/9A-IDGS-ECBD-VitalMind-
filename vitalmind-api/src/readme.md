# 📁 SRC — VitalMind

La carpeta **`src`** contiene el código fuente principal del backend de **VitalMind**.

Aquí se encuentran los módulos, configuraciones y componentes necesarios para el funcionamiento de la aplicación, organizados de acuerdo con sus responsabilidades.

## 📂 Estructura

```text
src/
│
├── config/
├── controllers/
├── dashboard/
├── docs/
├── middleware/
├── repositories/
├── routes/
├── services/
├── utils/
├── validations/
│
├── app.js
├── server.js
└── readme.md
```

## 📁 Contenido de las carpetas

### ⚙️ Config

Contiene la configuración necesaria para el funcionamiento de la aplicación, como la conexión a la base de datos y otras variables de configuración.

### 🎮 Controllers

Contienen la lógica encargada de recibir las solicitudes HTTP, procesarlas y enviar las respuestas correspondientes.

### 📊 Dashboard

Contiene los componentes o funcionalidades relacionadas con el panel de control y la visualización de información del sistema.

### 📚 Docs

Contiene la documentación técnica del proyecto, incluyendo información sobre la API, estructura y funcionamiento del sistema.

### 🛡️ Middleware

Contiene funciones intermedias que se ejecutan durante el procesamiento de las solicitudes, como autenticación, validaciones y manejo de errores.

### 🗂️ Repositories

Se encargan de centralizar las consultas y operaciones relacionadas con la base de datos.

### 🛣️ Routes

Definen los endpoints de la API y conectan las solicitudes del cliente con los controladores correspondientes.

### ⚙️ Services

Contienen la lógica de negocio de VitalMind y permiten separar las responsabilidades de la aplicación.

### 🧰 Utils

Contiene funciones y herramientas reutilizables utilizadas en diferentes partes del proyecto.

### ✅ Validations

Contiene las reglas y funciones encargadas de validar la información recibida antes de ser procesada por el sistema.

## 📄 Archivos principales

### `app.js`

Se encarga de configurar la aplicación, los middlewares y las rutas principales.

### `server.js`

Es el archivo encargado de iniciar el servidor y poner en funcionamiento la aplicación.

## 🏗️ Arquitectura

```text
Cliente
   ↓
Routes
   ↓
Middleware
   ↓
Validations
   ↓
Controllers
   ↓
Services
   ↓
Repositories
   ↓
Database
```

## 🛠️ Tecnologías

* Node.js
* Express.js
* JavaScript
* MySQL
* REST API

## 🎯 Objetivo

El objetivo de la carpeta **`src`** es mantener organizado todo el código fuente de **VitalMind**, separando las diferentes responsabilidades del backend para facilitar su desarrollo, mantenimiento y escalabilidad.

---

📌 **VitalMind — Código fuente principal del Backend**
