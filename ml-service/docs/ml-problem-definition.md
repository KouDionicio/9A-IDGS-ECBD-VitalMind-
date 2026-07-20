# Definición del problema de Machine Learning

## Proyecto

**VitalMind AI**

## Responsable del módulo

**Michelle Castro Otero**  
Responsable de Inteligencia Artificial y Machine Learning.

## Estado del documento

> Documento provisional sujeto a validación con el equipo de Backend.

## 1. Contexto

VitalMind AI es una plataforma digital orientada al registro, seguimiento y análisis de información relacionada con el bienestar de los usuarios.

La aplicación permitirá registrar datos asociados con:

- Hábitos de sueño.
- Actividad física.
- Hidratación.
- Alimentación.
- Estado de ánimo.
- Nivel de estrés.
- Síntomas.
- Cumplimiento de metas.
- Uso de la aplicación.
- Interacciones con el chatbot.

El módulo de Machine Learning analizará estos datos para identificar patrones, estimar niveles de riesgo, generar recomendaciones generales de bienestar y detectar cambios relevantes en la rutina.

## 2. Problemática

Los registros de bienestar pueden ser numerosos, variables y difíciles de interpretar manualmente.

Un usuario puede presentar cambios graduales o repentinos en sus hábitos sin reconocer fácilmente su relación con el sueño, el estrés, la actividad física, la hidratación o el estado emocional.

VitalMind AI necesita mecanismos que permitan:

- Identificar patrones de deterioro en los hábitos.
- Clasificar el nivel de riesgo preventivo.
- Estimar la evolución del bienestar.
- Recomendar acciones generales de autocuidado.
- Detectar cambios atípicos en la rutina.
- Analizar el tono emocional de mensajes.
- Apoyar el seguimiento personalizado.

## 3. Objetivo general

Desarrollar modelos de Machine Learning que analicen información biopsicosocial de los usuarios de VitalMind AI para identificar patrones de bienestar, clasificar niveles de riesgo preventivo, generar recomendaciones generales y detectar cambios relevantes en sus hábitos.

## 4. Objetivos específicos

1. Preparar y validar datos relacionados con hábitos, síntomas y estado emocional.
2. Construir un clasificador para el semáforo de riesgo preventivo.
3. Comparar Regresión Logística y Random Forest Classifier.
4. Desarrollar modelos para estimar la evolución del bienestar.
5. Evaluar Random Forest Regressor y XGBoost Regressor.
6. Analizar la viabilidad de Prophet cuando existan registros temporales suficientes.
7. Desarrollar un recomendador basado en similitud de perfiles y contenido.
8. Evaluar un modelo para clasificar el tono emocional de los mensajes.
9. Detectar cambios atípicos mediante modelos de detección de anomalías.
10. Evaluar, comparar y seleccionar los modelos más útiles.
11. Serializar los modelos seleccionados.
12. Documentar entradas, salidas, métricas y limitaciones para Backend.

## 5. Usuarios beneficiados

### Usuario de VitalMind AI

Podrá conocer tendencias generales de sus hábitos, recibir recomendaciones preventivas y visualizar cambios en su bienestar.

### Administrador

Podrá consultar información agregada sobre el funcionamiento de los modelos y los patrones detectados.

### Equipo de Backend

Recibirá modelos serializados, preprocesadores y contratos técnicos para integrarlos con el sistema.

### Equipo de Frontend

Consumirá los resultados proporcionados por Backend para mostrarlos en el dashboard, chatbot y semáforo de riesgo.

## 6. Problemas de Machine Learning

### 6.1 Clasificación del nivel de riesgo

El modelo clasificará el nivel preventivo de riesgo relacionado con el deterioro de hábitos.

#### Tipo de problema

Clasificación multiclase.

#### Salida preliminar

- Bajo.
- Medio.
- Alto.

#### Algoritmos iniciales

- Regresión Logística.
- Random Forest Classifier.

### 6.2 Estimación de la evolución del bienestar

El modelo estimará un puntaje general de bienestar a partir de los hábitos registrados.

#### Tipo de problema

Regresión.

#### Salida preliminar

Puntaje de bienestar en una escala de `0` a `100`.

#### Algoritmos iniciales

- Random Forest Regressor.
- XGBoost Regressor.
- Prophet, cuando exista una serie temporal suficiente.

### 6.3 Recomendación de hábitos

El mecanismo recomendará acciones generales de bienestar según el perfil y los hábitos del usuario.

#### Tipo de problema

Sistema de recomendación.

#### Algoritmos iniciales

- K-Nearest Neighbors.
- Filtrado basado en contenido.

### 6.4 Análisis del tono emocional

El modelo clasificará el tono general de los mensajes registrados voluntariamente por el usuario.

#### Tipo de problema

