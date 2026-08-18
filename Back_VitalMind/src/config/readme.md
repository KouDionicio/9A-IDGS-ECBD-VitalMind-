# Configuración del Backend

Esta carpeta contiene los archivos de configuración necesarios para el funcionamiento del backend de **VitalMind**.

## 📁 Contenido

Los archivos de esta carpeta permiten configurar la conexión con la base de datos y otros parámetros utilizados por la API.

### `database.js`

Contiene la configuración y conexión con la base de datos **MySQL**.

En este archivo se establecen parámetros como:

* Host de la base de datos.
* Puerto.
* Usuario.
* Contraseña.
* Nombre de la base de datos.

### `.env`

Contiene las variables de entorno utilizadas por el proyecto para mantener separada la información de configuración del código fuente.

Ejemplo:

```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=tu_password
DB_NAME=vitalmind
PORT=3000
```

> ⚠️ El archivo `.env` no debe subirse al repositorio si contiene credenciales reales.

## ⚙️ Función

La carpeta `config` permite centralizar la configuración del backend, facilitando el mantenimiento y evitando colocar directamente credenciales o parámetros sensibles dentro del código.

## 🔐 Seguridad

Se recomienda agregar `.env` al archivo `.gitignore`:

```gitignore
.env
```

## 🛠️ Tecnologías

* Node.js
* Express.js
* MySQL
* dotenv

## 📌 Estructura

```text
backend/
├── config/
│   └── database.js
├── controllers/
├── middleware/
├── routes/
├── services/
└── server.js
```
