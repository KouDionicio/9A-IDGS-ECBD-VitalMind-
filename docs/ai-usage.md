# Uso de Inteligencia Artificial — VitalMind AI

## 1. Propósito

Este documento cubre dos usos distintos de Inteligencia Artificial dentro del proyecto:

1. **IA generativa utilizada como apoyo durante el desarrollo y la documentación.**
2. **IA integrada como parte funcional del prototipo**, mediante modelos de Machine Learning y un chatbot.


## 2. IA generativa como apoyo del equipo

### 2.1 Herramientas confirmadas

| Herramienta | Uso confirmado |
|---|---|
| ChatGPT / OpenAI | Revisión de coherencia documental, comparación con la guía oficial, corrección de redacción y apoyo para organizar evidencias técnicas |
| Mistral AI | Servicio conversacional integrado en el microservicio del producto |



### 2.2 Prompts importantes

Entre las solicitudes de apoyo documental se encuentran:

- revisar que el alcance del proyecto sea coherente entre archivos;
- comparar la documentación con la guía del Proyecto Integrador;
- distinguir funciones implementadas de funciones pendientes;
- revisar contratos de API a partir del código disponible;
- organizar métricas de modelos ya generadas;
- corregir redacción, nombres técnicos y contradicciones;
- identificar requisitos sin evidencia suficiente.

Las solicitudes se formularon con la restricción de no inventar modelos de smartwatch, SDK, resultados de pruebas ni componentes no encontrados en los archivos.


### 2.3 Código generado o modificado con IA

En esta revisión documental no se atribuye a ChatGPT la autoría de módulos de Kotlin, Node.js, FastAPI, SQL o Machine Learning que ya existían en los archivos del proyecto. No existe evidencia suficiente para separar qué fragmentos de código previos fueron escritos manualmente y cuáles pudieron recibir asistencia de IA.

El uso confirmado de ChatGPT en esta etapa corresponde a análisis y corrección de documentación. Si el equipo utiliza IA para generar o modificar código posteriormente, deberá registrar el archivo afectado, el propósito del cambio, la validación realizada y la decisión final del equipo.

### 2.4 Cambios realizados a partir de la revisión

La revisión documental permitió:

- unificar Wear OS como plataforma del smartwatch;
- registrar Kotlin y Android Studio como tecnología de la aplicación;
- registrar Bluetooth como medio de sincronización;
- aclarar que el endpoint no supervisado solicitado por la guía aún no está disponible;
- aclarar que el dashboard actual usa polling y no Socket.IO;
- ampliar la documentación de EDA, ETL, selección de modelos, Data Mart y pruebas;
- separar evidencia comprobada de actividades planificadas.

### 2.5 Errores encontrados y riesgos del uso de IA

Las salidas generativas pueden completar información no proporcionada, confundir dependencias con pruebas aprobadas, presentar propuestas como implementación o redactar conclusiones más fuertes que la evidencia.

Por esa razón, los cambios se validan contra datasets, código, reportes de métricas y archivos de configuración.

### 2.6 Validaciones realizadas

Antes de conservar una corrección se revisa que:

- la ruta o archivo citado exista;
- la métrica coincida con los reportes;
- el algoritmo corresponda al artefacto serializado;
- la tecnología esté confirmada;
- las pruebas sin reporte permanezcan pendientes;
- no se añadan capacidades médicas ni del smartwatch sin evidencia.

La decisión final sobre el contenido corresponde al equipo del proyecto.

## 3. Machine Learning integrado al prototipo

| Componente | Técnica | Finalidad | Estado |
|---|---|---|---|
| Clasificador de riesgo | Regresión Logística | Estimar `low`, `medium` o `high` sobre etiquetas sintéticas | Implementado y evaluado |
| Regresor de bienestar | Ridge Regression | Estimar `wellbeing_score` | Implementado y evaluado |
| Segmentación | K-Means | Explorar grupos de perfiles agregados | Modelo serializado y reportes disponibles |
| Reducción | PCA | Representar clusters en dos dimensiones | Implementada como apoyo exploratorio |
| Anomalías | Isolation Forest | Identificar observaciones atípicas | Implementación exploratoria |
| Recomendaciones | Reglas explícitas | Generar sugerencias generales de hábitos | Implementadas |
| Chatbot | Mistral AI | Explicar resultados y responder preguntas generales | Integrado a nivel de código |

