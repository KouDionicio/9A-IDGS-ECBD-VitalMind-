# Propuestas de Aplicación de Machine Learning — VitalMind AI

## 1. Propósito

Este documento reúne veinte propuestas de aplicación de Machine Learning para VitalMind AI:

- Diez mecanismos de aprendizaje supervisado.
- Diez mecanismos de aprendizaje no supervisado.

Las propuestas se basan en el documento académico **“Aplicación de Machine Learning Supervisado y No Supervisado en VitalMind IA”** y se reorganizan conforme a la estructura solicitada en la guía del proyecto integrador.




---

## 2. Resumen general

| No. | Mecanismo | Tipo | Algoritmo inicial | Resultado esperado |
|---:|---|---|---|---|
| 1 | Clasificación preventiva del nivel de prioridad de síntomas | Supervisado | Árbol de Decisión / Random Forest | Prioridad baja, media o alta |
| 2 | Estimación de recurrencia de síntomas frecuentes | Supervisado | Regresión Logística / Random Forest | Probabilidad o cantidad esperada |
| 3 | Estimación de adherencia a hábitos saludables | Supervisado | XGBoost / Random Forest | Porcentaje o clase de adherencia |
| 4 | Clasificación del estado emocional percibido | Supervisado | Naive Bayes / SVM | Estado emocional percibido |
| 5 | Recomendador supervisado de hábitos personalizados | Supervisado | Gradient Boosting / ranking | Ranking de recomendaciones |
| 6 | Clasificación de alerta preventiva responsable | Supervisado | Random Forest / Regresión Logística | Generar alerta y tipo |
| 7 | Clasificación de riesgo de abandono de la aplicación | Supervisado | Regresión Logística / XGBoost | Riesgo bajo, medio o alto |
| 8 | Estimación de calidad del sueño | Supervisado | Random Forest Regressor | Puntaje o clase de sueño |
| 9 | Clasificación de riesgo de sedentarismo | Supervisado | Árbol de Decisión / Random Forest | Riesgo bajo, medio o alto |
| 10 | Clasificación de mensajes sensibles del chatbot | Supervisado | BERT ligero / SVM | Tipo de mensaje |
| 11 | Segmentación de usuarios por hábitos de salud | No supervisado | K-Means | Segmentos de hábitos |
| 12 | Agrupación por patrones de síntomas | No supervisado | DBSCAN / K-Means | Grupos de síntomas |
| 13 | Identificación de perfiles emocionales | No supervisado | K-Means / HDBSCAN | Perfiles emocionales |
| 14 | Detección de anomalías en registros de salud | No supervisado | Isolation Forest | Registros atípicos |
| 15 | Reglas de asociación entre hábitos y síntomas | No supervisado | Apriori / FP-Growth | Reglas de asociación |
| 16 | Segmentación por comportamiento de uso | No supervisado | K-Means / GMM | Perfiles de uso |
| 17 | Análisis de temas del chatbot | No supervisado | LDA / BERTopic | Temas frecuentes |
| 18 | Mapa de bienestar con reducción dimensional | No supervisado | PCA / UMAP | Representación reducida |
| 19 | Clustering de rutinas de bienestar | No supervisado | K-Means / HDBSCAN | Rutinas agrupadas |
| 20 | Perfiles preventivos sin diagnóstico | No supervisado | HDBSCAN / PCA + K-Means | Perfiles preventivos |

---

# 3. Propuestas de aprendizaje supervisado

## 3.1 Clasificación preventiva del nivel de prioridad de síntomas

