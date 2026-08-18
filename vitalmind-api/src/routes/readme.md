# 🛣️ Routes — VitalMind

Esta carpeta contiene las **rutas de la API** del proyecto **VitalMind**.

Las rutas se encargan de definir los diferentes **endpoints** disponibles y de conectar las solicitudes del cliente con los controladores correspondientes.

## 📁 Funciones

Las rutas permiten gestionar operaciones como:

* 📋 Obtener información.
* 🔍 Consultar registros por ID.
* ➕ Crear nuevos registros.
* ✏️ Actualizar información.
* 🗑️ Eliminar registros.

## 📂 Estructura

```text
routes/
│
├── userRoutes.js
├── patientRoutes.js
└── alertRoutes.js
```

## ⚙️ Funcionamiento

La comunicación dentro de la aplicación sigue la siguiente estructura:

```text
Cliente
   ↓
Routes
   ↓
Middleware
   ↓
Controllers
   ↓
Services
   ↓
Repositories
   ↓
Database
```

Cada archivo de rutas define los endpoints relacionados con una parte específica del sistema.

### Ejemplo de endpoints

```text
GET    /api/users
GET    /api/users/:id
POST   /api/users
PUT    /api/users/:id
DELETE /api/users/:id
```

## 🛠️ Tecnologías relacionadas

* Node.js
* Express.js
* REST API

## 🎯 Objetivo

El objetivo de esta carpeta es organizar y centralizar los endpoints de **VitalMind**, facilitando la comunicación entre el cliente y el backend.

---

📌 **VitalMind — Gestión de rutas y endpoints**
