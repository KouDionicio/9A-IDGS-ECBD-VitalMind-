# Propuestas de Aplicación de Machine Learning — VitalMind AI

## 1. Propósito

Antes de elegir los mecanismos que se integrarán al prototipo se analizaron veinte posibilidades de extracción de conocimiento: diez supervisadas y diez no supervisadas. Cada propuesta se documenta con los campos mínimos solicitados por la guía oficial.


## 2. Criterios de viabilidad

Una propuesta se considera viable cuando:

- utiliza datos disponibles o puede señalar claramente qué fuente falta;
- produce una salida comprensible;
- puede evaluarse con métricas apropiadas;
- tiene un caso de uso dentro de la aplicación o del análisis;
- puede exponerse mediante una API sin convertir la salida en una decisión médica;
- respeta privacidad y minimización de datos.

## 3. Propuestas de aprendizaje supervisado

### 3.1 Clasificación preventiva de riesgo
| Elemento | Descripción |
|---|---|
| Nombre | Clasificación preventiva de riesgo |
| Tipo | Supervisado |
| Problema | Resumir combinaciones de hábitos, percepción y mediciones en un nivel preventivo de riesgo sintético. |
| Usuario beneficiado | Persona usuaria y equipo de análisis. |
| Datos necesarios | Hábitos, dolor, temperatura, presión arterial, frecuencia cardiaca, estado de ánimo, estrés, energía y sueño. |
| Entradas | 19 características originales o calculables en inferencia. |
| Salida | Clase `low`, `medium` o `high` y probabilidades. |
| Algoritmo sugerido | Regresión Logística; Random Forest como alternativa comparada. |
| Evaluación | Accuracy, F1 macro, recall de `high`, ROC-AUC y matriz de confusión. |
| Integración | `POST /api/v1/analyze` mediante FastAPI y backend. |
| Riesgos | Sobreinterpretar la etiqueta como diagnóstico; datos sintéticos. |
| Estado | Implementada y evaluada. |

### 3.2 Estimación de bienestar
| Elemento | Descripción |
|---|---|
| Nombre | Estimación de bienestar |
| Tipo | Supervisado |
| Problema | Obtener un resumen numérico del bienestar sintético a partir de variables registradas. |
| Usuario beneficiado | Persona usuaria y equipo de análisis. |
| Datos necesarios | Perfil, hábitos, síntomas, mediciones y percepción. |
| Entradas | Las mismas 19 características del pipeline supervisado. |
| Salida | `wellbeing_score` estimado y nivel derivado. |
| Algoritmo sugerido | Ridge Regression; Random Forest Regressor y Dummy Regressor como comparadores. |
| Evaluación | MAE, RMSE, R² y error absoluto mediano. |
| Integración | Resultado incluido en `POST /api/v1/analyze`. |
| Riesgos | El objetivo fue generado mediante reglas; el R² no implica validez clínica. |
| Estado | Implementada y evaluada. |

### 3.3 Estimación de recurrencia de síntomas
| Elemento | Descripción |
|---|---|
| Nombre | Estimación de recurrencia de síntomas |
| Tipo | Supervisado |
| Problema | Identificar la probabilidad de que un síntoma registrado vuelva a aparecer dentro de una ventana definida. |
| Usuario beneficiado | Persona usuaria. |
| Datos necesarios | Historial de síntomas, intensidad, fecha, hábitos y mediciones asociadas. |
| Entradas | Frecuencia previa, intensidad, días entre registros y contexto disponible. |
| Salida | Probabilidad o categoría de recurrencia. |
| Algoritmo sugerido | Regresión Logística, Random Forest o modelo temporal sencillo. |
| Evaluación | Precision, recall, F1 y calibración. |
| Integración | Endpoint futuro consultado desde el historial. |
| Riesgos | Confundir recurrencia estadística con causa o pronóstico. |
| Estado | Propuesta. |