| Elemento | Descripción |
|---|---|
| **Nombre** | Clasificación preventiva del nivel de prioridad de síntomas |
| **Tipo** | Clasificación multiclase supervisada |
| **Problema** | Los usuarios pueden registrar síntomas con distinta intensidad y frecuencia, pero la plataforma necesita orientar el seguimiento de forma proporcional. |
| **Usuario beneficiado** | Usuario que registra síntomas y equipo responsable del seguimiento preventivo. |
| **Datos necesarios** | Tipo de síntoma, duración, intensidad, frecuencia, edad, antecedentes, signos vitales disponibles, dolor y síntomas asociados. |
| **Entradas** | Registro actual del síntoma y contexto reciente del usuario. |
| **Salida** | Prioridad preventiva: baja, media o alta. |
| **Algoritmo sugerido** | Árbol de Decisión, Random Forest, XGBoost o SVM. |
| **Evaluación** | Precision, Recall, F1-score, matriz de confusión y ROC-AUC multiclase cuando aplique. |
| **Integración propuesta** | Endpoint que reciba el registro del síntoma y devuelva prioridad, confianza, versión del modelo y recomendación orientativa. |
| **Beneficio** | Mostrar recomendaciones diferenciadas y reducir alertas innecesarias. |
| **Riesgos** | Falsos positivos, falsos negativos, alarmismo y posible interpretación como diagnóstico. |
| **Consideración ética** | No sustituir triage clínico ni diagnóstico profesional. |

**Ejemplo:** fiebre persistente, dolor alto y antecedentes relevantes podrían producir una prioridad alta y una recomendación de atención profesional.

---

## 3.2 Estimación de recurrencia de síntomas frecuentes

| Elemento | Descripción |
|---|---|
| **Nombre** | Estimación de recurrencia de síntomas frecuentes |
| **Tipo** | Clasificación binaria o regresión supervisada |
| **Problema** | El usuario puede no identificar patrones repetitivos en síntomas como dolor de cabeza, cansancio o malestar digestivo. |
| **Usuario beneficiado** | Usuario que desea dar seguimiento a síntomas recurrentes. |
| **Datos necesarios** | Historial de síntomas, frecuencia semanal, intensidad, sueño, estrés, hidratación, actividad, medicamentos y antecedentes. |
| **Entradas** | Historial reciente y variables de hábitos relacionadas. |
| **Salida** | Probabilidad de recurrencia o cantidad esperada de registros similares. |
| **Algoritmo sugerido** | Regresión Logística, Random Forest o XGBoost. |
| **Evaluación** | Precision, Recall, F1-score y ROC-AUC para clasificación; MAE, RMSE y R² para regresión. |
| **Integración propuesta** | Endpoint de análisis de recurrencia consumido desde historial y dashboard. |
| **Beneficio** | Seguimiento preventivo y reportes más útiles. |
| **Riesgos** | Inferir causalidad, datos incompletos y dependencia de registros realizados por el usuario. |
| **Consideración ética** | Explicar que el resultado depende de la calidad de los registros y no representa diagnóstico. |

**Ejemplo:** dolor de cabeza frecuente junto con poco sueño podría activar una sugerencia de monitoreo y descanso.

---

## 3.3 Estimación de adherencia a hábitos saludables

| Elemento | Descripción |
|---|---|
| **Nombre** | Estimación de adherencia a hábitos saludables |
| **Tipo** | Regresión o clasificación supervisada |
| **Problema** | Muchos usuarios establecen metas de bienestar, pero no las mantienen de forma constante. |
| **Usuario beneficiado** | Usuario con metas de sueño, hidratación, actividad o alimentación. |
| **Datos necesarios** | Metas configuradas, pasos, agua, sueño, alimentación, estado de ánimo, historial de cumplimiento y notificaciones abiertas. |
| **Entradas** | Registros diarios y metas personales. |
| **Salida** | Porcentaje de adherencia o clase baja, media o alta. |
| **Algoritmo sugerido** | XGBoost, Random Forest o red neuronal simple. |
| **Evaluación** | MAE, RMSE y R² para porcentaje; Precision, Recall y F1-score para clasificación. |
| **Integración propuesta** | Servicio que calcule adherencia y actualice metas, recomendaciones y dashboard. |
| **Beneficio** | Recomendaciones realistas, motivación personalizada y seguimiento progresivo. |
| **Riesgos** | Culpabilizar al usuario, metas poco realistas y sesgo por registros faltantes. |
| **Consideración ética** | Utilizar mensajes empáticos y metas alcanzables. |

---

## 3.4 Clasificación del estado emocional percibido

