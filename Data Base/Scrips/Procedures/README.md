# Procedures

## Descripción

Esta carpeta contiene los **procedimientos almacenados** utilizados por VitalMind AI para automatizar tareas de mantenimiento, preparación de datos de demostración y sincronización de la estructura de la base de datos.

## Procedimientos

### `vm_clean_demo.sql`

Crea el procedimiento `vm_clean_demo`.

Su objetivo es limpiar información de demostración de las tablas relacionadas con el sistema, desactivando temporalmente ciertas comprobaciones para poder eliminar los registros de forma controlada.

**Uso principal:** reiniciar un ambiente de desarrollo o pruebas.

**Precaución:** no debe ejecutarse sobre una base de datos con información real sin verificar previamente qué registros serán eliminados.

### `vm_seed_dashboard.sql`

Crea el procedimiento `vm_seed_dashboard(p_days)`.

Genera información sintética para poblar el dashboard de VitalMind durante un número determinado de días.

El parámetro `p_days` debe encontrarse entre **1 y 365**.

**Uso principal:** pruebas del dashboard, desarrollo y demostraciones.

### `vm_sync_dashboard_columns.sql`

Crea el procedimiento `vm_sync_dashboard_columns`.

Verifica la existencia de columnas necesarias para el funcionamiento del dashboard y realiza modificaciones de estructura cuando dichas columnas no existen.

Un ejemplo contemplado por el procedimiento es la sincronización de `symptom_logs.log_date`.

**Uso principal:** mantener la estructura requerida por el dashboard sin realizar manualmente cada comprobación.

## Recomendaciones

Los procedimientos deben crearse después de disponer de las tablas correspondientes.

Antes de ejecutar procedimientos de limpieza o modificación de estructura, realizar un respaldo de la base de datos.

