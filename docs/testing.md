# Pruebas — VitalMind AI

## 1. Objetivo

Comprobar la calidad de datos, servicios, modelos, persistencia e interfaces del proyecto y dejar separados los resultados ejecutados de los casos definidos para validación posterior.

## 2. Alcance

Se consideran:

- dataset y simulación;
- ETL;
- modelos supervisados;
- modelos no supervisados;
- API principal;
- autenticación y seguridad;
- persistencia MySQL;
- dashboard;
- interfaz móvil y wearable;
- chatbot;
- integración entre componentes;
- actualización automática de información.

## 3. Entorno y evidencia existente

El repositorio contiene reportes de backend e integración bajo `reports/`. Esos reportes registran pruebas realizadas en un entorno Docker con Backend + MySQL y un flujo Frontend + Backend + ML Service + MySQL. También existen pruebas automatizadas dentro de `ml-service/tests/` y scripts de validación.

En esta revisión documental se ejecutaron además:

- validación sintáctica de **68 archivos JavaScript** del directorio `vitalmind-api/src` y scripts: **68 correctos, 0 fallos**;
- compilación de **44 archivos Python** de `ml-service/app`, scripts y tests: **44 correctos, 0 fallos**;
- inferencia directa del servicio supervisado: ejecutada correctamente;
- inferencia directa de clustering: ejecutada correctamente;
- inferencia directa de anomalías: ejecutada correctamente;
- ejecución `pytest -q`: detenida durante la colección porque el entorno de revisión no tiene instalado el paquete `mistralai`; no se contabiliza la suite como aprobada en esta ejecución.

Los modelos serializados mostraron advertencias por diferencia entre la versión de scikit-learn con la que fueron guardados y la disponible en el entorno de revisión. La inferencia directa funcionó, pero el despliegue debe usar versiones compatibles con los artefactos.

## 4. Dataset

| ID | Entrada | Procedimiento | Resultado esperado | Estado |
|---|---|---|---|---|
| DAT-01 | Raw CSV | Contar filas | 5,000 registros | Verificado |
| DAT-02 | Raw CSV | Contar columnas | 34 columnas | Verificado |
| DAT-03 | Processed CSV | Contar filas | 5,000 registros | Verificado |
| DAT-04 | Processed CSV | Revisar nulos | 0 celdas nulas | Verificado |
| DAT-05 | Raw CSV | Revisar nulos controlados | 1,500 celdas nulas | Verificado |
| DAT-06 | Ambos | Revisar duplicados | 0 filas duplicadas | Verificado |
| DAT-07 | Dataset | Contar anomalías sintéticas | 150 registros | Verificado |

## 5. Simulación y ETL

| ID | Entrada | Procedimiento | Resultado esperado | Estado |
|---|---|---|---|---|
| ETL-01 | Script generador | Ejecutar con semilla 2026 | Dataset reproducible con misma versión | Caso definido |
| ETL-02 | Raw CSV | Aplicar limpieza | Processed conserva 5,000 filas | Verificado por artefactos |
| ETL-03 | Faltantes | Aplicar reglas de imputación | Processed sin nulos | Verificado |
| ETL-04 | Datos temporales | Dividir por fecha | Train 3,418; validación 731; test 851 | Verificado |
| ETL-05 | Train | Calcular imputadores | Estadísticas aprendidas solo con entrenamiento | Verificado en pipeline/documentación |

## 6. Modelos supervisados

### 6.1 Clasificación de riesgo

| Métrica | Resultado documentado |
|---|---:|
| Accuracy | 0.9048 |
| F1 macro | 0.9037 |
| ROC-AUC macro | 0.9808 |
| Recall `high` | 0.9130 |

### 6.2 Regresión de bienestar

| Métrica | Resultado documentado |
|---|---:|
| MAE | 3.1230 |
| RMSE | 3.8266 |
| R² | 0.9584 |

### 6.3 Smoke test ejecutado