| Elemento | Descripción |
|---|---|
| **Nombre** | Clasificación del estado emocional percibido |
| **Tipo** | Clasificación multiclase supervisada con apoyo de NLP |
| **Problema** | El bienestar emocional puede variar con el sueño, el estrés, la actividad y los eventos personales. |
| **Usuario beneficiado** | Usuario que registra voluntariamente estado de ánimo o texto emocional. |
| **Datos necesarios** | Estado de ánimo, texto opcional, estrés, sueño, energía, actividad y frecuencia de registros. |
| **Entradas** | Categorías emocionales y texto proporcionado voluntariamente. |
| **Salida** | Positivo, neutral, estrés, tristeza o ansiedad percibida. |
| **Algoritmo sugerido** | Naive Bayes, SVM, BERT ligero o red neuronal. |
| **Evaluación** | Precision, Recall y F1-score por clase, matriz de confusión y macro F1. |
| **Integración propuesta** | Endpoint NLP para clasificar el registro y alimentar tendencias del dashboard. |
| **Beneficio** | Visualización de tendencias emocionales y apoyo informativo. |
| **Riesgos** | Diagnóstico psicológico implícito, exposición de texto sensible y errores de interpretación. |
| **Consideración ética** | No diagnosticar trastornos mentales y proteger especialmente los datos emocionales. |

---

## 3.5 Recomendador supervisado de hábitos personalizados

| Elemento | Descripción |
|---|---|
| **Nombre** | Recomendador supervisado de hábitos personalizados |
| **Tipo** | Recomendación supervisada / learning to rank |
| **Problema** | Las recomendaciones generales pueden no adaptarse al estilo de vida de cada persona. |
| **Usuario beneficiado** | Usuario que recibe sugerencias de hábitos. |
| **Datos necesarios** | Perfil, hábitos actuales, historial de aceptación, objetivos, estado de ánimo, sueño, actividad y síntomas frecuentes. |
| **Entradas** | Perfil y contexto actual del usuario. |
| **Salida** | Ranking de recomendaciones aceptadas o potencialmente útiles. |
| **Algoritmo sugerido** | Gradient Boosting, red neuronal o modelo de ranking. |
| **Evaluación** | NDCG@K, Precision@K, Recall@K, tasa de aceptación y CTR. |
| **Integración propuesta** | Endpoint que devuelva recomendaciones ordenadas con explicación y posibilidad de aceptar o rechazar. |
| **Beneficio** | Mayor personalización y adopción de hábitos saludables. |
| **Riesgos** | Recomendaciones riesgosas, sesgo de retroalimentación y pérdida de autonomía. |
| **Consideración ética** | Permitir aceptar, rechazar o personalizar sugerencias. |

---

## 3.6 Clasificación de alerta preventiva responsable

| Elemento | Descripción |
|---|---|
| **Nombre** | Clasificación de alerta preventiva responsable |
| **Tipo** | Clasificación binaria o multietiqueta supervisada |
| **Problema** | Demasiadas alertas generan fatiga, pero pocas alertas pueden ocultar patrones importantes. |
| **Usuario beneficiado** | Usuario que necesita avisos oportunos sin alarmismo. |
| **Datos necesarios** | Síntomas persistentes, intensidad, frecuencia, antecedentes, cambios de hábitos, signos vitales, edad y registros recientes. |
| **Entradas** | Ventana reciente de síntomas y hábitos. |
| **Salida** | Generar alerta sí/no y tipo de alerta. |
| **Algoritmo sugerido** | Random Forest, XGBoost o Regresión Logística. |
| **Evaluación** | Precision, Recall, F1-score, tasa de falsos positivos y tasa de falsas alarmas. |
| **Integración propuesta** | Servicio de alertas conectado al backend, dashboard y Socket.IO. |
| **Beneficio** | Alertas más útiles y reducción de falsos avisos. |
| **Riesgos** | Alarmismo, falsa seguridad y omisión de casos importantes. |
| **Consideración ética** | Incluir siempre que la alerta no representa diagnóstico. |

---

## 3.7 Clasificación de riesgo de abandono de la aplicación

