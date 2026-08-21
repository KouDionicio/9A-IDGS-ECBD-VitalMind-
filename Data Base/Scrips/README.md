# Scrips

## Descripción

La carpeta `Scrips` contiene los scripts SQL utilizados para construir, configurar, mantener y poblar la base de datos **VitalMind AI**.

> Nota: el nombre `Scrips` se conserva debido a la estructura actual del proyecto.

## Estructura

```text
Scrips/
├── Procedures/
│   ├── vm_clean_demo.sql
│   ├── vm_seed_dashboard.sql
│   ├── vm_sync_dashboard_columns.sql
│   └── README.md
├── tables/
│   ├── Scripts SQL de las tablas
│   └── README.md
└── README.md
```

## `tables/`

Contiene un script SQL independiente para cada tabla principal de la base de datos.

Estos archivos permiten crear o reconstruir las entidades de VitalMind de manera organizada.

## `Procedures/`

Contiene procedimientos almacenados para tareas de mantenimiento, generación de datos de demostración y sincronización de estructura.

## Orden recomendado

Para una instalación desde cero:

1. Ejecutar los scripts de creación de tablas.
2. Verificar las relaciones y restricciones.
3. Crear los procedimientos almacenados.
4. Ejecutar `vm_sync_dashboard_columns` cuando sea necesario sincronizar columnas requeridas por el dashboard.
5. Ejecutar `vm_seed_dashboard` únicamente en ambientes donde se necesiten datos de demostración.

## Recomendación

No ejecutar procedimientos de limpieza en una base de datos de producción sin verificar previamente su funcionamiento y realizar un respaldo.