Clasificación de texto.

#### Salidas preliminares

- Positivo.
- Neutral.
- Tristeza.
- Estrés.
- Ansiedad.

#### Algoritmos iniciales

- SVM con representación TF-IDF.
- DistilBERT, si los datos y recursos disponibles permiten su implementación.

### 6.5 Detección de cambios drásticos

El modelo identificará registros que se alejen considerablemente del patrón habitual del usuario.

#### Tipo de problema

Detección no supervisada de anomalías.

#### Algoritmos iniciales

- Isolation Forest.
- One-Class SVM.

## 7. Preguntas de análisis

1. ¿Qué variables se relacionan más con el nivel de riesgo preventivo?
2. ¿Cómo influyen el sueño, el estrés y la actividad física en el bienestar?
3. ¿Qué algoritmo clasifica mejor el semáforo de riesgo?
4. ¿Qué modelo obtiene menor error al estimar el bienestar?
5. ¿Existen perfiles de usuarios con hábitos similares?
6. ¿Qué hábitos aparecen asociados con niveles bajos de bienestar?
7. ¿Qué cambios pueden considerarse atípicos para un usuario?
8. ¿Qué variables son más importantes para las predicciones?
9. ¿Qué tan estables son los resultados de los modelos?
10. ¿Qué información debe recibir Backend para ejecutar cada modelo?

## 8. Entradas preliminares

Las variables preliminares incluyen:

- Edad.
- Horas de sueño.
- Calidad del sueño.
- Nivel de estrés.
- Estado de ánimo.
- Minutos de actividad física.
- Consumo de agua.
- Número de comidas.
- Cumplimiento de hábitos.
- Intensidad de síntomas.
- Frecuencia de síntomas.
- Uso diario de la aplicación.
- Número de interacciones con el chatbot.

Los nombres definitivos se ajustarán después de revisar los esquemas y contratos del equipo de Backend.

## 9. Salidas preliminares

### Clasificador de riesgo

```json
{
  "nivel_riesgo": "medio",
  "probabilidad": 0.78
}

```

### Modelo de bienestar

```json
{
  "puntaje_bienestar_estimado": 67.5
}
```

### Recomendador

```json

{
  "recomendaciones": [
    "Mejorar la regularidad del sueño",
    "Incrementar gradualmente la hidratación"
  ]
}

```

### Detector de anomalías

```json

{
  "es_anomalia": true,
  "puntaje_anomalia": -0.42
}

```

### Analizador emocional

```json

{
  "tono_emocional": "estres",
  "confianza": 0.81
}

```

## 10. Métricas de evaluación

### 10.1 Clasificación

- **Accuracy**
- **Precision**
- **Recall**
- **F1-Score**
- **Matriz de confusión**
- **ROC-AUC**, cuando aplique

### 10.2 Regresión

- **MAE**
- **MSE**
- **RMSE**
- **R²**

### 10.3 Recomendación

- **Similitud**
- **Precisión en recomendaciones**, cuando existan datos de evaluación
- **Revisión de coherencia de resultados**
- **Cobertura**

### 10.4 Detección de anomalías

- **Proporción de anomalías**
- **Análisis de falsos positivos**
- **Estabilidad**
- **Interpretación de los registros detectados**

---

## 11. Alcance

El módulo de **Machine Learning** llegará hasta:

- Preparación de datos
- Análisis exploratorio
- Entrenamiento
- Evaluación
- Selección
- Serialización
- Pruebas locales
- Documentación técnica
- Entrega de artefactos a Backend

---

## 12. Fuera de alcance

No corresponde a este módulo:

- Implementar endpoints
- Desarrollar FastAPI
- Desarrollar Express.js
- Administrar MongoDB
- Implementar autenticación
- Implementar Socket.IO
- Integrar directamente el frontend
- Crear documentación Swagger

---

## 13. Consideraciones éticas

- Los resultados serán preventivos e informativos.
- No se emitirán diagnósticos médicos o psicológicos.
- No se sustituirá la valoración de profesionales.
- Los datos deberán ser anónimos o simulados.
- No se utilizarán nombres, correos, teléfonos ni identificadores directos.
- Se documentarán los posibles sesgos.
- Se explicarán las limitaciones de cada modelo.
- Las recomendaciones serán generales y no prescriptivas.

---

## 14. Dependencias con Backend

Antes de definir el contrato final se requiere confirmar:

- Entidades y colecciones
- Nombres exactos de campos
- Tipos de datos
- Campos obligatorios
- Campos opcionales
- Formato de las fechas
- Unidades
- JSON de entrada
- JSON de salida
- Manejo de valores faltantes
- Identificadores utilizados

---

## 15. Estado actual

La definición inicial se considera **provisional** hasta recibir y revisar la información técnica del equipo de Backend.


---