| Elemento | Descripción |
|---|---|
| **Nombre** | Clasificación de riesgo de abandono de la aplicación |
| **Tipo** | Clasificación binaria o multiclase supervisada |
| **Problema** | El seguimiento depende de que el usuario registre información de manera periódica. |
| **Usuario beneficiado** | Usuario que puede recibir apoyo para retomar el seguimiento y equipo de producto. |
| **Datos necesarios** | Días sin sesión, frecuencia de registros, módulos usados, notificaciones abiertas, tiempo de sesión y recomendaciones ignoradas. |
| **Entradas** | Historial de interacción con la aplicación. |
| **Salida** | Riesgo de abandono bajo, medio o alto. |
| **Algoritmo sugerido** | Regresión Logística, Random Forest o XGBoost. |
| **Evaluación** | Accuracy, Precision, Recall, F1-score, ROC-AUC y tasa de abandono. |
| **Integración propuesta** | Endpoint de churn usado por el sistema de notificaciones y análisis administrativo. |
| **Beneficio** | Mejor retención y reactivación menos invasiva. |
| **Riesgos** | Manipulación, exceso de notificaciones y uso invasivo de comportamiento. |
| **Consideración ética** | Permitir control de notificaciones y baja voluntaria. |

---

## 3.8 Estimación de calidad del sueño

| Elemento | Descripción |
|---|---|
| **Nombre** | Estimación de calidad del sueño |
| **Tipo** | Regresión supervisada o clasificación ordinal |
| **Problema** | El sueño influye en energía, síntomas, estrés y bienestar general. |
| **Usuario beneficiado** | Usuario que registra hábitos y calidad del sueño. |
| **Datos necesarios** | Horas de sueño, hora de dormir, estrés, actividad, cafeína, uso nocturno, síntomas y estado de ánimo. |
| **Entradas** | Registros diarios relacionados con sueño y contexto. |
| **Salida** | Puntaje de calidad o clase mala, regular o buena. |
| **Algoritmo sugerido** | Random Forest Regressor, Gradient Boosting o red neuronal. |
| **Evaluación** | MAE, RMSE y R²; para clasificación ordinal, F1-score y matriz de confusión. |
| **Integración propuesta** | Endpoint de puntuación de sueño consumido desde dashboard y recomendaciones. |
| **Beneficio** | Recomendaciones más personalizadas de higiene del sueño. |
| **Riesgos** | Variabilidad individual, autoinforme inexacto y asumir trastornos del sueño. |
| **Consideración ética** | No presentar el resultado como diagnóstico de un trastorno. |

---

## 3.9 Clasificación de riesgo de sedentarismo

| Elemento | Descripción |
|---|---|
| **Nombre** | Clasificación de riesgo de sedentarismo |
| **Tipo** | Clasificación binaria o multiclase supervisada |
| **Problema** | La actividad física baja y sostenida puede relacionarse con menor bienestar y energía. |
| **Usuario beneficiado** | Usuario que registra actividad o pasos. |
| **Datos necesarios** | Pasos, minutos activos, tiempo sentado, frecuencia de actividad, edad, IMC, sueño y metas. |
| **Entradas** | Registros de actividad y contexto personal. |
| **Salida** | Riesgo bajo, medio o alto. |
| **Algoritmo sugerido** | Árbol de Decisión, Random Forest o XGBoost. |
| **Evaluación** | Precision, Recall, F1-score, matriz de confusión y ROC-AUC. |
| **Integración propuesta** | Endpoint que alimente metas graduales, recordatorios y dashboard. |
| **Beneficio** | Intervenciones graduales y personalizadas. |
| **Riesgos** | Metas excesivas, ignorar condiciones personales y culpabilización. |
| **Consideración ética** | Adaptar las recomendaciones a las capacidades del usuario. |

---

## 3.10 Clasificación de mensajes sensibles del chatbot

| Elemento | Descripción |
|---|---|
| **Nombre** | Clasificación de mensajes sensibles del chatbot |
| **Tipo** | Clasificación supervisada de texto |
| **Problema** | El chatbot puede recibir mensajes sobre síntomas intensos, crisis emocionales o dudas médicas complejas. |
| **Usuario beneficiado** | Usuario del chatbot y equipo responsable de seguridad conversacional. |
| **Datos necesarios** | Texto, intención, palabras clave, historial conversacional, urgencia percibida y contexto de salud. |
| **Entradas** | Mensaje actual y contexto limitado de conversación. |
| **Salida** | Informativo, seguimiento, posible urgencia, apoyo emocional o fuera de alcance. |
| **Algoritmo sugerido** | BERT ligero, SVM, Naive Bayes o red neuronal. |
| **Evaluación** | Precision, Recall y F1-score por clase, con especial atención al Recall de casos sensibles. |
| **Integración propuesta** | Clasificador previo a la respuesta del chatbot para redirigir casos sensibles. |
| **Beneficio** | Mayor seguridad conversacional y respuestas responsables. |
| **Riesgos** | No detectar un caso sensible, exponer conversaciones o generar respuestas inadecuadas. |
| **Consideración ética** | No sustituir atención médica ni psicológica y ofrecer rutas de ayuda cuando corresponda. |