### 3.4 Estimación de continuidad de hábitos
| Elemento | Descripción |
|---|---|
| Nombre | Estimación de continuidad de hábitos |
| Tipo | Supervisado |
| Problema | Analizar si un patrón de registro de hábitos tiende a mantenerse durante una ventana próxima. |
| Usuario beneficiado | Persona usuaria. |
| Datos necesarios | Hidratación, actividad, sueño, alimentación, meditación y secuencia temporal. |
| Entradas | Historial agregado de hábitos y regularidad de registro. |
| Salida | Probabilidad o nivel de continuidad. |
| Algoritmo sugerido | Regresión Logística, Random Forest o Gradient Boosting. |
| Evaluación | F1, ROC-AUC, calibración y desempeño por periodo. |
| Integración | Apoyo para resúmenes y recordatorios configurables. |
| Riesgos | Convertir la salida en juicio de comportamiento o generar notificaciones invasivas. |
| Estado | Propuesta. |

### 3.5 Clasificación orientativa del estado de ánimo
| Elemento | Descripción |
|---|---|
| Nombre | Clasificación orientativa del estado de ánimo |
| Tipo | Supervisado |
| Problema | Explorar si variables de sueño, energía, estrés y dolor permiten aproximar la categoría de estado de ánimo reportada. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | Sueño, energía, estrés, dolor, actividad y estado de ánimo histórico. |
| Entradas | Variables de contexto sin incluir la etiqueta objetivo. |
| Salida | Categoría estimada de estado de ánimo. |
| Algoritmo sugerido | Regresión Logística multinomial o Random Forest. |
| Evaluación | F1 macro, precisión por clase y matriz de confusión. |
| Integración | Uso analítico; no sustituye el dato declarado por la persona. |
| Riesgos | Invalidar la percepción del usuario o presentar una inferencia como hecho. |
| Estado | Propuesta. |

### 3.6 Priorización supervisada de recomendaciones
| Elemento | Descripción |
|---|---|
| Nombre | Priorización supervisada de recomendaciones |
| Tipo | Supervisado |
| Problema | Ordenar recomendaciones generales según la utilidad estimada para distintos patrones de uso. |
| Usuario beneficiado | Persona usuaria. |
| Datos necesarios | Historial de hábitos, contexto y retroalimentación sobre recomendaciones previas. |
| Entradas | Características de seguimiento y respuesta a recomendaciones. |
| Salida | Ranking de sugerencias permitidas por el producto. |
| Algoritmo sugerido | Clasificación, ranking o aprendizaje contextual. |
| Evaluación | Precision@k, tasa de aceptación y estabilidad. |
| Integración | Capa posterior al motor de recomendaciones. |
| Riesgos | Generar sugerencias que parezcan indicaciones médicas. |
| Estado | Propuesta; actualmente existen reglas explícitas. |

### 3.7 Clasificación de alerta informativa
| Elemento | Descripción |
|---|---|
| Nombre | Clasificación de alerta informativa |
| Tipo | Supervisado |
| Problema | Distinguir cambios normales de registros que justifican un aviso informativo. |
| Usuario beneficiado | Persona usuaria. |
| Datos necesarios | Historial, tendencias, mediciones, hábitos y síntomas. |
| Entradas | Cambios respecto al patrón reciente y variables disponibles. |
| Salida | Sin alerta, aviso informativo o revisión sugerida. |
| Algoritmo sugerido | Regresión Logística, Random Forest o Gradient Boosting. |
| Evaluación | Recall de eventos prioritarios, precision y tasa de falsos avisos. |
| Integración | Módulo de notificaciones. |
| Riesgos | Alarmismo, falsa seguridad o exceso de notificaciones. |
| Estado | Propuesta relacionada con el clasificador actual. |

