<div align="center">

# 📘 Diccionario de Datos — VitalMind AI

<p align="center">
  <img src="https://img.shields.io/badge/Estado-Documentado-0F766E?style=for-the-badge" alt="Estado">
  <img src="https://img.shields.io/badge/Columnas-35-2563EB?style=for-the-badge" alt="Columnas">
  <img src="https://img.shields.io/badge/Registros-5%2C000-7C3AED?style=for-the-badge" alt="Registros">
</p>

</div>

## 1. Descripción

Este documento define los campos presentes en:

- `data/raw/vitalmind_dataset_raw.csv`
- `data/processed/vitalmind_dataset_processed.csv`

Los rangos mostrados corresponden a los valores observados en el dataset procesado. No representan rangos clínicos oficiales.

### Convenciones

| Elemento | Descripción |
|---|---|
| **Raw** | Dataset original con 34 columnas y valores faltantes |
| **Processed** | Dataset procesado con 35 columnas y sin valores nulos |
| **Tipo lógico** | Tipo esperado para análisis, independientemente del tipo interno de pandas |
| **Fuente** | Archivo donde aparece el campo |
| **Uso** | Finalidad principal dentro del proyecto |

---

## 2. Identificación y tiempo

| Campo | Tipo lógico | Descripción | Valores o rango observado | Validación | Fuente | Uso |
|---|---|---|---|---|---|---|
| `record_id` | Texto | Código único asignado a cada fila del dataset. Permite distinguir un registro de bienestar de cualquier otro y facilita su seguimiento durante la limpieza, el análisis y la carga de información. | `REC_000001` a `REC_005000` | Obligatorio y sin duplicados | Ambos | Llave del registro |
| `user_id` | Texto | Identificador artificial que representa a una persona dentro del dataset sintético. Permite reunir todos los registros que pertenecen al mismo usuario sin utilizar nombres ni datos personales reales. | 250 usuarios, formato `USR_0001` | Obligatorio | Ambos | Agrupación por usuario |
| `log_date` | Fecha | Fecha en la que se generó o registró la observación de bienestar. Se utiliza para ordenar la información cronológicamente y analizar cambios de hábitos, síntomas o indicadores a lo largo del tiempo. | 2026-04-01 a 2026-06-29 | Formato `YYYY-MM-DD` | Ambos | Análisis temporal |

---

## 3. Perfil del usuario

| Campo | Tipo lógico | Unidad | Descripción | Rango o valores | Validación | Fuente | Uso |
|---|---|---:|---|---|---|---|---|
| `profile_type` | Categórico | N/A | Categoría general asignada al usuario sintético según la combinación de sus hábitos y condiciones simuladas. Sirve para representar distintos perfiles de bienestar y comparar su comportamiento dentro del análisis. | `healthy`, `physically_vulnerable`, `irregular`, `poor_habits` | Solo valores permitidos | Ambos | Segmentación y análisis |
| `age` | Entero | Años | Edad simulada del usuario al que pertenece el registro. Puede utilizarse para estudiar diferencias de comportamiento o bienestar entre grupos de edad. | 18 a 74 | Mayor o igual a 18 | Ambos | Característica de entrada |
| `height_cm` | Decimal | cm | Estatura del usuario expresada en centímetros. Este valor se utiliza junto con el peso para calcular o validar el índice de masa corporal. | 140.0 a 191.2 | Valor positivo | Ambos | Cálculo de IMC |
| `weight_profile_kg` | Decimal | kg | Peso base definido para el perfil sintético del usuario. Funciona como referencia cuando el peso específico de un registro no se encuentra disponible. | 40.0 a 134.4 | Valor positivo | Ambos | Referencia del perfil |
| `weight_kg` | Decimal | kg | Peso registrado para una observación específica. Puede variar ligeramente entre fechas y se utiliza en cálculos relacionados con el estado físico, como el índice de masa corporal. | 40.0 a 134.5 | Valor positivo; admite nulos solo en raw | Ambos | IMC y análisis físico |
| `bmi` | Decimal | kg/m² | Índice de masa corporal obtenido a partir del peso y la estatura. Resume la relación entre ambas medidas y se utiliza como indicador descriptivo dentro del análisis físico. | 16.16 a 44.33 | Debe ser coherente con peso y estatura | Ambos | Indicador físico |
| `weight_source` | Categórico | N/A | Indica de dónde proviene el valor final de `weight_kg` en el dataset procesado. Permite saber si el peso estaba disponible en el registro original o si se completó utilizando el peso base del perfil. | `symptom_log`, `profile_fallback` | Solo valores permitidos | Processed | Trazabilidad de imputación |

---

## 4. Hábitos de bienestar

