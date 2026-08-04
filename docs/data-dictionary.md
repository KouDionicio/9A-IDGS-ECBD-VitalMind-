# Diccionario de Datos — VitalMind AI

## 1. Propósito

Este documento define los atributos de `vitalmind_dataset_raw.csv` y `vitalmind_dataset_processed.csv`, incluyendo tipo, unidad, rango observado, procedencia, reglas de validación y uso analítico.

Los valores y rangos corresponden a datos sintéticos del proyecto. No representan rangos clínicos oficiales.

## 2. Resumen

| Archivo | Registros | Columnas | Nulos | Duplicados |
|---|---:|---:|---:|---:|
| `vitalmind_dataset_raw.csv` | 5,000 | 34 | 1,500 | 0 |
| `vitalmind_dataset_processed.csv` | 5,000 | 35 | 0 | 0 |

`weight_source` se agrega durante la preparación del archivo processed.

## 3. Atributos de identificación y tiempo

| Campo | Tipo / clasificación | Unidad | Descripción | Rango / valores | Fuente | Validación | Uso |
|---|---|---|---|---|---|---|---|
| `record_id` | Texto nominal | N/A | Identificador único de observación | `REC_000001` a `REC_005000` | Generador | Único y no nulo | Trazabilidad; no predictor |
| `user_id` | Texto nominal | N/A | Identificador de usuario sintético | 250 valores `USR_####` | Generador | No nulo; agrupación válida | Agrupar por usuario; no predictor |
| `log_date` | Fecha | día | Fecha de observación | 2026-04-01 a 2026-06-29 | Generador | Fecha válida; sin duplicar `user_id + log_date` | Orden y split temporal |

## 4. Perfil sintético

| Campo | Tipo / clasificación | Unidad | Descripción | Rango / valores | Fuente | Validación | Uso |
|---|---|---|---|---|---|---|---|
| `profile_type` | Categórico nominal | N/A | Perfil usado para controlar la simulación | `healthy`, `irregular`, `poor_habits`, `physically_vulnerable` | Generador | Catálogo cerrado | EDA de simulación; excluido del modelo |
| `age` | Entero discreto | años | Edad sintética estable por usuario | 18 a 74 | Generador | Positiva y estable por usuario | Predictor |
| `height_cm` | Decimal continuo | cm | Estatura sintética | 140.0 a 191.2 | Generador | Positiva y estable por usuario | Predictor y cálculo de BMI |
| `weight_profile_kg` | Decimal continuo | kg | Peso base del perfil | 40.0 a 134.4 | Generador | Positivo | Respaldo de limpieza; no predictor final |
| `weight_kg` | Decimal continuo | kg | Peso de la observación | 40.0 a 134.5 | Generador / ETL | Positivo; puede faltar en raw | Predictor |
| `bmi` | Decimal continuo | kg/m² | Índice calculado con peso y estatura | 16.16 a 44.33 | Derivado | Recalcular después de imputar peso | Predictor |
| `weight_source` | Categórico nominal | N/A | Procedencia del peso final | `symptom_log`, `profile_fallback` | ETL processed | Catálogo cerrado | Trazabilidad; no predictor |

## 5. Hábitos

| Campo | Tipo / clasificación | Unidad | Descripción | Rango observado | Fuente | Validación | Uso |
|---|---|---|---|---|---|---|---|
| `water_glasses` | Decimal continuo | vasos | Consumo diario simulado de agua | 0.0 a 14.25 | Generador | No negativo | Predictor |
| `water_liters` | Decimal continuo | L | Conversión de vasos a litros | 0.0 a 3.56 | Derivado | `water_glasses × 0.25` | EDA; excluido por redundancia |
| `exercise_minutes` | Decimal continuo | min | Minutos de actividad física | 0.0 a 111.0 | Generador | No negativo | Predictor |
| `sleep_hours` | Decimal continuo | h | Duración del sueño | 1.0 a 10.0 | Generador | Positiva | Predictor |
| `healthy_meals_count` | Entero discreto | conteo | Comidas saludables según la simulación | 0 a 5 | Generador | Entero no negativo | Predictor |
| `meditation_minutes` | Decimal continuo | min | Tiempo de meditación o relajación | 0.0 a 49.0 | Generador | No negativo | Predictor |

