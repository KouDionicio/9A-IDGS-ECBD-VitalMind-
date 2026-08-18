# Middleware

La carpeta `middleware` contiene funciones intermedias que se ejecutan durante el procesamiento de las solicitudes HTTP del backend de **VitalMind**.

## 📁 Función

Los middleware permiten controlar y validar las solicitudes antes de que lleguen a los controladores.

Entre sus principales funciones se encuentran:

* Validar solicitudes.
* Verificar autenticación y autorización.
* Validar tokens de acceso.
* Controlar permisos de usuarios.
* Manejar errores.
* Procesar información antes de enviarla a los controladores.

## 🔄 Funcionamiento

```text
Cliente
   ↓
Middleware
   ↓
Validación / Autenticación
   ↓
Routes
   ↓
Controllers
   ↓
Respuesta
```

## 📌 Estructura

```text
middleware/
├── auth.middleware.js
├── validation.middleware.js
└── ...
```

La estructura puede variar dependiendo de los middleware implementados en el proyecto.

## 🎯 Objetivo

Centralizar las validaciones y controles de seguridad del backend para mantener una API organizada, segura y fácil de mantener.

## 🛠️ Tecnologías

* Node.js
* Express.js
* JavaScript
* JWT
