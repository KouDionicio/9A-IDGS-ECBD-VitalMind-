# Full Backup

## Descripción

Esta carpeta contiene el respaldo completo de la base de datos **VitalMind AI**.

## Archivo

### `DB_VitalMind.sql`

Es el respaldo integral de la base de datos. Contiene la definición y los datos de las principales tablas del sistema.

Entre las entidades respaldadas se encuentran:

- `users`
- `appointments`
- `audit_logs`
- `chat_conversations`
- `chat_messages`
- `emotional_logs`
- `habit_logs`
- `health_metrics`
- `medical_history_items`
- `medication_logs`
- `medications`
- `notifications`
- `refresh_tokens`
- `symptom_logs`

## Uso

Este respaldo puede utilizarse para reconstruir el estado de la base de datos en un entorno de recuperación, pruebas o migración.

## Precaución

La ejecución de un respaldo completo puede modificar o reemplazar información existente dependiendo de las instrucciones contenidas en el archivo. Se recomienda verificar previamente la base de datos de destino y realizar un respaldo adicional antes de restaurarlo.
