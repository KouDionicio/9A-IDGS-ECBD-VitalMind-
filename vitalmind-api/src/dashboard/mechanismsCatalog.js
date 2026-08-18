/**
 * Catálogo de los 20 mecanismos de Machine Learning propuestos en el
 * documento "Aplicación de Machine Learning Supervisado y No Supervisado
 * en VitalMind IA". Esto es DATOS DE REFERENCIA/DOCUMENTACIÓN, no modelos
 * entrenados: los algoritmos reales (Random Forest, XGBoost, K-Means, etc.)
 * requieren un pipeline de entrenamiento aparte (típicamente Python +
 * scikit-learn) con datos históricos suficientes, y no se ejecutan dentro
 * de esta API Node/Express.
 *
 * Ver también: symptomService.withPriorityScore() para una implementación
 * heurística simplificada del mecanismo #1 usando SQL/JS puro.
 */

const SUPERVISED_MECHANISMS = [
  { id: 1, name: 'Clasificación preventiva del nivel de prioridad de síntomas', type: 'Clasificación multiclase', algorithm: 'Árboles de Decisión / Random Forest / XGBoost / SVM', targetVariable: 'Prioridad preventiva: baja, media, alta' },
  { id: 2, name: 'Estimación de recurrencia de síntomas frecuentes', type: 'Clasificación binaria / Regresión', algorithm: 'Regresión Logística / Random Forest / XGBoost', targetVariable: 'Probabilidad de recurrencia' },
  { id: 3, name: 'Estimación de adherencia a hábitos saludables', type: 'Regresión / Clasificación', algorithm: 'XGBoost / Random Forest / Redes Neuronales', targetVariable: 'Porcentaje de adherencia o clase: baja, media, alta' },
  { id: 4, name: 'Clasificación del estado emocional percibido', type: 'Clasificación multiclase + NLP', algorithm: 'Naive Bayes / SVM / BERT ligero', targetVariable: 'Estado emocional: positivo, neutral, estrés, tristeza, ansiedad' },
  { id: 5, name: 'Recomendador supervisado de hábitos personalizados', type: 'Recomendación / Learning to rank', algorithm: 'Gradient Boosting / Redes Neuronales', targetVariable: 'Ranking de recomendaciones aceptadas' },
  { id: 6, name: 'Clasificación de alerta preventiva responsable', type: 'Clasificación binaria/multietiqueta', algorithm: 'Random Forest / XGBoost / Regresión Logística', targetVariable: 'Generar alerta preventiva: sí/no; tipo de alerta' },
  { id: 7, name: 'Clasificación de riesgo de abandono de la aplicación', type: 'Clasificación binaria', algorithm: 'Regresión Logística / Random Forest / XGBoost', targetVariable: 'Riesgo de abandono: bajo, medio, alto' },
  { id: 8, name: 'Estimación de calidad del sueño', type: 'Regresión / Clasificación ordinal', algorithm: 'Random Forest Regressor / Gradient Boosting', targetVariable: 'Puntaje de calidad del sueño o clase' },
  { id: 9, name: 'Clasificación de riesgo de sedentarismo', type: 'Clasificación binaria/multiclase', algorithm: 'Árboles de Decisión / Random Forest / XGBoost', targetVariable: 'Riesgo de sedentarismo: bajo, medio, alto' },
  { id: 10, name: 'Clasificación de mensajes sensibles del chatbot', type: 'Clasificación de texto', algorithm: 'BERT ligero / SVM / Naive Bayes', targetVariable: 'Tipo de mensaje: informativo, seguimiento, urgencia, apoyo emocional' },
];

const UNSUPERVISED_MECHANISMS = [
  { id: 11, name: 'Segmentación de usuarios por hábitos de salud', type: 'Clustering', algorithm: 'K-Means / Gaussian Mixture Models / Jerárquico' },
  { id: 12, name: 'Agrupación por patrones de síntomas', type: 'Clustering', algorithm: 'DBSCAN / K-Means / HDBSCAN' },
  { id: 13, name: 'Identificación de perfiles emocionales', type: 'Clustering y análisis exploratorio', algorithm: 'K-Means / Clustering Jerárquico / HDBSCAN' },
  { id: 14, name: 'Detección de anomalías en registros de salud', type: 'Detección de anomalías', algorithm: 'Isolation Forest / Autoencoders / DBSCAN' },
  { id: 15, name: 'Reglas de asociación entre hábitos y síntomas', type: 'Reglas de asociación', algorithm: 'Apriori / FP-Growth' },
  { id: 16, name: 'Segmentación por comportamiento de uso de la aplicación', type: 'Clustering sobre comportamiento digital', algorithm: 'K-Means / Gaussian Mixture Models' },
  { id: 17, name: 'Análisis de temas del chatbot', type: 'Modelado de temas', algorithm: 'LDA / BERTopic / clustering de embeddings' },
  { id: 18, name: 'Mapa de bienestar con reducción de dimensionalidad', type: 'Reducción de dimensionalidad', algorithm: 'PCA / UMAP / t-SNE' },
  { id: 19, name: 'Clustering de rutinas de bienestar', type: 'Clustering temporal', algorithm: 'K-Means / DTW Clustering / HDBSCAN' },
  { id: 20, name: 'Perfiles preventivos de seguimiento sin diagnóstico', type: 'Clustering y detección de anomalías', algorithm: 'HDBSCAN / Autoencoders / PCA + K-Means' },
];

function getAll() {
  return {
    supervised: SUPERVISED_MECHANISMS,
    unsupervised: UNSUPERVISED_MECHANISMS,
    note:
      'Este catálogo es documentación de referencia del proyecto académico VitalMind IA. ' +
      'Los mecanismos supervisados/no supervisados que requieren entrenamiento (Random Forest, ' +
      'K-Means, etc.) deben implementarse en un pipeline aparte (p. ej. Python + scikit-learn). ' +
      'Esta API expone, además, una implementación heurística (basada en reglas/estadística SQL) ' +
      'del mecanismo #1 en el endpoint de síntomas (campo priorityScore/priorityLevel).',
  };
}

function getById(id) {
  const numId = Number(id);
  return (
    SUPERVISED_MECHANISMS.find((m) => m.id === numId) ||
    UNSUPERVISED_MECHANISMS.find((m) => m.id === numId) ||
    null
  );
}

module.exports = { getAll, getById, SUPERVISED_MECHANISMS, UNSUPERVISED_MECHANISMS };