| Campo | Tipo lógico | Unidad | Descripción | Rango observado | Validación | Fuente | Uso |
|---|---|---:|---|---:|---|---|---|
| `water_glasses` | Decimal | Vasos | Cantidad estimada de vasos de agua consumidos durante el día. Se utiliza para analizar el nivel de hidratación y su posible relación con otros indicadores de bienestar. | 0.0 a 14.25 | No negativo | Ambos | Hidratación |
| `water_liters` | Decimal | L | Equivalencia en litros del consumo registrado en `water_glasses`. Facilita el uso de una unidad estándar para cálculos, comparaciones y visualizaciones. | 0.0 a 3.56 | Aproximadamente `water_glasses × 0.25` | Ambos | Hidratación |
| `exercise_minutes` | Decimal | Minutos | Tiempo total dedicado a realizar actividad física durante el día. Permite medir el nivel de movimiento y analizar su relación con energía, sueño y bienestar. | 0.0 a 111.0 | No negativo | Ambos | Actividad física |
| `sleep_hours` | Decimal | Horas | Número de horas que el usuario durmió durante el periodo registrado. Se utiliza para estudiar duración del descanso y su relación con estado de ánimo, energía y riesgo. | 1.0 a 10.0 | Mayor que 0 | Ambos | Sueño |
| `healthy_meals_count` | Entero | Comidas | Cantidad de comidas consideradas saludables dentro del día. Representa de forma simplificada la calidad de la alimentación registrada por el usuario. | 0 a 5 | Entero no negativo | Ambos | Nutrición |
| `meditation_minutes` | Decimal | Minutos | Tiempo dedicado a meditación, respiración o actividades de relajación. Se utiliza como indicador de prácticas orientadas al manejo del estrés y bienestar emocional. | 0.0 a 49.0 | No negativo | Ambos | Bienestar emocional |

---

## 5. Síntomas y mediciones físicas

| Campo | Tipo lógico | Unidad | Descripción | Rango observado | Validación | Fuente | Uso |
|---|---|---:|---|---:|---|---|---|
| `pain` | Entero | Escala 0–10 | Nivel de dolor reportado en el registro. El valor 0 representa ausencia de dolor y 10 representa el nivel máximo dentro de la escala utilizada por el dataset. | 0 a 10 | Entero entre 0 y 10 | Ambos | Riesgo y síntomas |
| `temperature_c` | Decimal | °C | Temperatura corporal registrada en grados Celsius. Se utiliza como una medición física de apoyo para analizar cambios o posibles registros fuera del comportamiento habitual. | 35.4 a 38.4 | Admite nulos solo en raw | Ambos | Riesgo físico |
| `systolic_mmhg` | Entero | mmHg | Valor superior de la presión arterial, correspondiente a la presión generada cuando el corazón bombea sangre. Se utiliza como característica física dentro del análisis de riesgo. | 82 a 156 | Admite nulos solo en raw | Ambos | Riesgo físico |
| `diastolic_mmhg` | Entero | mmHg | Valor inferior de la presión arterial, asociado con la presión existente cuando el corazón se encuentra en reposo entre latidos. Complementa el valor sistólico. | 50 a 98 | Admite nulos solo en raw | Ambos | Riesgo físico |
| `glucose_mg_dl` | Entero | mg/dL | Cantidad de glucosa registrada en la sangre, expresada en miligramos por decilitro. Se utiliza como una variable física para analizar perfiles y factores de riesgo simulados. | 50 a 147 | Admite nulos solo en raw | Ambos | Riesgo físico |
| `heart_rate_bpm` | Entero | bpm | Número de latidos del corazón por minuto registrados en la observación. Ayuda a describir el estado físico del usuario y detectar valores atípicos dentro del dataset. | 44 a 155 | Admite nulos solo en raw | Ambos | Riesgo físico |

---

## 6. Estado emocional y percepción

| Campo | Tipo lógico | Unidad | Descripción | Rango o valores | Validación | Fuente | Uso |
|---|---|---:|---|---|---|---|---|
| `mood` | Categórico | N/A | Categoría seleccionada para representar cómo se sentía emocionalmente el usuario en el momento del registro. Permite analizar tendencias de estado de ánimo y relacionarlas con sueño, hábitos y estrés. | `Muy mal`, `Mal`, `Regular`, `Bien`, `Muy bien` | Solo valores permitidos; admite nulos en raw | Ambos | Análisis emocional |
| `stress_level` | Entero | Escala 1–10 | Nivel de estrés percibido por el usuario. Los valores bajos representan menor estrés y los valores altos representan una mayor sensación de tensión o presión. | 1 a 10 | Entero entre 1 y 10; admite nulos en raw | Ambos | Análisis emocional |
| `energy_level` | Entero | Escala 1–10 | Nivel de energía que el usuario percibe durante el día. Se utiliza para estudiar su relación con descanso, actividad física, alimentación y estado emocional. | 1 a 10 | Entero entre 1 y 10; admite nulos en raw | Ambos | Bienestar general |
| `sleep_quality` | Entero | Escala 1–10 | Valor subjetivo que representa qué tan reparador o satisfactorio fue el sueño. Complementa la duración registrada en `sleep_hours`, ya que dormir más tiempo no siempre significa descansar mejor. | 1 a 10 | Entero entre 1 y 10; admite nulos en raw | Ambos | Sueño y bienestar |

---

## 7. Indicadores calculados