### 3.8 Riesgo de inactividad en la aplicación
| Elemento | Descripción |
|---|---|
| Nombre | Riesgo de inactividad en la aplicación |
| Tipo | Supervisado |
| Problema | Identificar periodos en los que una persona deja de registrar información durante un intervalo prolongado. |
| Usuario beneficiado | Equipo de producto y persona usuaria. |
| Datos necesarios | Sesiones, frecuencia de registros, recordatorios atendidos y días sin actividad, solo con telemetría autorizada. |
| Entradas | Frecuencia de uso y recencia. |
| Salida | Nivel de riesgo de inactividad. |
| Algoritmo sugerido | Regresión Logística o Random Forest. |
| Evaluación | F1, ROC-AUC y calibración. |
| Integración | Recordatorios de uso no invasivos. |
| Riesgos | Telemetría excesiva y seguimiento innecesario. |
| Estado | Propuesta; no existe dataset de telemetría documentado. |

### 3.9 Estimación de calidad del sueño
| Elemento | Descripción |
|---|---|
| Nombre | Estimación de calidad del sueño |
| Tipo | Supervisado |
| Problema | Aproximar un puntaje de descanso cuando se disponga de variables suficientes. |
| Usuario beneficiado | Persona usuaria. |
| Datos necesarios | Duración de sueño, calidad reportada, actividad, estrés y energía. |
| Entradas | Variables de descanso y contexto. |
| Salida | Puntaje o categoría orientativa. |
| Algoritmo sugerido | Ridge, Random Forest Regressor o Gradient Boosting Regressor. |
| Evaluación | MAE, RMSE y R². |
| Integración | Resumen diario y gráficas. |
| Riesgos | Presentar la estimación como medición clínica del sueño. |
| Estado | Propuesta; el dataset contiene `sleep_score` sintético. |

### 3.10 Clasificación de consultas sensibles del chatbot
| Elemento | Descripción |
|---|---|
| Nombre | Clasificación de consultas sensibles del chatbot |
| Tipo | Supervisado |
| Problema | Detectar solicitudes que exceden el alcance informativo del asistente. |
| Usuario beneficiado | Persona usuaria y equipo responsable del servicio. |
| Datos necesarios | Texto de consulta y contexto mínimo necesario. |
| Entradas | Mensaje normalizado y señales de seguridad. |
| Salida | Consulta general, solicitud de diagnóstico, cambio de tratamiento u otra categoría sensible. |
| Algoritmo sugerido | Clasificador de texto combinado con reglas. |
| Evaluación | Recall de clases sensibles, F1 y revisión manual. |
| Integración | Capa previa a Mistral AI. |
| Riesgos | No detectar una solicitud sensible o bloquear consultas normales. |
| Estado | Propuesta de refuerzo; el prompt actual ya establece límites. |



## 4. Propuestas de aprendizaje no supervisado

### 4.1 Segmentación de perfiles de bienestar
| Elemento | Descripción |
|---|---|
| Nombre | Segmentación de perfiles de bienestar |
| Tipo | No supervisado |
| Problema | Descubrir grupos estadísticos de usuarios sintéticos con patrones agregados similares. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | Perfil, hábitos, síntomas, mediciones, percepción y conteo de registros. |
| Entradas | 20 características agregadas por usuario. |
| Salida | Identificador de cluster y perfil estadístico. |
| Algoritmo sugerido | K-Means; GMM y HDBSCAN como alternativas posibles. |
| Evaluación | Silhouette, Davies-Bouldin, Calinski-Harabasz, inercia y estabilidad. |
| Integración | Mecanismo seleccionado para un endpoint no supervisado futuro. |
| Riesgos | Convertir clusters en etiquetas personales o médicas. |
| Estado | Implementada con K-Means (`k = 2`); endpoint pendiente. |