Todos estos componentes se desarrollaron o evaluaron con datos sintéticos.

## 4. Clasificación preventiva de riesgo

Modelo final:

```text
Regresión Logística
C = 10.0
class_weight = balanced
solver = lbfgs
```

Prueba final sobre 851 registros:

| Métrica | Resultado |
|---|---:|
| Accuracy | 0.9048 |
| F1 macro | 0.9037 |
| ROC-AUC macro | 0.9808 |
| Recall de `high` | 0.9130 |

La salida incluye `risk_level`, `confidence` y probabilidades por clase. Estas probabilidades no representan certeza clínica.

## 5. Estimación de bienestar

```text
Ridge Regression
alpha = 10.0
```

| Métrica | Resultado |
|---|---:|
| MAE | 3.1230 |
| RMSE | 3.8266 |
| R² | 0.9584 |

## 6. Aprendizaje no supervisado

### 6.1 K-Means

Se evaluaron `k = 2` a `k = 6`. La solución seleccionada utiliza dos clusters:

| Métrica | Resultado |
|---|---:|
| Silhouette | 0.3615 |
| Davies-Bouldin | 1.0408 |
| Calinski-Harabasz | 184.4039 |
| Usuarios | 250 |
| Tamaños | 160 y 90 |

### 6.2 PCA

La representación PCA en dos dimensiones explica aproximadamente 65.58 % de la varianza del conjunto de perfiles utilizado para clustering.

### 6.3 Isolation Forest

Con contaminación de 3 %, el detector marcó 103 observaciones de entrenamiento. Frente a la etiqueta sintética externa obtuvo F1 = 0.1300. Se mantiene como apoyo exploratorio.

## 7. Recomendaciones

El motor de recomendaciones utiliza reglas explícitas sobre hidratación, ejercicio, sueño, alimentación, meditación, estrés, energía, calidad del sueño, riesgo y bienestar.

## 8. Chatbot

Configuración observada:

```text
Proveedor: Mistral AI
Modelo: mistral-small-latest
```

El chatbot recibe contexto analítico y no debe diagnosticar, prescribir, modificar dosis, inventar mediciones ni presentar probabilidades como certezas.

## 9. Integración técnica

El ML Service expone:

```http
GET  /health
GET  /api/v1/models/info
POST /api/v1/analyze
POST /api/v1/chat
POST /api/v1/chat/analyze
```

`/api/v1/analyze` cubre el mecanismo supervisado principal. Aunque existe un modelo K-Means serializado, no se identificó un endpoint no supervisado, por lo que ese requisito permanece pendiente.

La aplicación se desarrolla en Kotlin con Android Studio y el smartwatch Wear OS se sincroniza por Bluetooth. No está confirmado un modelo específico ni una API o SDK de salud.

## 10. Datos de los modelos supervisados

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

## 11. Trazabilidad

Las solicitudes incluyen `request_id`, `user_id` y `analysis_date`. Estos campos sirven para trazabilidad y no se utilizan como predictores.

## 12. Decisiones del equipo documentadas

- mantener datos sintéticos para la etapa académica;
- separar temporalmente antes de aprender estadísticas de imputación;
- seleccionar Regresión Logística por desempeño e interpretabilidad;
- seleccionar Ridge para bienestar;
- conservar K-Means como mecanismo no supervisado prioritario;
- mantener Isolation Forest como exploratorio;
- no declarar Socket.IO ni endpoint no supervisado como implementados;
- no asumir capacidades del smartwatch sin confirmar el acceso a sus datos.

## 13. Limitaciones

- Los modelos usan datos sintéticos.
- No existe validación clínica.
- Mistral depende de un proveedor externo.
- Los clusters no tienen significado clínico.
- Una anomalía estadística no equivale a una anomalía médica.
- La IA no sustituye la comprensión, prueba ni defensa del proyecto por parte del equipo.

## 14. Referencias internas

- [`context.md`](./context.md)
- [`model-evaluation.md`](./model-evaluation.md)
- [`api-contracts.md`](./api-contracts.md)
- [`testing.md`](./testing.md)
- [`ethics.md`](./ethics.md)
