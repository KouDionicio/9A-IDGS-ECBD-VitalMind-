# Ética, Privacidad y Uso Responsable — VitalMind AI

## 1. Propósito

VitalMind AI trabaja con información relacionada con salud, hábitos y bienestar. Este documento establece criterios para tratar esos datos y los resultados de Machine Learning de forma responsable dentro del proyecto académico.


## 2. Alcance

Aplica a:

- aplicación Android en Kotlin;
- smartwatch Wear OS y comunicación Bluetooth;
- backend y API;
- MySQL;
- datasets;
- ETL;
- modelos supervisados y no supervisados;
- chatbot;
- dashboard;
- reportes y alertas;
- pruebas y registros de auditoría.

## 3. Datos utilizados y necesidad

Los modelos actuales utilizan datos sintéticos de:

- edad, estatura y peso;
- hidratación;
- actividad física;
- sueño;
- alimentación;
- meditación;
- dolor;
- temperatura;
- presión arterial;
- glucosa;
- frecuencia cardiaca;
- estado de ánimo;
- estrés;
- energía;
- calidad del sueño.

Cada variable se utiliza porque forma parte del problema analítico definido. Identificadores, variables exclusivas de simulación y puntajes que producirían fuga de información se excluyen del entrenamiento.


## 4. Principios

### 4.1 Finalidad

Solo deben recopilarse datos necesarios para una función o análisis definido.

### 4.2 Minimización

No se debe enviar al backend, al servicio de IA o a un proveedor externo información que no sea necesaria.

### 4.3 Transparencia

La persona usuaria debe poder distinguir:

- dato registrado manualmente;
- dato proveniente del smartwatch;
- indicador calculado;
- predicción;
- recomendación por reglas;
- respuesta generativa.

### 4.4 Control

El alcance actual utiliza una cuenta general que accede a sus propios datos.

### 4.5 Seguridad desde el diseño

Autenticación, validación, secretos, cifrado en tránsito y auditoría forman parte de la arquitectura.

## 5. Privacidad

Controles mínimos:

- no publicar `.env`;
- no almacenar contraseñas en texto plano;
- no registrar tokens completos;
- minimizar PII;
- separar datos reales y sintéticos;
- usar HTTPS/TLS fuera de desarrollo;
- limitar el acceso a datos propios;
- definir retención y eliminación;
- proteger respaldos;
- evitar enviar datos innecesarios al proveedor conversacional.

## 6. Wear OS, Bluetooth y permisos

La plataforma confirmada es Wear OS y la comunicación con la aplicación Android es mediante Bluetooth.

El modelo del smartwatch y la API o SDK de salud todavía no están definidos. Por ello:

- no deben solicitarse permisos de sensores inexistentes;
- no se debe afirmar que una métrica puede leerse hasta confirmar que el dispositivo la expone;
- la aplicación debe informar qué datos sincroniza;
- las mediciones deben guardar origen y fecha;
- la pérdida de conexión no debe provocar duplicados;
- Bluetooth no sustituye las medidas de seguridad de aplicación y backend.

## 7. Machine Learning

Los modelos se entrenaron con datos sintéticos. Sus métricas no equivalen a validación clínica.

### 7.1 Clasificación

`risk_level` es una etiqueta creada por reglas del proyecto. Una salida `high` no significa enfermedad ni emergencia.

### 7.2 Regresión

`wellbeing_score` es un objetivo sintético. Su escala resume reglas del dataset y no es un instrumento clínico.

### 7.3 Clustering

Los clusters de K-Means describen similitud estadística. No deben recibir nombres médicos, estigmatizantes ni permanentes.

### 7.4 PCA

La representación bidimensional conserva solo parte de la información y se utiliza para visualización.

### 7.5 Anomalías

Isolation Forest identifica rareza estadística. Su F1 bajo frente a la etiqueta sintética externa confirma que no debe utilizarse como conclusión de salud.

## 8. Sesgos posibles

La simulación incorpora decisiones del equipo sobre distribuciones, perfiles y reglas. Los sesgos pueden surgir por:

