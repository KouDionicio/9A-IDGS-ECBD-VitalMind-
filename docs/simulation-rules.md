# Reglas de Simulación — VitalMind AI

## 1. Propósito

Este documento describe la generación del dataset sintético utilizado en VitalMind AI. La simulación busca producir datos coherentes para practicar validación, ETL, EDA, entrenamiento, evaluación e inferencia.


## 2. Configuración general

| Parámetro | Valor |
|---|---:|
| Semilla | 2026 |
| Usuarios sintéticos | 250 |
| Registros | 5,000 |
| Periodo | 90 días |
| Fecha inicial | 2026-04-01 |
| Fecha final observada | 2026-06-29 |
| Registros por usuario | 10 a 30 |
| Faltantes por campo seleccionado | 3 % |
| Anomalías sintéticas | 3 % |

La semilla permite reproducir el comportamiento siempre que se mantengan el script y dependencias.

## 3. Diseño de la simulación

La simulación no asigna valores totalmente al azar. Primero crea perfiles base y después genera observaciones con variación diaria alrededor de parámetros definidos.

Se contemplan:

- casos normales;
- variación diaria;
- casos desfavorables;
- valores faltantes;
- anomalías controladas;
- ruido en objetivos;
- casos cercanos a umbrales.

## 4. Perfiles

| Perfil | Proporción configurada | Sueño medio | Ejercicio medio | Agua | Comidas | Meditación | Estrés | Energía | Calidad sueño | Dolor |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| `healthy` | 0.35 | 7.8 h | 45 min | 8 vasos | 3 | 15 min | 3.5 | 7.5 | 8 | 1.5 |
| `irregular` | 0.30 | 6.5 h | 25 min | 6 vasos | 2 | 7 min | 5.5 | 5.5 | 6 | 3.0 |
| `poor_habits` | 0.23 | 5.3 h | 8 min | 3.5 vasos | 1 | 2 min | 7.5 | 3.5 | 4 | 4.5 |
| `physically_vulnerable` | 0.12 | 6.0 h | 12 min | 5 vasos | 2 | 5 min | 6.5 | 4.5 | 5 | 6.0 |

Los perfiles controlan la generación y no se utilizan como categorías del producto.

## 5. Variables de perfil

Por usuario:

```text
age
height_cm
weight_profile_kg
profile_type
```

Edad y estatura se mantienen estables. El peso diario puede variar.

## 6. Relaciones entre variables

La simulación incorpora relaciones deliberadas. Por ejemplo:

- mayor estrés tiende a relacionarse con menor energía;
- menor calidad de sueño afecta el estado emocional;
- dolor influye en el estado de ánimo;
- hábitos y percepción participan en `wellbeing_score`;
- `wellbeing_score` y factores de riesgo intervienen en `risk_level`.

Estas relaciones permiten construir un problema de aprendizaje no trivial, aunque siguen siendo relaciones artificiales.

## 7. Estado de ánimo

Puntuación latente:

```text
0.35 × energía
+ 0.25 × calidad de sueño
+ 0.30 × inverso del estrés
+ 0.10 × inverso del dolor
+ ruido normal
```

Categorías:

| Puntuación | Estado |
|---|---|
| `>= 8.2` | `Muy bien` |
| `>= 6.5` | `Bien` |
| `>= 4.8` | `Regular` |
| `>= 3.2` | `Mal` |
| `< 3.2` | `Muy mal` |

## 8. Indicadores derivados

### 8.1 Sueño

```text
sleep_hours_score = clip(100 - abs(sleep_hours - 8) × 20, 0, 100)

sleep_score =
    0.60 × sleep_hours_score
  + 0.40 × normalize_1_to_10(sleep_quality)
```

### 8.2 Actividad

```text
activity_score = min(exercise_minutes / 60, 1) × 100
```



### 8.3 Nutrición

```text
water_score =
    si water_glasses <= 8:
        water_glasses / 8 × 100
    en otro caso:
        100 - (water_glasses - 8) × 5

meal_score = min(healthy_meals_count / 3, 1) × 100

nutrition_score =
    0.55 × water_score
  + 0.45 × meal_score
```

### 8.4 Estado emocional