### 4.2 Agrupación por patrones de síntomas y mediciones
| Elemento | Descripción |
|---|---|
| Nombre | Agrupación por patrones de síntomas y mediciones |
| Tipo | No supervisado |
| Problema | Encontrar combinaciones recurrentes de dolor, temperatura, frecuencia cardiaca y otras mediciones. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | Síntomas y mediciones normalizadas. |
| Entradas | Variables físicas y frecuencia de registro. |
| Salida | Clusters de observaciones con comportamiento similar. |
| Algoritmo sugerido | K-Means o HDBSCAN. |
| Evaluación | Silhouette, estabilidad y análisis descriptivo. |
| Integración | Exploración del historial agregado. |
| Riesgos | Confundir similitud estadística con una enfermedad. |
| Estado | Propuesta. |

### 4.3 Perfiles de bienestar emocional
| Elemento | Descripción |
|---|---|
| Nombre | Perfiles de bienestar emocional |
| Tipo | No supervisado |
| Problema | Explorar patrones multidimensionales formados por ánimo, estrés, energía y sueño. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | `mood`, `stress_level`, `energy_level`, `sleep_quality`. |
| Entradas | Variables emocionales normalizadas. |
| Salida | Grupos descriptivos. |
| Algoritmo sugerido | K-Means, GMM o HDBSCAN. |
| Evaluación | Silhouette, estabilidad y análisis de centroides. |
| Integración | Visualización agregada. |
| Riesgos | Etiquetas estigmatizantes o interpretaciones clínicas. |
| Estado | Propuesta. |

### 4.4 Detección de anomalías en registros
| Elemento | Descripción |
|---|---|
| Nombre | Detección de anomalías en registros |
| Tipo | No supervisado |
| Problema | Identificar observaciones que se alejan del patrón estadístico general. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | Variables numéricas preparadas. |
| Entradas | Características estandarizadas. |
| Salida | Indicador o puntaje de atipicidad. |
| Algoritmo sugerido | Isolation Forest; LOF o autoencoder como alternativas. |
| Evaluación | Comparación contra anomalías sintéticas, falsos positivos y revisión cualitativa. |
| Integración | Apoyo para revisión de datos, no para diagnóstico. |
| Riesgos | Interpretar rareza estadística como problema de salud. |
| Estado | Implementada de forma exploratoria con Isolation Forest. |

### 4.5 Reglas de asociación entre hábitos y síntomas
| Elemento | Descripción |
|---|---|
| Nombre | Reglas de asociación entre hábitos y síntomas |
| Tipo | No supervisado |
| Problema | Explorar combinaciones que aparecen juntas con frecuencia. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | Hábitos y síntomas discretizados. |
| Entradas | Transacciones o categorías por periodo. |
| Salida | Reglas de asociación. |
| Algoritmo sugerido | Apriori o FP-Growth. |
| Evaluación | Soporte, confianza y lift. |
| Integración | Reporte exploratorio. |
| Riesgos | Presentar asociación como causalidad. |
| Estado | Propuesta. |

### 4.6 Segmentación por comportamiento de uso
| Elemento | Descripción |
|---|---|
| Nombre | Segmentación por comportamiento de uso |
| Tipo | No supervisado |
| Problema | Descubrir patrones de interacción con módulos de la aplicación. |
| Usuario beneficiado | Equipo de producto. |
| Datos necesarios | Sesiones, módulos visitados, frecuencia de registro y uso de notificaciones, solo con telemetría autorizada. |
| Entradas | Características agregadas de uso. |
| Salida | Clusters de comportamiento. |
| Algoritmo sugerido | K-Means o GMM. |
| Evaluación | Silhouette y estabilidad. |
| Integración | Apoyo para mejorar navegación y contenido. |
| Riesgos | Seguimiento invasivo o uso excesivo de telemetría. |
| Estado | Propuesta; no existe dataset de telemetría. |