---

# 4. Propuestas de aprendizaje no supervisado

## 4.1 Segmentación de usuarios por hábitos de salud

| Elemento | Descripción |
|---|---|
| **Nombre** | Segmentación de usuarios por hábitos de salud |
| **Tipo** | Clustering |
| **Problema** | La plataforma necesita comprender perfiles de bienestar sin etiquetas previas. |
| **Usuario beneficiado** | Usuario que recibe recomendaciones personalizadas y equipo de producto. |
| **Datos necesarios** | Sueño, pasos, actividad, hidratación, alimentación, estado de ánimo y frecuencia de registro. |
| **Entradas** | Variables agregadas de hábitos. |
| **Salida** | Segmentos como activos, equilibrados, sedentarios, sueño irregular o hábitos incompletos. |
| **Algoritmo sugerido** | K-Means, Gaussian Mixture Models o clustering jerárquico. |
| **Evaluación** | Silhouette Score, Davies-Bouldin, inercia e interpretación de clusters. |
| **Integración propuesta** | Endpoint que asigne un segmento y devuelva descripción, distancia y versión del modelo. |
| **Beneficio** | Personalización de recomendaciones y paneles. |
| **Riesgos** | Etiquetas estigmatizantes y mala interpretación de clusters. |
| **Consideración ética** | Utilizar los grupos como apoyo interno y no como diagnóstico. |

---

## 4.2 Agrupación por patrones de síntomas

| Elemento | Descripción |
|---|---|
| **Nombre** | Agrupación por patrones de síntomas |
| **Tipo** | Clustering |
| **Problema** | Los síntomas pueden aparecer en combinaciones que no son evidentes manualmente. |
| **Usuario beneficiado** | Usuario y equipo de análisis preventivo. |
| **Datos necesarios** | Tipo, frecuencia, intensidad, duración, horario, hábitos y antecedentes. |
| **Entradas** | Vectores de síntomas y contexto. |
| **Salida** | Grupos recurrentes, ocasionales, estacionales o asociados a hábitos. |
| **Algoritmo sugerido** | DBSCAN, K-Means o HDBSCAN. |
| **Evaluación** | Silhouette Score, Davies-Bouldin, número de puntos ruido y análisis cualitativo. |
| **Integración propuesta** | Endpoint exploratorio para asignación de patrón y generación de reportes. |
| **Beneficio** | Mejor comprensión de tendencias y alertas preventivas. |
| **Riesgos** | Interpretar un cluster como enfermedad o causalidad. |
| **Consideración ética** | Presentar los resultados como patrones exploratorios. |

---

## 4.3 Identificación de perfiles emocionales

| Elemento | Descripción |
|---|---|
| **Nombre** | Identificación de perfiles emocionales |
| **Tipo** | Clustering y análisis exploratorio |
| **Problema** | El bienestar emocional varía y puede requerir seguimiento personalizado. |
| **Usuario beneficiado** | Usuario que registra estado emocional. |
| **Datos necesarios** | Estado de ánimo, estrés, energía, sueño, actividad, texto opcional y frecuencia. |
| **Entradas** | Registros emocionales agregados. |
| **Salida** | Perfiles como estabilidad, estrés recurrente, baja energía o alta variabilidad. |
| **Algoritmo sugerido** | K-Means, clustering jerárquico o HDBSCAN. |
| **Evaluación** | Silhouette Score, Davies-Bouldin y coherencia interpretativa. |
| **Integración propuesta** | Endpoint de perfil emocional para tendencias y recomendaciones. |
| **Beneficio** | Seguimiento emocional y recomendaciones más empáticas. |
| **Riesgos** | Estigmatización, privacidad y diagnóstico psicológico implícito. |
| **Consideración ética** | Proteger los datos emocionales y evitar etiquetas clínicas. |

