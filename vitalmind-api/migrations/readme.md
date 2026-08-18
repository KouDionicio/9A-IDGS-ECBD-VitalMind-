# Migraciones de VitalMind

## Descripción

La carpeta `migrations` contiene los archivos utilizados para realizar cambios y actualizaciones en la estructura de la base de datos del proyecto **VitalMind**.

Las migraciones permiten mantener un control organizado sobre los cambios realizados en las tablas, campos y demás elementos de la base de datos.

## Estructura

```text
migrations/
│
├── 001_add_ml_configuration.sql
└── README.md
```

## Convención de nombres

Los archivos de migración siguen una numeración consecutiva para identificar el orden en que deben aplicarse:

```text
001_nombre_de_la_migracion.sql
002_nombre_de_la_migracion.sql
003_nombre_de_la_migracion.sql
```

## Uso

Cada archivo contiene instrucciones SQL necesarias para modificar la base de datos.

Las migraciones pueden incluir:

* Creación de tablas.
* Agregar nuevas columnas.
* Modificación de campos existentes.
* Creación de relaciones.
* Agregar configuraciones necesarias para nuevas funcionalidades.
* Actualización de la estructura de la base de datos.

## Importante

Las migraciones deben ejecutarse en orden numérico para evitar problemas de compatibilidad o dependencias entre los cambios realizados.

Antes de ejecutar una migración, se recomienda realizar una copia de seguridad de la base de datos.

## Proyecto

Esta carpeta forma parte del proyecto **VitalMind** y permite llevar un control de los cambios realizados en la estructura de su base de datos.
