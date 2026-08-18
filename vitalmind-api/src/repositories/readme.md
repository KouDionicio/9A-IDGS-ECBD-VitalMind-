# 🗂️ Repositories — VitalMind

Esta carpeta contiene los **repositorios** del proyecto **VitalMind**.

Los repositories se encargan de centralizar el acceso y las operaciones relacionadas con la **base de datos**, permitiendo mantener separada la lógica de consultas de la lógica de negocio.

## 📁 Funciones

Los repositories pueden encargarse de operaciones como:

* 📋 Obtener registros.
* 🔍 Buscar información por ID.
* ➕ Crear nuevos registros.
* ✏️ Actualizar información.
* 🗑️ Eliminar registros.

## 📂 Estructura

```text
repositories/
│
├── userRepository.js
├── patientRepository.js
└── alertRepository.js
```

## ⚙️ Funcionamiento

La arquitectura permite separar las responsabilidades del sistema:

```text
Routes
   ↓
Controllers
   ↓
Services
   ↓
Repositories
   ↓
Database
```

Los **repositories** realizan las consultas necesarias a la base de datos y devuelven la información para que pueda ser utilizada por las demás capas de la aplicación.

## 🛠️ Tecnologías relacionadas

* Node.js
* Express.js
* MySQL
* SQL

## 🎯 Objetivo

El objetivo de esta carpeta es mantener organizada y centralizada la comunicación con la base de datos, facilitando el mantenimiento y escalabilidad del proyecto **VitalMind**.

---

📌 **VitalMind — Capa de acceso a datos**
