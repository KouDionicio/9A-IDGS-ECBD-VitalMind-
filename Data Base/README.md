readme para la carpeta de Data Base# Base de Datos — VitalMind AI

## Descripción

Esta carpeta contiene los recursos de base de datos utilizados por el proyecto **VitalMind AI**. Incluye los scripts para crear y mantener las tablas, procedimientos almacenados, respaldos de la base de datos y archivos relacionados con el modelo y diccionario de datos.

La base de datos utiliza **MySQL** y está identificada como `vitalmind`.

## Estructura

```text
Data Base/
├── Backups/
│   ├── full_backup/
│   └── README.md
├── Diagram/
│   ├── DIccionario de datos VitalMind.html
│   ├── MySQL Workbench Models VitalMind.mwb
│   └── README.md
├── Scrips/
│   ├── Procedures/
│   ├── tables/
│   └── README.md
└── README.md
```

## Carpetas principales

### `Backups/`
Contiene respaldos de la base de datos. Se incluyen respaldos completos, de estructura y de datos.

### `Diagram/`
Contiene los archivos utilizados para representar y consultar la estructura de la base de datos, incluyendo el modelo de MySQL Workbench y el diccionario de datos en HTML.

### `Scrips/`
Contiene los scripts SQL necesarios para crear y administrar los elementos de la base de datos.

> Nota: el nombre de la carpeta `Scrips` se conserva para mantener la estructura actual del proyecto.

## Base de datos

**Nombre:** `vitalmind`

**Motor:** MySQL 8.0

**Codificación:** `utf8mb4`

La estructura contempla módulos relacionados con usuarios, medicamentos, citas, métricas de salud, hábitos, síntomas, estado emocional, historial médico, notificaciones, auditoría y funcionalidades de chat.

## Orden recomendado de uso

1. Crear o seleccionar la base de datos `vitalmind`.
2. Ejecutar los scripts de `Scrips/tables/` para crear las tablas.
3. Ejecutar los procedimientos almacenados de `Scrips/Procedures/`.
4. Si se requiere información de demostración, utilizar `vm_seed_dashboard.sql`.
5. Consultar el modelo y diccionario de datos disponibles en `Diagram/`.
6. Utilizar los archivos de `Backups/` para restauración cuando sea necesario.

## Consideraciones

Los respaldos deben utilizarse con precaución, especialmente los scripts que contienen instrucciones de eliminación o restauración de datos.

Se recomienda realizar un respaldo antes de ejecutar procedimientos de limpieza o restauración sobre una base de datos con información real.
