# Evaluación de Modelos — VitalMind AI

## 1. Propósito

Este documento presenta la comparación, ajuste, evaluación y selección de los mecanismos de Machine Learning desarrollados para VitalMind AI.

Todos los resultados provienen de datos sintéticos. Las métricas describen desempeño técnico dentro del ejercicio académico y no representan validación clínica.

## 2. Preparación para evaluación

Se utiliza una separación temporal:

| Conjunto | Periodo | Registros |
|---|---|---:|
| Entrenamiento | 2026-07-26 a 2026-08-07 | 3,418 |
| Validación | 2026-06-29 a 2026-08-08 | 731 |
| Prueba | 2026-07-31 a 2026-09-12 | 851 |

Las estadísticas de imputación se calculan únicamente con entrenamiento.

Características supervisadas:

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

Se excluyen identificadores, variables de simulación, objetivos cruzados y puntajes derivados.

## 3. Clasificación supervisada

### 3.1 Problema

Objetivo:

```text
risk_level
```

Clases:

```text
high
low
medium
```

### 3.2 Comparación inicial

Resultados de validación disponibles:

| Modelo | Accuracy | F1 macro | ROC-AUC ponderado |
|---|---:|---:|---:|
| Regresión Logística | 0.8933 | 0.8933 | 0.9771 |
| Random Forest | 0.8824 | 0.8825 | 0.9701 |

La Regresión Logística mostró mejor desempeño general y una estructura más simple para integración e interpretación.

### 3.3 Comparación con preparación segura

En la comparación que utiliza el flujo temporal y preparación segura:

| Modelo | Accuracy | F1 macro | ROC-AUC ponderado |
|---|---:|---:|---:|
| Regresión Logística | 0.8865 | 0.8865 | 0.9767 |
| Random Forest | 0.8782 | 0.8781 | 0.9709 |

La tendencia de selección se mantiene.

### 3.4 Ajuste de hiperparámetros

El modelo seleccionado se ajustó sobre validación. La configuración final es:

```text
C = 10.0
class_weight = balanced
solver = lbfgs
```

Métricas de validación de la configuración segura:

| Métrica | Resultado |
|---|---:|
| Accuracy | 0.8892 |
| F1 macro | 0.8890 |
| ROC-AUC ponderado | 0.9765 |
| Precision `high` | 0.8497 |
| Recall `high` | 0.9011 |
| F1 `high` | 0.8747 |

### 3.5 Evaluación final en prueba

Sobre 851 registros:

| Métrica | Resultado |
|---|---:|
| Accuracy | 0.9048 |
| Precision ponderada | 0.9052 |
| Recall ponderado | 0.9048 |
| F1 ponderado | 0.9049 |
| Precision macro | 0.9017 |
| Recall macro | 0.9059 |
| F1 macro | 0.9037 |
| ROC-AUC ponderado | 0.9804 |
| ROC-AUC macro | 0.9808 |

Clase `high`:

| Métrica | Resultado |
|---|---:|
| Precision | 0.8750 |
| Recall | 0.9130 |
| F1 | 0.8936 |

### 3.6 Matriz de confusión

Orden:

```text
high
low
medium
```

```text
               Pred. high   Pred. low   Pred. medium
Real high           189          0            18
Real low              0        300            20
Real medium          27         16           281
```

## 4. Regresión supervisada

### 4.1 Problema

Objetivo:

```text
wellbeing_score
```

### 4.2 Comparación inicial

| Modelo | MAE | RMSE | R² |
|---|---:|---:|---:|
| Ridge Regression | 2.8878 | 3.5190 | 0.9644 |
| Random Forest Regressor | 3.0494 | 3.7504 | 0.9596 |
| Dummy Regressor | 16.1651 | 18.6662 | -0.0011 |

Ridge obtuvo el menor error y el mayor R² entre las alternativas comparadas.

### 4.3 Ajuste

Configuración seleccionada:

```text
alpha = 10.0
```

Validación:

| Métrica | Resultado |
|---|---:|
| MAE | 2.8873 |
| RMSE | 3.5172 |
| R² | 0.9645 |
| Error absoluto mediano | 2.6660 |

### 4.4 Evaluación final

| Métrica | Resultado |
|---|---:|
| MAE | 3.1230 |
| RMSE | 3.8266 |
| R² | 0.9584 |
| Error absoluto mediano | 2.7044 |

El rango bruto de predicción observado llegó aproximadamente a 103.88; la capa de inferencia limita el valor devuelto a 0-100.

## 5. Agrupamiento no supervisado

### 5.1 Datos

