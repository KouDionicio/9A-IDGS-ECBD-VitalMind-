# Módulo de Machine Learning — VitalMind AI

Este módulo contiene el proceso de preparación de datos, análisis exploratorio, entrenamiento, evaluación, selección y serialización de los modelos de Machine Learning utilizados en VitalMind AI.

## Responsable

**Michelle Castro Otero**  
Responsable de Inteligencia Artificial y Machine Learning.

## Objetivo

Desarrollar modelos capaces de analizar información biopsicosocial para apoyar la prevención, el seguimiento del bienestar y la identificación de cambios relevantes en los hábitos de los usuarios.

## Alcance

Este módulo incluye:

- Preparación y limpieza de datos biopsicosociales.
- Simulación estratégica del dataset.
- Validación de la calidad de los datos.
- Análisis exploratorio de datos.
- Preparación de conjuntos de entrenamiento, validación y prueba.
- Clasificación del semáforo de riesgo.
- Pronóstico de la evolución del bienestar.
- Generación de recomendaciones personalizadas.
- Análisis del tono emocional.
- Detección de cambios drásticos en la rutina.
- Evaluación y comparación de modelos.
- Ajuste de hiperparámetros.
- Selección de modelos.
- Serialización de modelos.
- Pruebas locales de inferencia.
- Documentación técnica para el equipo de Backend.

## Fuera de alcance

Este módulo no incluye:

- Desarrollo de API REST.
- Desarrollo de endpoints.
- FastAPI.
- Express.js.
- Rutas o controladores.
- Autenticación.
- Manejo de sesiones.
- MongoDB.
- Socket.IO.
- Integración con el frontend.
- Documentación Swagger.

Estas actividades corresponden al equipo de Backend.

## Estructura

~~~text
ml-service/
├── README.md
├── app/
│   ├── README.md
│   ├── models/
│   │   └── README.md
│   ├── notebooks/
│   │   └── README.md
│   └── utils/
│       └── README.md
├── data/
│   ├── README.md
│   ├── raw/
│   │   └── README.md
│   ├── processed/
│   │   └── README.md
│   ├── training/
│   │   └── README.md
│   ├── validation/
│   │   └── README.md
│   └── test/
│       └── README.md
├── reports/
│   └── README.md
├── docs/
│   └── README.md
├── scripts/
│   └── README.md
├── requirements.txt
└── .gitignore
~~~

## Flujo general

~~~text
Datos originales
        ↓
Validación y limpieza
        ↓
Análisis exploratorio
        ↓
Preparación de conjuntos
        ↓
Entrenamiento de modelos
        ↓
Evaluación y comparación
        ↓
Selección del mejor modelo
        ↓
Serialización
        ↓
Pruebas locales
        ↓
Entrega técnica a Backend
~~~

## Modelos considerados

### Clasificación

- Regresión Logística.
- Random Forest Classifier.

### Regresión o pronóstico

- Random Forest Regressor.
- XGBoost Regressor.
- Prophet, cuando los datos temporales lo permitan.

### Recomendación

- K-Nearest Neighbors.
- Filtrado basado en contenido.

### Análisis emocional

- Support Vector Machine.
- DistilBERT, si los recursos y datos disponibles permiten su implementación.

### Detección de anomalías

- Isolation Forest.
- One-Class SVM.

## Métricas

### Clasificación

- Accuracy.
- Precision.
- Recall.
- F1-Score.
- Matriz de confusión.
- ROC-AUC, cuando aplique.

### Regresión

- MAE.
- MSE.
- RMSE.
- R².

### Agrupamiento o anomalías

- Silhouette Score, cuando aplique.
- Davies-Bouldin, cuando aplique.
- Proporción de anomalías detectadas.
- Interpretación de los casos identificados.

## Reglas generales

- Todos los procesos deben ser reproducibles.
- Los datos originales no deben modificarse manualmente.
- Cada transformación debe quedar documentada.
- Se debe evitar la fuga de información.
- El conjunto de prueba no debe utilizarse para entrenar.
- Los modelos deben compararse antes de seleccionar uno.
- Cada modelo serializado debe incluir versión y metadatos.
- No deben almacenarse datos personales sensibles.
- Los resultados no deben presentarse como diagnósticos médicos.
- Los modelos deben considerarse herramientas de apoyo.

---