- rangos de edad elegidos;
- proporción de perfiles;
- relación artificial entre variables;
- reglas que generan objetivos;
- clases con distinta representación;
- ausencia de datos reales de Wear OS;
- diferencias futuras entre el dataset sintético y una población real.

Con datos reales deberían revisarse resultados por subgrupos técnicamente pertinentes y distribución de errores.

## 9. Intervención humana

Debe intervenir una persona responsable cuando:

- un resultado se quiera interpretar fuera del alcance académico;
- una recomendación parezca médica;
- una medición pueda estar afectada por error del dispositivo;
- exista una solicitud de cambio de tratamiento;
- el chatbot produzca una respuesta dudosa;
- una alerta pueda tener consecuencias sensibles;
- se decida incorporar datos reales.

La aplicación puede sugerir buscar valoración profesional cuando la persona tenga dudas o un valor le preocupe, sin determinar una causa.

## 10. Alertas

Las alertas deben ser informativas.

Adecuado:

> Se detectó un cambio respecto a los valores registrados. Revisa la medición y su contexto.

No adecuado:

> Tienes una enfermedad.

Las alertas no deben:

- diagnosticar;
- ordenar suspender o iniciar medicamentos;
- afirmar una causa;
- presentar una probabilidad como certeza.

## 11. Medicamentos

El módulo es digital y permite registrar medicamento, dosis, horario, recordatorio y confirmación manual.

No debe:

- decidir dosis;
- recomendar iniciar o suspender un medicamento;
- modificar un tratamiento;
- interpretar automáticamente una omisión como emergencia.

## 12. Chatbot

El chatbot utiliza Mistral AI.

Debe:

- explicar resultados disponibles;
- reconocer límites;
- evitar inventar mediciones;
- evitar inventar salidas de modelos;
- no diagnosticar;
- no prescribir;
- no enviar información personal innecesaria al proveedor.


## 13. Preguntas obligatorias de la guía

### ¿Qué datos se utilizan?

Datos sintéticos de perfil, hábitos, síntomas, mediciones y percepción de bienestar. La aplicación operacional también maneja cuenta, medicamentos, notificaciones y registros propios.

### ¿Por qué son necesarios?

Permiten entrenar y evaluar los mecanismos seleccionados y mostrar seguimiento de la información registrada.

### ¿Qué sesgos pueden existir?

Sesgos por reglas de simulación, distribuciones elegidas, representación de clases y diferencias futuras respecto a datos reales.

### ¿Qué usuarios pueden verse afectados?

La persona usuaria puede interpretar incorrectamente una alerta, un puntaje, una probabilidad o un cluster si la interfaz no explica su significado.

### ¿Qué decisiones no deben automatizarse?

Diagnósticos, prescripción, cambio de dosis, suspensión de medicamentos, interpretación clínica definitiva y decisiones sensibles basadas únicamente en un modelo.

### ¿Cuándo debe intervenir una persona?

Cuando se requiera interpretar un resultado de salud, validar una medición dudosa, resolver una respuesta sensible del chatbot o decidir cambios con impacto personal.

### ¿Qué limitaciones tiene el modelo?

Datos sintéticos, ausencia de validación clínica, objetivos construidos mediante reglas y falta de entrenamiento con mediciones reales de Wear OS.

## 14. Anonimización y trazabilidad

Los datasets usan identificadores sintéticos. En datos reales se deben reducir o seudonimizar identificadores cuando el análisis no necesite identidad.

El ML Service utiliza:

```text
request_id
user_id
analysis_date
model_versions
```

para trazabilidad. Estos campos no se usan como predictores.

## 15. Responsabilidades del equipo

El equipo debe:

- conocer las reglas de simulación;
- explicar las métricas;
- distinguir evidencia de planeación;
- no inventar resultados;
- proteger secretos;
- mantener documentación actualizada;
- revisar respuestas generativas;
- validar cambios antes de presentarlos;
- poder defender el funcionamiento del modelo y sus límites.

## 16. Conclusión

El uso responsable depende tanto de la seguridad técnica como de la interpretación. Los datos y modelos pueden apoyar el seguimiento personal, pero no deben automatizar decisiones médicas ni presentar resultados sintéticos como evidencia clínica.
