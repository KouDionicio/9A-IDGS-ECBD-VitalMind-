# Backups

## Descripción

La carpeta `Backups` contiene los respaldos de la base de datos **VitalMind AI**. Estos archivos permiten conservar una copia de la información y de la estructura de la base de datos para recuperación, migración o pruebas.

## Archivos

### `Backup_OnlyData_VitalMind.sql`

Contiene principalmente los datos almacenados en la base de datos.

Se utiliza cuando se necesita conservar o restaurar la información sin depender de una copia completa de la estructura.

### `Backup_Onlystructure_VitalMind.sql`

Contiene la estructura de las tablas de la base de datos, incluyendo definiciones necesarias para reconstruir el esquema.

Es útil para crear una base de datos con la misma estructura sin restaurar los registros.

### `full_backup/`

Contiene un respaldo completo de la base de datos.

Para conocer el contenido específico de este respaldo, consultar el README ubicado dentro de `full_backup/`.

## Recomendaciones

Antes de restaurar un respaldo:

1. Verificar la versión de MySQL utilizada.
2. Confirmar que el respaldo corresponde a la versión requerida del proyecto.
3. Realizar una copia de seguridad de la base de datos actual.
4. Verificar que la base de datos de destino sea la correcta.
5. Ejecutar la restauración en un entorno de pruebas cuando sea posible.

## Restauración general

Los archivos `.sql` pueden ejecutarse desde MySQL Workbench, MySQL Shell o mediante el cliente de línea de comandos de MySQL.

La restauración debe realizarse de acuerdo con el tipo de respaldo: estructura, datos o respaldo completo.
