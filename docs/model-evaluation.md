<div align="center">

# 🤖 Evaluación de Modelos — VitalMind AI

<img src="https://img.shields.io/badge/Estado-Evaluación%20parcial-F59E0B?style=for-the-badge" alt="Estado">
<img src="https://img.shields.io/badge/Problema-Clasificación%20multiclase-2563EB?style=for-the-badge" alt="Problema">
<img src="https://img.shields.io/badge/Seleccionado-Regresión%20Logística-0F766E?style=for-the-badge" alt="Modelo Seleccionado">

</div>

## 1. Propósito

Este documento resume el análisis exploratorio y la comparación de modelos desarrollados para clasificar el nivel preventivo de riesgo en VitalMind AI.

La evaluación se basa en:

```text
ml-service/app/notebooks/
├── 01_exploratory_data_analysis.ipynb
└── 02_risk_model_comparison.ipynb
```


---

## 2. Estado actual

| Elemento | Estado |
|---|---|
| Análisis exploratorio | Completado |
| Clasificación supervisada de riesgo | Evaluada en validación |
| Ajuste de hiperparámetros | Completado |
| Flujo temporal seguro | Seleccionado |
| Evaluación final en prueba | Pendiente |
| Modelo de regresión | Pendiente |
| Modelo no supervisado | Pendiente |
| Integración con API | Pendiente |

---

## 3. Dataset evaluado

| Característica | Resultado |
|---|---:|
| Registros | 5,000 |
| Usuarios sintéticos | 250 |
| Columnas | 35 |
| Valores faltantes | 0 |
| Filas duplicadas | 0 |
| Duplicados por usuario y fecha | 0 |
| Periodo | 2026-04-01 a 2026-06-29 |
| Anomalías sintéticas | 3 % |

### Distribución de la variable objetivo

| Nivel de riesgo | Registros | Porcentaje |
|---|---:|---:|
| `low` | 1,849 | 36.98 % |
| `medium` | 1,970 | 39.40 % |
| `high` | 1,181 | 23.62 % |

La distribución permite iniciar el entrenamiento sin un desbalance extremo, aunque la clase `high` tiene menor representación.

---

## 4. Problema de Machine Learning

| Elemento | Definición |
|---|---|
| Tipo | Clasificación supervisada multiclase |
| Variable objetivo | `risk_level` |
| Clases | `low`, `medium`, `high` |
| Objetivo | Clasificar el nivel preventivo de riesgo a partir de hábitos, síntomas, signos físicos y variables emocionales |
| Prioridad de evaluación | Mantener buen desempeño general y detectar correctamente la clase `high` |

---

## 5. Variables utilizadas

El clasificador utiliza 19 variables disponibles o previstas en Backend:

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

### Variables excluidas

Se excluyeron campos que podían causar fuga de información, duplicidad o dependencia de reglas internas de simulación:

```text
record_id
user_id
log_date
profile_type
is_anomaly
risk_factors_count
wellbeing_score
sleep_score
activity_score
nutrition_score
emotional_score
physical_condition_score
water_liters
weight_profile_kg
```

---

## 6. Hallazgos del análisis exploratorio

Los registros de riesgo alto presentan, en promedio:

- Menos horas de sueño.
- Menor actividad física.
- Menor consumo de agua.
- Menos comidas saludables.
- Menor tiempo de meditación.
- Mayor estrés.
- Menor energía.
- Menor calidad del sueño.
- Mayor dolor.
- Menor puntuación general de bienestar.

También se identificaron relaciones fuertes entre algunas variables:

| Variables | Correlación |
|---|---:|
| `weight_kg` y `bmi` | 0.87 |
| `stress_level` y `energy_level` | -0.85 |
| `energy_level` y `sleep_quality` | 0.75 |
| `pain` y `energy_level` | -0.73 |
| `pain` y `stress_level` | 0.73 |
| `sleep_hours` y `stress_level` | -0.73 |

Estas relaciones se revisaron para evitar redundancia y mejorar la interpretación.

---

## 7. Modelos comparados

Se evaluaron dos algoritmos:

1. Regresión Logística.
2. Random Forest Classifier.

Las métricas utilizadas fueron:

- Accuracy.
- Precision ponderada.
- Recall ponderado.
- F1 ponderado.
- F1 macro.
- ROC-AUC multiclase.
- Recall y F1 de la clase `high`.
- Matriz de confusión.

La selección no se realizó únicamente con Accuracy.

---

## 8. Comparación inicial

Resultados sobre el conjunto de validación con el flujo inicial:

| Modelo | Accuracy | F1 macro | ROC-AUC |
|---|---:|---:|---:|
| Regresión Logística | 0.8933 | 0.8933 | 0.9771 |
| Random Forest | 0.8824 | 0.8825 | 0.9701 |

