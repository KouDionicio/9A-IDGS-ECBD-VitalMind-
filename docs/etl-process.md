# Proceso ETL y Preparación de Datos — VitalMind AI

## 1. Propósito

Este documento describe el proceso reproducible utilizado para extraer, validar, transformar y cargar los datos sintéticos de VitalMind AI. También diferencia la preparación general del archivo processed de la preparación segura utilizada para entrenamiento y evaluación.

## 2. Flujo ETL

```mermaidCon base en todos los archivos, documentación y guía que ya analizaste del proyecto **VitalMind AI**, crea una presentación universitaria completa, profesional y visualmente atractiva para exponer el proyecto.


El proyecto consiste en una aplicación de monitoreo de salud conectada con smartwatch, dirigida a usuarios generales. Permite recopilar, registrar, consultar y analizar datos como frecuencia cardiaca, presión arterial cuando exista una fuente compatible, oxigenación, actividad, sueño, hábitos y medicamentos. La aplicación no realiza diagnósticos médicos; los resultados de IA son preventivos e informativos.

Información técnica confirmada:

* Smartwatch con **Wear OS**.
* Aplicación desarrollada con **Kotlin**.
* Desarrollo realizado en **Android Studio**.
* Sincronización entre smartwatch y aplicación mediante **Bluetooth**.
* Backend y microservicio de Inteligencia Artificial desarrollados con **FastAPI**.
* Base de datos utilizada por el proyecto según la documentación analizada.
* Chatbot integrado con **Mistral AI**, modelo `mistral-small-latest`.
* Los modelos fueron entrenados y evaluados con datos sintéticos.

```

## 3. Scripts identificados

| Script | Función |
|---|---|
| `scripts/generate_dataset.py` | Generar el dataset sintético |
| `scripts/validate_dataset.py` | Validar estructura, rangos y consistencia |
| `scripts/clean_dataset.py` | Producir el archivo processed |
| `scripts/split_dataset.py` | Generar divisiones de datos |
| `scripts/prepare_temporal_model_data.py` | Preparar train, validation y test sin fuga temporal |
| `scripts/train_risk_classifier.py` | Entrenar modelos de clasificación |
| `scripts/tune_risk_classifier.py` | Ajustar hiperparámetros |
| `scripts/train_wellbeing_regressor.py` | Entrenar regresores |
| `scripts/tune_wellbeing_regressor.py` | Ajustar hiperparámetros |
| `scripts/train_wellbeing_clusters.py` | Entrenar K-Means y generar PCA |
| `scripts/train_anomaly_detector.py` | Entrenar Isolation Forest |

## 4. Extracción

### 4.1 Fuente principal

```text
vitalmind_dataset_raw.csv
```

Características:

- 5,000 registros;
- 34 columnas;
- 250 usuarios sintéticos;
- fechas entre 2026-04-01 y 2026-06-29;
- 1,500 celdas nulas;
- 0 duplicados de fila;
- 150 anomalías sintéticas.

### 4.2 Registro de extracción

| Elemento | Valor |
|---|---|
| Fuente | Generador sintético del proyecto |
| Formato | CSV |
| Registros | 5,000 |
| Fecha mínima | 2026-04-01 |
| Fecha máxima | 2026-06-29 |
| Problemas previstos | Nulos controlados y anomalías controladas |
| Datos personales reales | No |


## 5. Transformación general

### 5.1 Validación estructural

Se comprueba:

- encabezados;
- tipos convertibles;
- `record_id` único;
- combinación `user_id + log_date` sin duplicados;
- fecha válida;
- categorías conocidas;
- volumen de registros.

### 5.2 Peso y trazabilidad

Si `weight_kg` existe:

```text
weight_source = symptom_log
```

Si falta:

```text
weight_kg = weight_profile_kg
weight_source = profile_fallback
```

Resultado:

| Fuente | Registros |
|---|---:|
| `symptom_log` | 4,850 |
| `profile_fallback` | 150 |

### 5.3 Variables numéricas con faltantes

En la preparación general se utiliza:

1. mediana del usuario;
2. si no existe, mediana global.

Campos:

```text
temperature_c
systolic_mmhg
diastolic_mmhg
glucose_mg_dl
heart_rate_bpm
stress_level
energy_level
sleep_quality
```

### 5.4 Estado de ánimo

`mood` se completa con moda por usuario y luego moda global.

### 5.5 Ingeniería de características

Se recalculan:

```text
water_liters = water_glasses × 0.25
bmi = weight_kg / (height_cm / 100)²
```

## 6. Carga general

La salida se guarda como:

```text
data/processed/vitalmind_dataset_processed.csv
```

Resultado:

- 5,000 registros;
- 35 columnas;
- 0 nulos;
- 0 duplicados.



## 7. Bitácora de transformaciones