---

## 4.4 Detección de anomalías en registros de salud

| Elemento | Descripción |
|---|---|
| **Nombre** | Detección de anomalías en registros de salud |
| **Tipo** | Detección de anomalías no supervisada |
| **Problema** | Pueden existir cambios repentinos en síntomas, hábitos o signos vitales que merezcan revisión. |
| **Usuario beneficiado** | Usuario que requiere seguimiento preventivo. |
| **Datos necesarios** | Síntomas, intensidad, sueño, actividad, signos vitales disponibles, estado de ánimo y frecuencia de uso. |
| **Entradas** | Registros actuales y patrón histórico del usuario. |
| **Salida** | Puntaje de anomalía o registro atípico. |
| **Algoritmo sugerido** | Isolation Forest, autoencoder o DBSCAN. |
| **Evaluación** | Tasa de anomalías, estabilidad, revisión de casos y métricas con etiquetas sintéticas cuando existan. |
| **Integración propuesta** | Endpoint que devuelva puntaje, explicación básica y necesidad de confirmar datos. |
| **Beneficio** | Detección temprana de cambios importantes. |
| **Riesgos** | Falsas alarmas, datos incorrectos y alarmismo. |
| **Consideración ética** | Confirmar con el usuario antes de generar conclusiones. |

---

## 4.5 Reglas de asociación entre hábitos y síntomas

| Elemento | Descripción |
|---|---|
| **Nombre** | Reglas de asociación entre hábitos y síntomas |
| **Tipo** | Reglas de asociación |
| **Problema** | Puede haber relaciones frecuentes entre sueño, hidratación, estrés y malestares recurrentes. |
| **Usuario beneficiado** | Usuario y equipo de análisis de bienestar. |
| **Datos necesarios** | Registros diarios de hábitos, síntomas, intensidad, horario, sueño, actividad e hidratación. |
| **Entradas** | Transacciones o conjuntos de eventos por día o periodo. |
| **Salida** | Reglas frecuentes entre hábitos y síntomas. |
| **Algoritmo sugerido** | Apriori o FP-Growth. |
| **Evaluación** | Soporte, confianza y lift. |
| **Integración propuesta** | Servicio analítico que genere recomendaciones basadas en asociaciones observadas. |
| **Beneficio** | Consejos preventivos y preguntas de seguimiento más relevantes. |
| **Riesgos** | Confundir asociación con causalidad y generar conclusiones excesivas. |
| **Consideración ética** | Aclarar que una asociación no demuestra causa. |

---

## 4.6 Segmentación por comportamiento de uso de la aplicación

| Elemento | Descripción |
|---|---|
| **Nombre** | Segmentación por comportamiento de uso de la aplicación |
| **Tipo** | Clustering de comportamiento digital |
| **Problema** | Los usuarios no aprovechan las mismas funcionalidades ni interactúan de la misma forma. |
| **Usuario beneficiado** | Usuario final y equipo de UX/producto. |
| **Datos necesarios** | Logins, módulos visitados, duración de sesión, chatbot, registros y notificaciones abiertas. |
| **Entradas** | Variables agregadas de interacción. |
| **Salida** | Usuarios intensivos, ocasionales, centrados en chatbot, centrados en hábitos o inactivos. |
| **Algoritmo sugerido** | K-Means o Gaussian Mixture Models. |
| **Evaluación** | Silhouette Score, Davies-Bouldin, inercia y estabilidad de segmentos. |
| **Integración propuesta** | Endpoint administrativo o proceso batch para personalizar navegación y tutoriales. |
| **Beneficio** | Mejor experiencia de usuario y retención. |
| **Riesgos** | Seguimiento invasivo y uso de patrones para presionar al usuario. |
| **Consideración ética** | Respetar privacidad y limitar el uso de telemetría. |

---

## 4.7 Análisis de temas del chatbot

