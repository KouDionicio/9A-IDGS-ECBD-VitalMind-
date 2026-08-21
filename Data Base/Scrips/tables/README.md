# Tables

## Descripción

La carpeta `tables` contiene los scripts SQL de las tablas principales de la base de datos **VitalMind AI**.

Cada archivo está asociado con una entidad o módulo específico del sistema, facilitando la creación y mantenimiento de la estructura de manera independiente.

## Tablas incluidas

### Usuarios y autenticación

`vitalmind_users.sql`  
Define la tabla `users`, utilizada para almacenar la información principal de los usuarios.

`vitalmind_refresh_tokens.sql`  
Define `refresh_tokens`, utilizada para administrar tokens de actualización de sesión.

### Salud y seguimiento

`vitalmind_health_metrics.sql`  
Define `health_metrics`, utilizada para registrar métricas relacionadas con el estado de salud.

`vitalmind_symptom_logs.sql`  
Define `symptom_logs`, utilizada para registrar síntomas y su seguimiento.

`vitalmind_emotional_logs.sql`  
Define `emotional_logs`, utilizada para registrar información relacionada con el estado emocional, incluyendo variables de seguimiento diario.

`vitalmind_habit_logs.sql`  
Define `habit_logs`, utilizada para registrar hábitos y actividades del usuario.

### Medicamentos

`vitalmind_medications.sql`  
Define `medications`, utilizada para almacenar los medicamentos asociados con los usuarios.

`vitalmind_medication_logs.sql`  
Define `medication_logs`, utilizada para registrar eventos o tomas relacionadas con los medicamentos.

### Historial y citas

`vitalmind_medical_history_items.sql`  
Define `medical_history_items`, utilizada para almacenar elementos del historial médico.

`vitalmind_appointments.sql`  
Define `appointments`, utilizada para gestionar las citas registradas en el sistema.

### Notificaciones y auditoría

`vitalmind_notifications.sql`  
Define `notifications`, utilizada para administrar notificaciones dirigidas a los usuarios.

`vitalmind_audit_logs.sql`  
Define `audit_logs`, utilizada para registrar eventos y acciones relevantes del sistema.

### Chat

`vitalmind_chat_conversations.sql`  
Define `chat_conversations`, utilizada para administrar las conversaciones.

`vitalmind_chat_messages.sql`  
Define `chat_messages`, utilizada para almacenar los mensajes pertenecientes a las conversaciones.

### Rutinas

`vitalmind_routines.sql`  
Contiene la estructura y rutinas relacionadas con la base de datos, de acuerdo con el contenido actual del script.

## Recomendaciones para ejecución

Los scripts deben ejecutarse considerando las dependencias entre tablas y sus claves foráneas.

Para una instalación completa se recomienda:

1. Crear la base de datos `vitalmind`.
2. Ejecutar los scripts de tablas respetando las dependencias.
3. Verificar que las claves primarias y foráneas se hayan creado correctamente.
4. Ejecutar los procedimientos almacenados.
5. Validar la estructura mediante el modelo de MySQL Workbench.

## Mantenimiento

Cuando se modifique una tabla:

1. Actualizar el script correspondiente.
2. Actualizar el diccionario de datos.
3. Actualizar el modelo de MySQL Workbench cuando sea necesario.
4. Crear o actualizar los procedimientos que dependan de la modificación.
5. Generar un nuevo respaldo.