## 6. Síntomas y mediciones

| Campo | Tipo / clasificación | Unidad | Descripción | Rango observado | Fuente | Validación | Uso |
|---|---|---|---|---|---|---|---|
| `pain` | Entero ordinal | 0-10 | Intensidad de dolor sintética | 0 a 10 | Generador | Dentro de 0-10 | Predictor |
| `temperature_c` | Decimal continuo | °C | Temperatura corporal sintética | 35.4 a 38.4 | Generador / imputación | Numérico; faltante permitido en raw | Predictor |
| `systolic_mmhg` | Entero discreto | mmHg | Presión sistólica sintética | 82 a 156 | Generador / imputación | Mayor que diastólica después de limpieza | Predictor |
| `diastolic_mmhg` | Entero discreto | mmHg | Presión diastólica sintética | 50 a 98 | Generador / imputación | Menor que sistólica después de limpieza | Predictor |
| `glucose_mg_dl` | Entero discreto | mg/dL | Glucosa sintética | 50 a 147 | Generador / imputación | Numérico; faltante permitido en raw | Predictor |
| `heart_rate_bpm` | Entero discreto | bpm | Frecuencia cardiaca sintética | 44 a 155 | Generador / imputación | Numérico; faltante permitido en raw | Predictor |


## 7. Estado emocional y percepción

| Campo | Tipo / clasificación | Unidad / escala | Descripción | Valores | Fuente | Validación | Uso |
|---|---|---|---|---|---|---|---|
| `mood` | Categórico ordinal | 5 categorías | Estado de ánimo sintético | `Muy mal`, `Mal`, `Regular`, `Bien`, `Muy bien` | Generador / imputación | Catálogo válido | Predictor |
| `stress_level` | Entero ordinal | 1-10 | Nivel de estrés simulado | 1 a 10 | Generador / imputación | 1-10 | Predictor |
| `energy_level` | Entero ordinal | 1-10 | Nivel de energía simulado | 1 a 10 | Generador / imputación | 1-10 | Predictor |
| `sleep_quality` | Entero ordinal | 1-10 | Calidad percibida del sueño | 1 a 10 | Generador / imputación | 1-10 | Predictor |

Distribución de `mood` en processed:

| Valor | Registros |
|---|---:|
| `Muy mal` | 547 |
| `Mal` | 1,278 |
| `Regular` | 1,222 |
| `Bien` | 1,221 |
| `Muy bien` | 732 |

## 8. Indicadores derivados

| Campo | Tipo / clasificación | Unidad | Descripción | Rango observado | Fuente | Validación | Uso |
|---|---|---|---|---|---|---|---|
| `sleep_score` | Decimal continuo | 0-100 | Resumen sintético de duración y calidad del sueño | 0.00 a 99.49 | Fórmula del generador | 0-100 | EDA; excluido para evitar fuga |
| `activity_score` | Decimal continuo | 0-100 | Resumen de actividad | 0.00 a 100.00 | Fórmula del generador | 0-100 | EDA; excluido para evitar fuga |
| `nutrition_score` | Decimal continuo | 0-100 | Hidratación y comidas saludables | 0.00 a 100.00 | Fórmula del generador | 0-100 | EDA; excluido para evitar fuga |
| `emotional_score` | Decimal continuo | 0-100 | Resumen de ánimo, energía, estrés y sueño | 4.94 a 95.95 | Fórmula del generador | 0-100 | EDA; excluido para evitar fuga |
| `physical_condition_score` | Decimal continuo | 0-100 | Resumen de dolor y mediciones físicas | 62.20 a 100.00 | Fórmula del generador | 0-100 | EDA; excluido para evitar fuga |
| `wellbeing_score` | Decimal continuo | 0-100 | Objetivo sintético de bienestar | 15.14 a 99.82 | Fórmula del generador | 0-100 | Objetivo de regresión |
| `risk_factors_count` | Entero discreto | conteo | Número de reglas desfavorables activas | 0 a 9 | Fórmula del generador | Entero no negativo | Construcción de etiqueta; excluido como predictor |

## 9. Etiquetas analíticas