Se cargaron los artefactos y se envió un registro válido al servicio de inferencia. El resultado devolvió clasificación de riesgo, probabilidades, puntaje de bienestar, BMI, recomendaciones y versiones de modelo sin excepción.

## 7. Modelos no supervisados

### 7.1 Clustering

Métricas documentadas:

```text
k = 2
Silhouette = 0.3615
Davies-Bouldin = 1.0408
Calinski-Harabasz = 184.4039
```

Smoke test ejecutado con un perfil válido:

```text
cluster_id = 1
profile = hábitos relativamente equilibrados
distance_to_centroid = 4.2736
model_version = 1.0.0
```

### 7.2 Detección de anomalías

La evaluación externa frente a la etiqueta sintética registra F1 = 0.1300, por lo que el modelo se mantiene como apoyo exploratorio.

Smoke test ejecutado:

```text
is_anomaly = false
raw_prediction = 1
decision_score = 0.105904
anomaly_score = -0.105904
model_version = 1.0.0
```

## 8. API principal y autenticación

El reporte `reports/test-backend/RESULT.md` documenta como satisfactorios:

- estado del entorno;
- conexión Backend-MySQL;
- estructura de usuarios;
- validación de datos;
- registro de usuario;
- persistencia;
- inicio de sesión correcto;
- rechazo de credenciales incorrectas;
- protección de endpoints.

Casos de aceptación:

| ID | Entrada | Procedimiento | Resultado esperado |
|---|---|---|---|
| API-01 | Registro válido | `POST /api/auth/register` | Cuenta creada sin exponer contraseña |
| API-02 | Login válido | `POST /api/auth/login` | Access/refresh token válidos |
| API-03 | Token ausente | Consultar ruta protegida | HTTP 401 |
| API-04 | Campo inválido | Enviar esquema incorrecto | Error controlado 4xx |
| API-05 | Síntoma válido | `POST /api/symptoms` | Registro persistido |
| API-06 | Hábito válido | `POST /api/habits` | Registro consultable |
| API-07 | Solicitud ML | `POST /api/ml/analyze` | Respuesta del ML Service |

## 9. Persistencia

El reporte de backend contiene evidencia de inserción y consulta en MySQL. Los repositorios de la API encapsulan acceso a usuarios, hábitos, síntomas, medicamentos, notificaciones, historial y tokens.

Criterios:

- una operación válida debe persistir;
- una lectura posterior debe recuperar el dato;
- el usuario debe operar sobre datos permitidos por el control de acceso;
- los reintentos no deben crear duplicados cuando la operación sea idempotente.

## 10. Integración

`reports/test-integration/RESULT.md` registra pruebas satisfactorias de:

- login;
- registro de síntomas;
- visualización en resumen/historial;
- insights de IA;
- chatbot;
- flujo Frontend → Backend → MySQL / ML Service → Backend → Frontend.

La evidencia visual de la aplicación se conserva además en `docs/assets/capturas-aplicacion/`.

## 11. Dashboard y seis visualizaciones mínimas

El dashboard independiente de `vitalmind-api/dashboard/index.html` contiene **lienzos de gráficas**. Para el requisito mínimo de seis se consideran:

| ID | Gráfica | Fuente API | Resultado esperado |
|---|---|---|---|
| DASH-01 | Actividad física | `/api/dashboard/physical-activity` | Línea con minutos por fecha |
| DASH-02 | Sueño | `/api/dashboard/sleep-history` | Línea con horas por fecha |
| DASH-03 | Consumo de agua | `/api/dashboard/water-consumption` | Serie diaria |
| DASH-04 | Glucosa | `/api/dashboard/glucose-history` | Serie con mg/dL |
| DASH-05 | Presión arterial | `/api/dashboard/blood-pressure` | Series sistólica/diastólica |
| DASH-06 | Dolor | `/api/dashboard/pain-statistics` | Evolución del nivel de dolor |

