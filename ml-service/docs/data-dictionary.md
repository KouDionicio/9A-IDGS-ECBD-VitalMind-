
# Diccionario de datos de VitalMind AI

## Estado del documento

> Versión provisional pendiente de validación con el equipo de Backend.

## Objetivo

Definir las variables preliminares que podrán utilizarse durante la simulación, preparación, análisis y entrenamiento de los modelos de Machine Learning.

## Consideraciones

- Los nombres definitivos deberán coincidir con Backend.
- Los rangos podrán ajustarse con base en las reglas de simulación.
- Las variables no deben interpretarse como información diagnóstica.
- Los datos deberán ser anónimos o simulados.
- Los valores sensibles no deberán identificar directamente al usuario.

## Variables de identificación técnica

| Variable | Tipo | Descripción | Regla preliminar | Uso en ML |
|---|---|---|---|---|
| `record_id` | Cadena | Identificador anónimo del registro | Único y no vacío | Trazabilidad |
| `user_id` | Cadena | Identificador anónimo del usuario | No debe contener información personal | Agrupación temporal |
| `record_date` | Fecha y hora | Fecha del registro | Formato ISO 8601 | Análisis temporal |

## Variables demográficas

| Variable | Tipo | Unidad o categoría | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `age` | Entero | Años | 18 a 80 | Edad del usuario | Característica |
| `gender` | Categórica | Femenino, masculino, otro, no especificado | Categorías válidas | Género reportado voluntariamente | Análisis de sesgo |

## Variables de sueño

| Variable | Tipo | Unidad o categoría | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `sleep_hours` | Decimal | Horas | 0 a 14 | Horas dormidas durante el periodo | Característica |
| `sleep_quality` | Entero | Escala | 1 a 5 | Calidad percibida del sueño | Característica |
| `sleep_interruptions` | Entero | Número de interrupciones | 0 a 15 | Veces que el sueño fue interrumpido | Característica |
| `bedtime_consistency` | Decimal | Porcentaje | 0 a 100 | Regularidad del horario de sueño | Característica |

## Variables de actividad física

| Variable | Tipo | Unidad o categoría | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `physical_activity_minutes` | Entero | Minutos por día | 0 a 300 | Tiempo de actividad física | Característica |
| `steps` | Entero | Pasos | 0 a 50000 | Pasos registrados durante el día | Característica |
| `sedentary_minutes` | Entero | Minutos por día | 0 a 1440 | Tiempo sedentario estimado | Característica |
| `activity_intensity` | Categórica | Baja, moderada, alta | Categorías válidas | Intensidad predominante de actividad | Característica |

## Variables de hidratación y alimentación

| Variable | Tipo | Unidad o categoría | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `water_intake_liters` | Decimal | Litros | 0 a 8 | Consumo diario de agua | Característica |
| `meals_count` | Entero | Comidas por día | 0 a 8 | Número de comidas registradas | Característica |
| `healthy_meals_percentage` | Decimal | Porcentaje | 0 a 100 | Proporción estimada de comidas saludables | Característica |
| `meal_schedule_consistency` | Decimal | Porcentaje | 0 a 100 | Regularidad de los horarios de alimentación | Característica |

## Variables emocionales

| Variable | Tipo | Unidad o categoría | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `mood` | Categórica | Muy bajo, bajo, neutral, bueno, muy bueno | Categorías válidas | Estado de ánimo reportado | Característica |
| `stress_level` | Entero | Escala | 1 a 10 | Nivel de estrés percibido | Característica |
| `energy_level` | Entero | Escala | 1 a 10 | Nivel de energía percibido | Característica |
| `anxiety_level` | Entero | Escala | 1 a 10 | Nivel de ansiedad percibido | Característica |
| `emotional_text` | Texto | Texto libre | Máximo por definir | Mensaje voluntario para análisis emocional | Entrada de NLP |

## Variables de síntomas

| Variable | Tipo | Unidad o categoría | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `symptom_type` | Categórica | Catálogo por definir | Categorías válidas | Tipo general de síntoma registrado | Característica |
| `symptom_intensity` | Entero | Escala | 1 a 10 | Intensidad reportada | Característica |
| `symptom_duration_minutes` | Entero | Minutos | 0 a 1440 | Duración aproximada | Característica |
| `symptom_frequency_week` | Entero | Veces por semana | 0 a 50 | Frecuencia semanal | Característica |
| `has_persistent_symptoms` | Booleano | Verdadero o falso | Valor booleano | Indica recurrencia o persistencia | Característica |