| Elemento | Descripción |
|---|---|
| **Nombre** | Análisis de temas del chatbot |
| **Tipo** | Modelado de temas no supervisado |
| **Problema** | El equipo necesita conocer las dudas más frecuentes para mejorar contenido y respuestas. |
| **Usuario beneficiado** | Usuarios del chatbot y equipo de contenido. |
| **Datos necesarios** | Texto anonimizado, intención aproximada, fecha, módulo de origen y contexto de uso. |
| **Entradas** | Mensajes anonimizados y preprocesados. |
| **Salida** | Temas frecuentes como sueño, estrés, alimentación, síntomas, aplicación o hábitos. |
| **Algoritmo sugerido** | LDA, BERTopic o clustering de embeddings. |
| **Evaluación** | Coherencia de temas, diversidad, similitud semántica y revisión humana. |
| **Integración propuesta** | Proceso analítico para actualizar FAQ, contenido educativo y flujos conversacionales. |
| **Beneficio** | Mejora del chatbot y de la base de conocimiento. |
| **Riesgos** | Exposición de texto sensible y temas mal interpretados. |
| **Consideración ética** | Anonimizar textos y eliminar identificadores antes del análisis. |

---

## 4.8 Mapa de bienestar con reducción de dimensionalidad

| Elemento | Descripción |
|---|---|
| **Nombre** | Mapa de bienestar con reducción de dimensionalidad |
| **Tipo** | Reducción de dimensionalidad |
| **Problema** | Los datos de bienestar pueden contener muchas variables difíciles de interpretar. |
| **Usuario beneficiado** | Equipo de análisis, administradores y usuarios mediante visualizaciones agregadas. |
| **Datos necesarios** | Síntomas, hábitos, sueño, actividad, estado emocional, uso de app y recomendaciones. |
| **Entradas** | Matriz estandarizada de variables. |
| **Salida** | Representación reducida y variables principales. |
| **Algoritmo sugerido** | PCA, UMAP o t-SNE. |
| **Evaluación** | Varianza explicada, número de componentes, conservación de estructura y utilidad visual. |
| **Integración propuesta** | Visualización agregada en dashboard administrativo o análisis EDA. |
| **Beneficio** | Facilitar análisis exploratorio y detección de grupos. |
| **Riesgos** | Sobreinterpretación de visualizaciones y exposición de identidades. |
| **Consideración ética** | Mostrar resultados agregados y proteger identidad. |

---

## 4.9 Clustering de rutinas de bienestar

| Elemento | Descripción |
|---|---|
| **Nombre** | Clustering de rutinas de bienestar |
| **Tipo** | Clustering temporal o de series |
| **Problema** | El bienestar depende de combinaciones de hábitos, no de una sola variable. |
| **Usuario beneficiado** | Usuario que registra rutinas diarias. |
| **Datos necesarios** | Sueño, hora de dormir, pasos, actividad, estrés, energía y estado de ánimo por día. |
| **Entradas** | Series o secuencias diarias de hábitos. |
| **Salida** | Rutinas estables, irregulares, activas, sedentarias o de alto estrés. |
| **Algoritmo sugerido** | K-Means, DTW Clustering o HDBSCAN. |
| **Evaluación** | Silhouette Score, estabilidad temporal y coherencia de perfiles. |
| **Integración propuesta** | Servicio para ajustar horarios de recordatorios y metas. |
| **Beneficio** | Recomendaciones adaptadas a la rutina real. |
| **Riesgos** | Juicios negativos, datos incompletos y patrones inestables. |
| **Consideración ética** | Presentar rutinas como información para mejora gradual. |

---

## 4.10 Perfiles preventivos de seguimiento sin diagnóstico

| Elemento | Descripción |
|---|---|
| **Nombre** | Perfiles preventivos de seguimiento sin diagnóstico |
| **Tipo** | Clustering y detección de anomalías |
| **Problema** | La plataforma necesita orientar seguimiento sin convertir patrones en diagnósticos. |
| **Usuario beneficiado** | Usuario que recibe orientación preventiva. |
| **Datos necesarios** | Síntomas recurrentes, hábitos, sueño, estrés, signos vitales, antecedentes y uso de app. |
| **Entradas** | Perfil agregado y registros recientes. |
| **Salida** | Seguimiento básico, hábitos deteriorados, estrés recurrente o registro atípico. |
| **Algoritmo sugerido** | HDBSCAN, autoencoder o PCA + K-Means. |
| **Evaluación** | Silhouette Score, Davies-Bouldin, estabilidad, error de reconstrucción y revisión humana. |
| **Integración propuesta** | Endpoint no supervisado para asignar perfil preventivo y registrar inferencia. |
| **Beneficio** | Alertas responsables y reducción de falsos avisos. |
| **Riesgos** | Presentar perfiles como diagnósticos, discriminación y falsas alarmas. |
| **Consideración ética** | Requerir validación clínica antes de cualquier uso real. |