El HTML también define gráficas de distribución de usuarios, medicamentos, citas, estado de ánimo y género/edad.

### Estados de interfaz

El código contempla:

- carga de datos mediante `fetch`;
- estado vacío para series sin información;
- caja de error cuando falla una solicitud;
- texto con hora de última actualización;
- reintento tras error.

## 12. Actualización automática y Socket.IO

El dashboard de la API ejecuta `loadAll()` y repite la carga cada **30,000 ms** mediante `setInterval`. Esto permite actualizar las gráficas sin recargar manualmente la página.

El frontend web incluye `socket.io-client`, lógica de conexión/reconexión y escucha del evento `notification:new`. Sin embargo, el backend contenido en esta entrega no incluye la dependencia `socket.io`, creación de servidor Socket.IO ni emisiones verificables. Por ello:

| Caso | Resultado esperado | Estado de esta versión |
|---|---|---|
| RT-01 | Dashboard se actualiza sin recarga manual | Implementado por polling cada 30 s |
| RT-02 | Cliente Socket.IO intenta reconexión | Implementado en frontend web |
| RT-03 | Backend emite eventos Socket.IO | No validado en esta versión |
| RT-04 | Seis gráficas cambian por evento push | No validado en esta versión |

La documentación no presenta RT-03 ni RT-04 como aprobados.

## 13. Smartwatch y Bluetooth

Casos de prueba recomendados para dispositivo físico:

| ID | Entrada | Procedimiento | Resultado esperado |
|---|---|---|---|
| SW-01 | Teléfono + reloj Wear OS | Vincular ambos | Conexión disponible |
| SW-02 | Permisos de sensor | Autorizar lectura | Métrica accesible cuando el sensor la soporte |
| SW-03 | Frecuencia cardiaca | Iniciar captura | Valor recibido con marca temporal |
| SW-04 | Pasos | Generar actividad | Conteo actualizado |
| SW-05 | Interrupción Bluetooth | Desconectar y reconectar | Recuperación controlada |
| SW-06 | Dato duplicado | Reenviar misma medición | Evitar duplicación según identificador/tiempo |

El código wearable contiene `HeartRateManager`, `StepsManager`, Google Play Services Wearable y Health Services Client.

## 14. Interfaz y usabilidad

Casos:

- navegación inferior;
- formularios con etiquetas visibles;
- registro de mediciones;
- selección de estado emocional;
- historial;
- chatbot;
- perfil;
- errores de red;
- contraste y legibilidad;
- adaptación a pantalla móvil.

Capturas de referencia:

![Registro](./assets/capturas-aplicacion/07-registro-mediciones.png)

![Chat](./assets/capturas-aplicacion/09-chat-vitalmind.png)

## 15. Criterios de aceptación

- No exponer secretos ni contraseñas.
- Rechazar entradas inválidas de forma controlada.
- Mantener los datos sintéticos identificados como tales.
- Mostrar unidades y contexto en visualizaciones.
- No convertir las salidas ML en diagnóstico.
- Conservar evidencia para toda prueba marcada como ejecutada.
- Repetir pruebas afectadas después de un cambio.

## 16. Comandos de validación usados en esta revisión

```bash
# Python
python -m pytest -q

# Validación sintáctica JavaScript
node --check <archivo.js>

# Compilación Python
python -m py_compile <archivo.py>
```

La ejecución de `pytest -q` en el entorno de revisión se detuvo durante la colección por ausencia local de `mistralai`. El proyecto declara esa dependencia en sus requisitos; la guía de ejecución indica instalar las dependencias antes de lanzar la suite.

## 17. Conclusión

El proyecto cuenta con evidencia ejecutada para backend, persistencia, integración funcional básica y modelos. El dashboard dispone de actualización automática por polling y supera el mínimo de seis gráficas. La comunicación Socket.IO del lado cliente está preparada, mientras que el flujo push desde el backend no se considera validado en esta versión.