```text
Muy mal = 10
Mal = 30
Regular = 50
Bien = 75
Muy bien = 95
```

```text
emotional_score =
    0.30 × mood_score
  + 0.25 × energy_score
  + 0.25 × inverse_stress_score
  + 0.20 × sleep_quality_score
```

### 8.5 Condición física

```text
physical_condition_score =
    0.30 × inverse_pain_score
  + 0.20 × temperature_score
  + 0.20 × heart_rate_score
  + 0.20 × blood_pressure_score
  + 0.10 × glucose_score
```

### 8.6 Bienestar

```text
wellbeing_score =
    0.25 × sleep_score
  + 0.20 × activity_score
  + 0.15 × nutrition_score
  + 0.25 × emotional_score
  + 0.15 × physical_condition_score
  + ruido_uniforme(-5, 5)
```

El resultado se limita a 0-100.

## 9. Factores de riesgo

`risk_factors_count` cuenta:

```text
sleep_hours < 5
exercise_minutes < 10
water_glasses < 4
healthy_meals_count == 0
stress_level >= 8
energy_level <= 3
sleep_quality <= 3
pain >= 7
heart_rate_bpm < 45
heart_rate_bpm > 130
temperature_c >= 38
mood in {"Mal", "Muy mal"}
```

El máximo observado es 9.

## 10. Etiqueta supervisada `risk_level`

Regla base:

```text
wellbeing_score < 45        -> high
45 <= wellbeing_score < 70 -> medium
wellbeing_score >= 70       -> low
```

Ajustes:

- 5 o más factores fuerzan `high`;
- 3 o más factores convierten `low` en `medium`;
- una anomalía sintética convierte `low` en `medium`;
- cerca de 45 y 70 existe un 8 % de cambio controlado.

La perturbación en casos frontera evita una separación completamente determinista.

## 11. Anomalías y eventos especiales

Se altera aproximadamente 3 % de los registros.

Tipos:

```text
sleep_drop
stress_increase
exercise_drop
pain_increase
heart_rate_change
combined_deterioration
```

Después de modificar una observación se recalculan los indicadores dependientes.

`is_anomaly` identifica eventos introducidos por el simulador. No significa que un registro real similar sea médicamente anormal.

## 12. Valores faltantes

Se introduce 3 % de faltantes en:

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

Resultado observado:

```text
150 nulos por campo
1,500 celdas nulas
```

## 13. Casos normales, extremos y frontera

### 13.1 Normales

Observaciones cercanas a los parámetros del perfil.

### 13.2 Extremos controlados

Se obtienen por variación, anomalías y límites establecidos por el generador. Los valores extremos siguen perteneciendo al espacio sintético del proyecto.

### 13.3 Frontera

Los valores de bienestar cercanos a 45 y 70 reciben ruido controlado en la etiqueta. Estos registros son útiles para evitar una frontera de clasificación perfecta.

## 14. Distribuciones resultantes

Perfiles:

| Perfil | Registros |
|---|---:|
| `healthy` | 1,776 |
| `poor_habits` | 1,280 |
| `irregular` | 1,229 |
| `physically_vulnerable` | 715 |

Riesgo:

| Nivel | Registros |
|---|---:|
| `low` | 1,849 |
| `medium` | 1,970 |
| `high` | 1,181 |

Anomalías:

```text
True: 150
False: 4,850
```

## 15. Reproducibilidad

Para reproducir el dataset se deben conservar:

- semilla 2026;
- versión de `generate_dataset.py`;
- dependencias;
- cantidad de usuarios;
- cantidad de registros;
- fechas;
- reglas de perfiles;
- reglas de indicadores;
- porcentaje de faltantes;
- porcentaje de anomalías.

Cambiar cualquiera de estos elementos puede modificar el resultado.


## 16. Limitaciones

- perfiles artificiales;
- relaciones definidas por reglas;
- objetivos sintéticos;
- ausencia de estacionalidad real;
- ausencia de validación clínica;


## 17. Conclusión

La simulación combina perfiles, variación, faltantes, anomalías, para producir un conjunto reproducible. Las reglas son suficientemente explícitas para defender el origen del dataset, pero no deben trasladarse a decisiones médicas.