### Desempeño inicial por clase

| Modelo | Clase | Precision | Recall | F1 |
|---|---|---:|---:|---:|
| Regresión Logística | `high` | 0.8549 | 0.9066 | 0.8800 |
| Regresión Logística | `low` | 0.9266 | 0.9449 | 0.9357 |
| Regresión Logística | `medium` | 0.8889 | 0.8407 | 0.8641 |
| Random Forest | `high` | 0.8446 | 0.8956 | 0.8693 |
| Random Forest | `low` | 0.9222 | 0.9331 | 0.9276 |
| Random Forest | `medium` | 0.8719 | 0.8305 | 0.8507 |

El análisis mostró que la clase `medium` concentra la mayor parte de las confusiones. No se observaron confusiones directas relevantes entre `high` y `low`.

---

## 9. Corrección del flujo de preparación

El flujo inicial utilizaba imputación global. Posteriormente se adoptó un flujo temporal seguro para impedir que las estadísticas de periodos futuros influyeran en la preparación de datos anteriores.

| Flujo | Modelo | Accuracy | F1 macro | Recall `high` | ROC-AUC |
|---|---|---:|---:|---:|---:|
| Imputación global inicial | Regresión Logística | 0.8933 | 0.8933 | 0.9066 | 0.9771 |
| Imputación temporal segura | Regresión Logística | 0.8892 | 0.8890 | 0.9011 | 0.9765 |

La reducción fue menor al 1 % en las métricas comparadas. Se acepta porque el flujo temporal ofrece una evaluación más realista y reduce el riesgo de fuga de información.

---

## 10. Ajuste de hiperparámetros

En el flujo temporal seguro se evaluaron 338 configuraciones.

### Mejores resultados por algoritmo

| Modelo | Accuracy | F1 macro | Recall `high` | F1 `high` | ROC-AUC |
|---|---:|---:|---:|---:|---:|
| Regresión Logística | 0.8892 | 0.8890 | 0.9011 | 0.8747 | 0.9765 |
| Random Forest | 0.8878 | 0.8881 | 0.9231 | 0.8773 | 0.9697 |

Random Forest logró un Recall ligeramente mayor para la clase `high`, pero la Regresión Logística obtuvo mejor F1 macro y ROC-AUC.

---

## 11. Modelo seleccionado

El modelo seleccionado para la evaluación final es:

| Parámetro | Valor |
|---|---|
| Algoritmo | Regresión Logística |
| `C` | 10.0 |
| `class_weight` | `balanced` |
| `solver` | `lbfgs` |
| Accuracy de validación | 0.8892 |
| F1 macro de validación | 0.8890 |
| Recall de clase `high` | 0.9011 |
| F1 de clase `high` | 0.8747 |
| ROC-AUC multiclase | 0.9765 |

### Justificación

Se seleccionó porque:

- Presenta desempeño equilibrado entre las tres clases.
- Mantiene Recall superior al 90 % para `high`.
- Obtiene el mejor F1 macro.
- Obtiene el mejor ROC-AUC entre las configuraciones finales.
- Es más interpretable que Random Forest.
- Puede integrarse en un pipeline reproducible.
- Utiliza un flujo temporalmente seguro.


---

## 12. Evaluación final pendiente

El conjunto de prueba no fue utilizado en los notebooks proporcionados.

La evaluación final deberá:

1. Cargar el pipeline temporal seguro seleccionado.
2. Mantener los hiperparámetros sin cambios.
3. Ejecutar una sola evaluación sobre prueba.
4. Calcular métricas globales y por clase.
5. Generar la matriz de confusión final.
6. Guardar las predicciones.
7. Registrar la versión del modelo.
8. Confirmar el tiempo de inferencia.



---

## 13. Limitaciones

- Los datos son sintéticos.
- Las etiquetas fueron generadas mediante reglas.
- Los resultados no representan evidencia clínica.
- El rendimiento puede cambiar con datos reales.
- Todavía no se documenta una evaluación final de prueba.
- No se proporcionaron resultados de regresión.
- No se proporcionaron resultados de aprendizaje no supervisado.
- La integración con la API inteligente permanece pendiente.

---

## 14. Conclusión

La Regresión Logística con preparación temporal segura es el mejor candidato actual para clasificar el nivel preventivo de riesgo.

Su selección se basa en el equilibrio entre F1 macro, Recall de la clase `high`, ROC-AUC, interpretabilidad y control de fuga de información.

El modelo todavía debe evaluarse una sola vez sobre el conjunto de prueba antes de considerarse la versión final para integración.