---

# 5. Escenario esperado de resultados

El documento fuente plantea los siguientes resultados como **estimaciones académicas**, no como resultados obtenidos:

- Mejora percibida de personalización entre 25 % y 40 %.
- Reducción de patrones no atendidos entre 15 % y 25 %.
- Aumento de adherencia a hábitos entre 20 % y 35 %.
- Mejora de relevancia de alertas entre 18 % y 30 %.
- Reducción de abandono entre 10 % y 20 %.
- Mejora de utilidad percibida del chatbot entre 20 % y 35 %.

> Estos porcentajes no deben publicarse como métricas reales hasta realizar pruebas piloto, evaluación técnica y validación con datos.

---

# 6. Decisiones que podrían sustentarse

Los mecanismos propuestos podrían apoyar decisiones como:

1. Personalizar recomendaciones.
2. Generar alertas preventivas.
3. Recomendar consulta profesional cuando existan señales persistentes.
4. Ajustar la frecuencia de recordatorios.
5. Detectar riesgo de abandono.
6. Mejorar el chatbot con preguntas frecuentes.
7. Crear contenido educativo.
8. Diseñar dashboards personalizados.
9. Segmentar usuarios sin revelar identidades.
10. Optimizar la interfaz.
11. Priorizar módulos.
12. Analizar asociaciones entre hábitos y síntomas.
13. Ajustar metas.
14. Confirmar registros atípicos.
15. Evaluar recomendaciones aceptadas.
16. Definir políticas de privacidad.
17. Mejorar la base de conocimiento.
18. Crear indicadores agregados.
19. Validar modelos antes de funciones sensibles.
20. Documentar límites del sistema.

---

# 7. Selección preliminar para implementación

La guía requiere desplegar un mecanismo supervisado y uno no supervisado.

## 7.1 Candidatos supervisados

- Clasificación preventiva del nivel de prioridad de síntomas.
- Clasificación de alerta preventiva responsable.
- Clasificación de riesgo de sedentarismo.
- Estimación de adherencia a hábitos saludables.

## 7.2 Candidatos no supervisados

- Segmentación de usuarios por hábitos de salud.
- Detección de anomalías en registros de salud.
- Mapa de bienestar con PCA.
- Perfiles preventivos de seguimiento sin diagnóstico.

La selección definitiva deberá basarse en:

- Disponibilidad y calidad de datos.
- Utilidad para el usuario.
- Métricas obtenidas.
- Interpretabilidad.
- Velocidad.
- Riesgo.
- Viabilidad de integración.
- Capacidad para explicar el resultado.

---

# 8. Consideraciones éticas, de privacidad y seguridad

- Utilizar datos sintéticos o debidamente anonimizados.
- Solicitar consentimiento cuando se utilicen datos reales.
- Minimizar datos.
- Aplicar cifrado, autenticación y control de acceso.
- No sustituir diagnóstico ni atención profesional.
- Evaluar sesgos.
- Validar los modelos antes de desplegarlos.
- Mantener supervisión humana en casos sensibles.
- Agregar resultados para reportes administrativos.
- Permitir consultar, corregir o eliminar datos cuando corresponda.
- Evitar alertas alarmistas.
- Mostrar limitaciones y nivel de confianza.
- No presentar correlaciones como causalidad.
- Proteger especialmente datos emocionales y conversaciones.

---

# 9. Estado del documento

| Elemento | Estado |
|---|---|
| 10 propuestas supervisadas | Documentadas |
| 10 propuestas no supervisadas | Documentadas |
| Algoritmos sugeridos | Documentados |
| Variables necesarias | Documentadas |
| Evaluaciones posibles | Documentadas |
| Integración propuesta | Preliminar |
| Modelo supervisado definitivo | Pendiente de evaluación |
| Modelo no supervisado definitivo | Pendiente de evaluación |
| Métricas reales | Pendientes |
| Endpoints finales | Pendientes |