| Campo | Tipo lógico | Unidad | Descripción | Rango observado | Validación | Fuente | Uso |
|---|---|---:|---|---:|---|---|---|
| `sleep_score` | Decimal | Puntos | Puntuación calculada para resumir el estado del sueño combinando variables relacionadas con duración y calidad del descanso. Un valor mayor representa mejores condiciones dentro de la lógica del dataset. | 0.00 a 99.49 | Entre 0 y 100 | Ambos | Indicador analítico |
| `activity_score` | Decimal | Puntos | Puntuación que resume el nivel de actividad física del usuario a partir de los minutos de ejercicio y otras reglas definidas durante la simulación. | 0.00 a 100.00 | Entre 0 y 100 | Ambos | Indicador analítico |
| `nutrition_score` | Decimal | Puntos | Valor calculado para representar la calidad general de los hábitos de alimentación e hidratación registrados en una observación. | 0.00 a 100.00 | Entre 0 y 100 | Ambos | Indicador analítico |
| `emotional_score` | Decimal | Puntos | Puntuación que resume el bienestar emocional considerando variables como estado de ánimo, estrés, energía y actividades de relajación. | 4.94 a 95.95 | Entre 0 y 100 | Ambos | Indicador analítico |
| `physical_condition_score` | Decimal | Puntos | Indicador calculado que resume diferentes mediciones relacionadas con la condición física del usuario, como IMC, presión arterial, glucosa y frecuencia cardiaca. | 62.20 a 100.00 | Entre 0 y 100 | Ambos | Indicador analítico |
| `wellbeing_score` | Decimal | Puntos | Puntuación general que integra diferentes áreas del bienestar, como sueño, actividad, nutrición, estado emocional y condición física. Puede utilizarse para comparar el estado global entre registros. | 15.14 a 99.82 | Entre 0 y 100 | Ambos | Posible variable objetivo |
| `risk_factors_count` | Entero | Conteo | Número total de condiciones o valores que fueron considerados factores de riesgo dentro de las reglas de generación del dataset. Un valor mayor indica más factores presentes en el registro. | 0 a 9 | Entero no negativo | Ambos | Clasificación de riesgo |

> Las fórmulas exactas de estos indicadores deben confirmarse con el script de simulación o transformación.

---

## 8. Etiquetas analíticas

| Campo | Tipo lógico | Descripción | Valores | Validación | Fuente | Uso |
|---|---|---|---|---|---|---|
| `risk_level` | Categórico ordinal | Clasificación general del nivel de riesgo asignado al registro a partir de los factores y puntuaciones generados. Se utiliza como etiqueta para entrenar o evaluar modelos de clasificación. | `low`, `medium`, `high` | Solo valores permitidos | Ambos | Variable objetivo de clasificación |
| `is_anomaly` | Booleano | Indicador que señala si el registro fue generado intencionalmente como un caso fuera del comportamiento habitual. Permite probar algoritmos de detección de anomalías. | `True`, `False` | Booleano obligatorio | Ambos | Evaluación de anomalías |

---

## 9. Valores faltantes del dataset raw

El dataset original contiene 150 valores faltantes en cada uno de los siguientes campos:

```text
weight_kg
temperature_c
systolic_mmhg
diastolic_mmhg
glucose_mg_dl
heart_rate_bpm
mood
stress_level
energy_level
sleep_quality
```

El dataset procesado no contiene valores nulos.

---

## 10. Clasificación de los datos

| Clasificación | Campos principales |
|---|---|
| **Identificadores** | `record_id`, `user_id` |
| **Temporales** | `log_date` |
| **Numéricos continuos** | Peso, estatura, IMC, agua, sueño, temperatura y puntuaciones |
| **Numéricos discretos** | Edad, comidas, dolor, presión, glucosa, frecuencia cardiaca y factores de riesgo |
| **Categóricos nominales** | `profile_type`, `weight_source` |
| **Categóricos ordinales** | `mood`, `risk_level`, escalas de estrés, energía y sueño |
| **Booleanos** | `is_anomaly` |
| **Datos sensibles simulados** | Perfil de salud, síntomas, signos físicos y estado emocional |

---

## 11. Reglas mínimas de calidad

- `record_id` debe ser único.
- `user_id` debe tener formato válido.
- `log_date` debe convertirse a fecha.
- El dataset procesado no debe contener nulos.
- `risk_level`, `profile_type`, `mood` y `weight_source` deben respetar sus categorías.
- `is_anomaly` debe ser booleano.
- `bmi` debe ser coherente con `weight_kg` y `height_cm`.
- `water_liters` debe ser coherente con `water_glasses`.
- Las escalas deben permanecer dentro de sus límites.
- La separación de entrenamiento y prueba debe evitar que registros del mismo usuario generen fuga de información.

---

## 12. Pendientes de confirmación

- Fórmulas exactas de los indicadores.
- Regla de generación de `risk_level`.
- Regla de generación de `is_anomaly`.
- Estrategia exacta de imputación de cada campo.
- Variables definitivas de entrada y salida para cada modelo.
