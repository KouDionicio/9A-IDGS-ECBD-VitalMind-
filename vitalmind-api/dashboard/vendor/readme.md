# VitalMind API

## Descripción

**VitalMind API** es una API desarrollada para gestionar la información del sistema VitalMind. El proyecto cuenta con una estructura organizada para la conexión con la base de datos, migraciones, scripts, documentación y un dashboard para la visualización de información.

El sistema permite centralizar y administrar los datos mediante servicios API, facilitando su consulta, registro, actualización y eliminación.

## Estructura del proyecto

```text
vitalmind-api/
│
├── dashboard/
│   ├── vendor/
│   │   ├── chart.umd.js
│   │   └── readme.md
│   └── index.html
│
├── docs/
│
├── migrations/
│
├── scripts/
│
├── src/
│
├── .env
├── .env.example
├── fix_add_gender.sql
├── fix_schema_vitalmind.sql
├── generate_vitalmind...
├── package.json
└── package-lock.json
```

## Tecnologías utilizadas

* **Node.js**
* **Express**
* **MySQL**
* **JavaScript**
* **Chart.js**
* **HTML**
* **dotenv**

## Características

* Gestión de información mediante una API REST.
* Conexión con base de datos MySQL.
* Uso de variables de entorno para proteger la configuración.
* Scripts para tareas del sistema.
* Migraciones para la estructura de la base de datos.
* Archivos SQL para corregir o actualizar el esquema.
* Dashboard para visualizar información.
* Integración de gráficas mediante Chart.js.

## Instalación

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
```

### 2. Entrar a la carpeta del proyecto

```bash
cd vitalmind-api
```

### 3. Instalar las dependencias

```bash
npm install
```

## Configuración de variables de entorno

Crea un archivo `.env` tomando como referencia `.env.example`.

Ejemplo:

```env
PORT=3000

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_contraseña
DB_NAME=vitalmind
DB_PORT=3306
```

> **Importante:** El archivo `.env` contiene información de configuración local y no debe compartirse públicamente.

## Base de datos

El proyecto incluye archivos SQL que pueden utilizarse para crear, corregir o actualizar la estructura de la base de datos.

Algunos archivos incluidos son:

```text
fix_add_gender.sql
fix_schema_vitalmind.sql
```

También se incluyen carpetas para organizar las migraciones y scripts relacionados con la base de datos.

## Ejecutar el proyecto

Después de instalar las dependencias y configurar el archivo `.env`, ejecuta:

```bash
npm start
```

En caso de contar con un script de desarrollo:

```bash
npm run dev
```

## Dashboard

El proyecto incluye una carpeta llamada `dashboard`, la cual contiene una interfaz para visualizar información mediante gráficas.

Para las visualizaciones se utiliza **Chart.js**, ubicado dentro de:

```text
dashboard/vendor/chart.umd.js
```

El archivo principal del dashboard es:

```text
dashboard/index.html
```

## Organización del proyecto

| Carpeta / Archivo          | Descripción                                                       |
| -------------------------- | ----------------------------------------------------------------- |
| `src/`                     | Código fuente principal de la API.                                |
| `dashboard/`               | Interfaz para visualizar información y gráficas.                  |
| `docs/`                    | Documentación del proyecto.                                       |
| `migrations/`              | Archivos para controlar cambios en la base de datos.              |
| `scripts/`                 | Scripts auxiliares del sistema.                                   |
| `.env`                     | Variables de entorno del proyecto.                                |
| `.env.example`             | Ejemplo de configuración de variables de entorno.                 |
| `package.json`             | Dependencias y scripts del proyecto.                              |
| `fix_add_gender.sql`       | Script SQL relacionado con la actualización del campo de género.  |
| `fix_schema_vitalmind.sql` | Script para corregir o actualizar el esquema de la base de datos. |

## Objetivo del proyecto

El objetivo de **VitalMind API** es proporcionar una estructura organizada para la gestión de información mediante una API conectada a una base de datos, permitiendo integrar posteriormente aplicaciones web, móviles o dashboards para consultar y visualizar los datos.

## Autora

**Jennifer Bautista Barrios**

Proyecto desarrollado como parte de la formación en **Desarrollo de Software**.