### 4.7 Agrupación temática de consultas del chatbot
| Elemento | Descripción |
|---|---|
| Nombre | Agrupación temática de consultas del chatbot |
| Tipo | No supervisado |
| Problema | Identificar temas recurrentes en consultas para mejorar contenido y límites del asistente. |
| Usuario beneficiado | Equipo de producto. |
| Datos necesarios | Mensajes anonimizados y minimizados. |
| Entradas | Representaciones de texto. |
| Salida | Temas o clusters de consultas. |
| Algoritmo sugerido | BERTopic, embeddings + clustering o LDA. |
| Evaluación | Coherencia, diversidad y revisión humana. |
| Integración | Mejora de preguntas frecuentes. |
| Riesgos | Exposición de conversaciones sensibles. |
| Estado | Propuesta; requiere política de anonimización. |

### 4.8 Mapa de bienestar con reducción de dimensionalidad
| Elemento | Descripción |
|---|---|
| Nombre | Mapa de bienestar con reducción de dimensionalidad |
| Tipo | No supervisado |
| Problema | Representar en dos dimensiones un conjunto de variables difícil de visualizar directamente. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | Perfiles agregados utilizados en clustering. |
| Entradas | Características estandarizadas. |
| Salida | Coordenadas bidimensionales. |
| Algoritmo sugerido | PCA; UMAP como alternativa. |
| Evaluación | Varianza explicada y utilidad de visualización. |
| Integración | EDA e interpretación de clusters. |
| Riesgos | Sobreinterpretar distancias en el plano. |
| Estado | PCA implementado como apoyo al clustering. |

### 4.9 Clustering de rutinas temporales
| Elemento | Descripción |
|---|---|
| Nombre | Clustering de rutinas temporales |
| Tipo | No supervisado |
| Problema | Explorar secuencias de hábitos y bienestar que no se resumen adecuadamente con promedios. |
| Usuario beneficiado | Equipo de análisis. |
| Datos necesarios | Series diarias por usuario. |
| Entradas | Secuencias de sueño, actividad, estrés y hábitos. |
| Salida | Patrones de rutina. |
| Algoritmo sugerido | Clustering temporal, DTW o HDBSCAN. |
| Evaluación | Estabilidad temporal y coherencia descriptiva. |
| Integración | Resúmenes de tendencias. |
| Riesgos | Pocos registros por usuario para patrones complejos. |
| Estado | Propuesta. |

### 4.10 Perfiles preventivos combinando clusters y atipicidad
| Elemento | Descripción |
|---|---|
| Nombre | Perfiles preventivos combinando clusters y atipicidad |
| Tipo | No supervisado |
| Problema | Resumir patrones generales y observaciones poco comunes sin utilizar etiquetas médicas. |
| Usuario beneficiado | Equipo de análisis y persona usuaria mediante resúmenes no diagnósticos. |
| Datos necesarios | Historial agregado de hábitos, síntomas y mediciones. |
| Entradas | Características de clustering y puntaje de anomalía. |
| Salida | Descripción estadística temporal. |
| Algoritmo sugerido | Clustering combinado con detección de anomalías. |
| Evaluación | Métricas internas, estabilidad y revisión cualitativa. |
| Integración | Resumen orientativo. |
| Riesgos | Etiquetar a la persona o convertir el perfil en conclusión clínica. |
| Estado | Propuesta. |



## 5. Comparación de implementaciones disponibles

| Mecanismo | Alternativas comparadas | Resultado |
|---|---|---|
| Clasificación | Regresión Logística vs Random Forest | Regresión Logística obtuvo mejor F1 y ROC-AUC en validación |
| Regresión | Ridge vs Random Forest Regressor vs Dummy | Ridge obtuvo menor error y mayor R² |
| Clustering | K-Means con `k` de 2 a 6 | `k = 2` obtuvo mejor Silhouette |
| Reducción | PCA 2D | 65.58 % de varianza explicada en perfiles agregados |
| Anomalías | Isolation Forest | Uso exploratorio; F1 externo = 0.1300 |


## 10. Conclusión

Las veinte propuestas muestran opciones diferentes y separan con claridad clasificación, regresión, agrupamiento, reducción de dimensionalidad, anomalías y análisis de comportamiento. La selección de Regresión Logística y K-Means mantiene una combinación defendible para el Proyecto Integrador.