## Variables de cumplimiento de hábitos

| Variable | Tipo | Unidad o categoría | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `habits_completed` | Entero | Número de hábitos | 0 a 30 | Hábitos cumplidos durante el periodo | Característica |
| `habits_planned` | Entero | Número de hábitos | 0 a 30 | Hábitos planificados | Característica |
| `habit_adherence_percentage` | Decimal | Porcentaje | 0 a 100 | Porcentaje de cumplimiento | Característica |
| `consecutive_days` | Entero | Días | 0 a 365 | Días consecutivos de seguimiento | Característica |

## Variables de uso de la aplicación

| Variable | Tipo | Unidad | Rango preliminar | Descripción | Uso en ML |
|---|---|---|---|---|---|
| `daily_sessions` | Entero | Sesiones por día | 0 a 50 | Número de sesiones | Característica |
| `app_usage_minutes` | Entero | Minutos por día | 0 a 1440 | Tiempo de uso | Característica |
| `chatbot_interactions` | Entero | Interacciones | 0 a 200 | Número de interacciones con el chatbot | Característica |
| `days_since_last_access` | Entero | Días | 0 a 365 | Días desde el último acceso | Característica |
| `notifications_opened_percentage` | Decimal | Porcentaje | 0 a 100 | Porcentaje de notificaciones abiertas | Característica |

## Variables derivadas

| Variable | Tipo | Rango | Descripción | Regla preliminar | Uso en ML |
|---|---|---|---|---|---|
| `sleep_score` | Decimal | 0 a 100 | Puntaje de sueño | Combinación de horas, calidad y regularidad | Característica |
| `activity_score` | Decimal | 0 a 100 | Puntaje de actividad | Combinación de minutos, pasos y sedentarismo | Característica |
| `nutrition_score` | Decimal | 0 a 100 | Puntaje de alimentación e hidratación | Regla por definir | Característica |
| `emotional_score` | Decimal | 0 a 100 | Puntaje emocional | Basado en ánimo, estrés, energía y ansiedad | Característica |
| `adherence_score` | Decimal | 0 a 100 | Puntaje de cumplimiento | Basado en hábitos planificados y completados | Característica |
| `wellbeing_score` | Decimal | 0 a 100 | Puntaje general de bienestar | Combinación ponderada de dimensiones | Objetivo de regresión |
| `risk_level` | Categórica | Bajo, medio, alto | Nivel preventivo de riesgo | Regla de etiquetado por definir | Objetivo de clasificación |
| `is_anomaly` | Booleano | Verdadero o falso | Registro atípico | Determinado por el modelo | Resultado |
| `emotional_tone` | Categórica | Categorías por definir | Tono estimado del mensaje | Determinado por NLP | Objetivo o resultado |

## Variables que no deben utilizarse como características

Los siguientes datos no deberán utilizarse como entradas del modelo:

- Nombre.
- Correo electrónico.
- Número telefónico.
- Dirección.
- Contraseña.
- Token de autenticación.
- CURP.
- Identificadores externos.
- Información que permita identificar directamente a una persona.

## Variables objetivo preliminares

### Clasificación

```text
risk_level
```
### Clases
- bajo
- medio
- alto

### Regresión
```text
wllbeing_score
```
### Rango
```text
0 a 100
```
### Análisis emocional
```text
emotional_tone
```
### Categorias preliminares
- positivo
- neutral
- tristeza
- estres
- ansiedad

## Reglas generales de validación

- Los porcentajes deben permanecer entre **0 y 100**.
- Las escalas deben respetar el rango declarado.
- Las cantidades no pueden ser negativas.
- Las fechas deben utilizar un formato consistente.
- Los identificadores deben ser anónimos.
- Las categorías deben pertenecer al catálogo autorizado.
- Los textos deben tener una longitud máxima definida.
- Los valores faltantes deben tratarse mediante un proceso documentado.
- Las variables derivadas deben calcularse mediante scripts.
- Los campos definitivos deberán alinearse con Backend.

---