| Paso | Entrada | Transformación | Salida | Control |
|---|---|---|---|---|
| 1 | Raw CSV | Validación de estructura | Dataset validado | Conteos y duplicados |
| 2 | Dataset validado | Conversión de tipos | Datos tipados | Errores de conversión |
| 3 | Peso faltante | Respaldo con perfil | `weight_kg` completo | `weight_source` |
| 4 | Numéricos faltantes | Mediana usuario/global | Numéricos completos | Conteo de nulos |
| 5 | `mood` faltante | Moda usuario/global | Categoría completa | Catálogo |
| 6 | Campos base | Cálculo de BMI y agua | Derivados coherentes | Fórmulas |
| 7 | Processed | Validación final | CSV procesado | 5,000 filas, 0 nulos |
| 8 | Raw | Split temporal | Train/validation/test | Fechas no mezcladas |
| 9 | Train | Estadísticas de imputación | Metadatos | Solo entrenamiento |
| 10 | Conjuntos | Pipeline consistente | Datos de modelado | Sin fuga |

## 8. Calidad antes y después

| Control | Raw | Processed |
|---|---:|---:|
| Filas | 5,000 | 5,000 |
| Columnas | 34 | 35 |
| Nulos | 1,500 | 0 |
| Duplicados | 0 | 0 |
| `record_id` únicos | 5,000 | 5,000 |
| Anomalías sintéticas marcadas | 150 | 150 |


## 9. Preparación temporal para modelado

El archivo processed es útil para EDA, pero no se utiliza directamente para la evaluación final porque su imputación global puede incorporar información de fechas posteriores.

La preparación final parte del raw y divide por fecha:

| Conjunto | Periodo | Registros | Usuarios |
|---|---|---:|---:|
| Entrenamiento | 2026-04-01 a 2026-06-01 | 3,418 | 250 |
| Validación | 2026-06-02 a 2026-06-14 | 731 | 240 |
| Prueba | 2026-06-15 a 2026-06-29 | 851 | 248 |

## 10. Estadísticas de imputación de entrenamiento

| Variable | Valor |
|---|---:|
| `age` | 36 |
| `height_cm` | 166.3 |
| `weight_kg` | 70.8 |
| `bmi` | 25.35 |
| `water_glasses` | 6 |
| `exercise_minutes` | 25.7 |
| `sleep_hours` | 6.6 |
| `healthy_meals_count` | 2 |
| `meditation_minutes` | 8.5 |
| `pain` | 3 |
| `temperature_c` | 36.7 |
| `systolic_mmhg` | 119 |
| `diastolic_mmhg` | 74 |
| `glucose_mg_dl` | 91 |
| `heart_rate_bpm` | 81 |
| `stress_level` | 4 |
| `energy_level` | 4 |
| `sleep_quality` | 6 |

Moda de `mood`:

```text
mal
```

Son parámetros técnicos del dataset sintético, no recomendaciones de salud.

## 11. Variables de modelado

Las características supervisadas son:

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

Se excluyen identificadores, variables exclusivas de simulación, objetivos cruzados y puntajes derivados que producirían fuga.

## 12. Transformación categórica

`mood` se normaliza a minúsculas y espacios consistentes. Valores válidos:

```text
muy mal
mal
regular
bien
muy bien
```

La codificación queda incluida en el pipeline serializado.

## 13. Carga de conjuntos de modelado

El proyecto dispone de:

```text
data/modeling/train_model.csv
data/modeling/validation_model.csv
data/modeling/test_model.csv
```


## 14. Carga de modelos

Los modelos seleccionados se serializan en `app/models/`. Entre los artefactos disponibles se encuentran:

```text
risk-classification/best_risk_classifier_safe.joblib
wellbeing-regression/best_wellbeing_regressor.joblib
wellbeing-clustering/wellbeing_kmeans_pipeline.joblib
anomaly-detection/isolation_forest_pipeline.joblib
```

El entrenamiento no se ejecuta dentro de cada solicitud de API.

## 15. Relación con MySQL

La base operacional no ejecuta este ETL completo. El backend obtiene campos disponibles y los mapea al contrato del ML Service.

Ejemplos:

```text
habit_logs.water        -> water_glasses
habit_logs.exercise     -> exercise_minutes
symptom_logs.systolic   -> systolic_mmhg
symptom_logs.heart_rate -> heart_rate_bpm
```


## 16. Validaciones

- integridad de columnas;
- tipos;
- duplicados;
- rangos del simulador;
- categorías válidas;
- sistólica mayor que diastólica después de preparación;
- BMI consistente;
- ausencia de nulos en conjuntos de modelado;
- ausencia de fuga temporal;
- transformaciones reproducibles;
- mismo pipeline en entrenamiento e inferencia.

## 17. Conclusión

El proceso conserva los datos originales, documenta las transformaciones y separa la preparación general de la preparación utilizada para modelado. La división temporal previa a la imputación reduce fuga de información y permite reproducir la evaluación. Los elementos pendientes de la guía son la carga del Data Mart y un conjunto formal de inferencia.