K-Means utiliza perfiles agregados por usuario a partir de entrenamiento. Se excluyen:

```text
risk_level
wellbeing_score
profile_type
is_anomaly
risk_factors_count
```

### 5.2 Selección de número de clusters

| k | Silhouette | Davies-Bouldin | Calinski-Harabasz | Inercia |
|---:|---:|---:|---:|---:|
| 2 | 0.3615 | 1.0408 | 184.4039 | 2867.6892 |
| 3 | 0.2419 | 1.6982 | 131.5282 | 2421.3006 |
| 4 | 0.2293 | 1.7312 | 103.6715 | 2208.2007 |
| 5 | 0.2175 | 1.7212 | 85.6610 | 2084.5951 |
| 6 | 0.1528 | 1.9586 | 74.9596 | 1971.5649 |

Se seleccionó `k = 2` porque obtiene el mayor Silhouette y el menor Davies-Bouldin dentro de las opciones evaluadas.

Tamaños:

```text
Cluster 0: 160 usuarios
Cluster 1: 90 usuarios
```

### 5.3 Interpretación de clusters

Los reportes describen:

- un grupo con estrés y dolor relativamente más altos y valores menores de actividad, sueño, alimentación, energía y calidad del sueño;
- un grupo con el patrón relativo contrario.

Estas descripciones son estadísticas. Los identificadores de cluster no tienen significado ordinal ni médico.

## 6. Reducción de dimensionalidad

PCA se utiliza como apoyo para representar los perfiles de clustering en dos dimensiones.

```text
Varianza explicada por PCA 2D = 0.6558
```

Esto equivale aproximadamente a 65.58 % de la varianza de las características estandarizadas utilizadas en esa representación.

PCA cumple una función de visualización e interpretación; no sustituye el modelo K-Means.

## 7. Detección de anomalías

Isolation Forest utiliza:

```text
contamination = 0.03
```

En 3,418 registros de entrenamiento:

| Elemento | Resultado |
|---|---:|
| Anomalías detectadas | 103 |
| Proporción | 3.01 % |

Comparación con `is_anomaly`:

| Métrica | Resultado |
|---|---:|
| Accuracy | 0.9491 |
| Precision | 0.1262 |
| Recall | 0.1340 |
| F1 | 0.1300 |
| Verdaderos positivos | 13 |
| Verdaderos negativos | 3,231 |
| Falsos positivos | 90 |
| Falsos negativos | 84 |

La accuracy resulta alta por el predominio de registros normales. El F1 bajo muestra que la anomalía estadística detectada no coincide con la regla externa utilizada para alterar datos.

## 8. Selección de mecanismos para API

La guía solicita dos mecanismos:

### 8.1 Supervisado

**Regresión Logística de riesgo.**

Criterios:

- mejor desempeño que Random Forest en validación;
- buen F1 macro;
- recall alto para `high`;
- salida probabilística;
- facilidad de integración;
- artefacto serializado;
- endpoint disponible.

Estado:

```text
Seleccionado e integrado
```

### 8.2 No supervisado

**K-Means de perfiles de bienestar.**

Criterios:

- comparación de diferentes valores de `k`;
- mejor Silhouette con `k = 2`;
- modelo serializado;
- perfiles descriptivos disponibles;
- PCA complementario para visualización;
- salida comprensible como cluster.

Estado:

```text
Seleccionado, pero sin endpoint no supervisado implementado
```

## 9. Artefactos serializados

```text
app/models/risk-classification/best_risk_classifier_safe.joblib
app/models/wellbeing-regression/best_wellbeing_regressor.joblib
app/models/wellbeing-clustering/wellbeing_kmeans_pipeline.joblib
app/models/anomaly-detection/isolation_forest_pipeline.joblib
```

## 10. Integración

El ML Service expone actualmente:

```http
POST /api/v1/analyze
```

La respuesta contiene clasificación de riesgo, bienestar, BMI, recomendaciones, versiones de modelo y reporte de faltantes.



## 11. Riesgos de interpretación

- `risk_level` es una etiqueta sintética.
- `wellbeing_score` deriva de una fórmula sintética.
- El alto R² refleja en parte relaciones incorporadas por el generador.
- Los clusters no son categorías médicas.
- PCA simplifica información y no conserva el 100 % de la varianza.
- Isolation Forest no reproduce bien la etiqueta sintética de anomalía.
- El desempeño puede cambiar con mediciones reales de Wear OS.


## 12. Conclusión

La evaluación disponible respalda la selección de Regresión Logística para el mecanismo supervisado y K-Means para el mecanismo no supervisado. Ridge Regression se conserva como componente adicional de estimación de bienestar. 