| Campo | Tipo / clasificación | Valores | Descripción | Fuente | Validación | Uso |
|---|---|---|---|---|---|---|
| `risk_level` | Categórico ordinal | `low`, `medium`, `high` | Etiqueta sintética de clasificación | Generador | Catálogo cerrado | Objetivo de clasificación |
| `is_anomaly` | Booleano | `True`, `False` | Marca alteraciones controladas de simulación | Generador | Booleano | Evaluación exploratoria; excluido del clasificador |

Distribución de riesgo:

| Nivel | Registros | Porcentaje |
|---|---:|---:|
| `low` | 1,849 | 36.98 % |
| `medium` | 1,970 | 39.40 % |
| `high` | 1,181 | 23.62 % |

## 10. Fórmulas principales

### 10.1 BMI

```text
bmi = weight_kg / (height_cm / 100)²
```

### 10.2 Agua

```text
water_liters = water_glasses × 0.25
```

### 10.3 Sueño

```text
sleep_hours_score = clip(100 - abs(sleep_hours - 8) × 20, 0, 100)

sleep_score =
    0.60 × sleep_hours_score
  + 0.40 × normalize_1_to_10(sleep_quality)
```

### 10.4 Actividad

```text
activity_score = min(exercise_minutes / 60, 1) × 100
```

### 10.5 Nutrición

```text
nutrition_score =
    0.55 × water_score
  + 0.45 × meals_score
```

Las referencias internas del generador no constituyen indicaciones de salud.

### 10.6 Bienestar

```text
wellbeing_score =
    0.25 × sleep_score
  + 0.20 × activity_score
  + 0.15 × nutrition_score
  + 0.25 × emotional_score
  + 0.15 × physical_condition_score
  + ruido_uniforme(-5, 5)
```

## 11. Regla de `risk_factors_count`

Se cuentan condiciones como sueño bajo, poca actividad, hidratación baja, estrés alto, energía baja, dolor alto, cambios de frecuencia cardiaca, temperatura elevada y estados de ánimo desfavorables según reglas del generador.

Las reglas completas se conservan en `simulation-rules.md`.

## 12. Regla de `risk_level`

Base:

```text
wellbeing_score < 45        -> high
45 <= wellbeing_score < 70 -> medium
wellbeing_score >= 70       -> low
```

Ajustes:

- 5 o más factores fuerzan `high`;
- 3 o más factores convierten `low` en `medium`;
- una anomalía sintética convierte `low` en `medium`;
- cerca de 45 y 70 existe 8 % de cambio controlado de clase.

## 13. Valores faltantes

En raw, cada uno de estos campos tiene 150 nulos:

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

Total: 1,500 celdas nulas.

## 14. Tratamiento en processed

- `weight_kg`: `weight_profile_kg` como respaldo.
- Numéricos opcionales: mediana por usuario y, si no existe, mediana global.
- `mood`: moda por usuario y luego global.
- Recálculo de `water_liters` y `bmi`.
- Registro de `weight_source`.

Para entrenamiento final se aplica un procedimiento distinto: primero se divide temporalmente y después se aprenden estadísticas de imputación únicamente con entrenamiento.

## 15. Características finales de los modelos supervisados

```text
age
height_cm
weight_kg
bmi
water_glasses
exercise_minutes
sleep_hours
healthy_meals_count
meditation_minutes
pain
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


## 16. Variables del modelo K-Means

El clustering agrega registros por usuario y utiliza 20 características:

```text
age
height_cm
weight_kg
bmi
water_glasses_mean
exercise_minutes_mean
sleep_hours_mean
healthy_meals_count_mean
meditation_minutes_mean
pain_mean
temperature_c_mean
systolic_mmhg_mean
diastolic_mmhg_mean
glucose_mg_dl_mean
heart_rate_bpm_mean
stress_level_mean
energy_level_mean
sleep_quality_mean
mood_score_mean
records_count
```

## 17. Reglas mínimas de calidad

- `record_id` único.
- Una observación por `user_id + log_date`.
- Fecha válida.
- Tipos convertibles.
- Categorías dentro de catálogo.
- Puntajes derivados dentro de 0-100.
- Presión sistólica mayor que diastólica tras la preparación.
- Coherencia entre peso, estatura y BMI.
- Coherencia entre vasos y litros.
- Sin variables de fuga en el pipeline.
- Estadísticas de imputación aprendidas solo con entrenamiento para evaluación final.

