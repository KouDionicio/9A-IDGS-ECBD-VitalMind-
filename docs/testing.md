# Pruebas — VitalMind AI

## 1. Propósito

Este documento organiza las pruebas solicitadas por la guía oficial y distingue entre evidencia verificable, código de prueba disponible y casos.

## 2. Componentes considerados

```text
Dataset sintético
Generador de simulación
ETL y preparación temporal
Modelos supervisados
Modelos no supervisados
ML Service FastAPI
Backend Node.js / Express
MySQL
Dashboard
Aplicación Android Kotlin
Smartwatch Wear OS
Bluetooth
Chatbot Mistral
```

## 3. Pruebas del dataset

Validaciones verificadas en los CSV:

| Caso | Raw | Processed |
|---|---:|---:|
| Registros | 5,000 | 5,000 |
| Columnas | 34 | 35 |
| Duplicados | 0 | 0 |
| Celdas nulas | 1,500 | 0 |
| `record_id` únicos | 5,000 | 5,000 |
| Anomalías marcadas | 150 | 150 |

Casos mínimos:

- estructura esperada;
- tipos convertibles;
- categorías válidas;
- cobertura temporal;
- distribución de clases;
- rangos;
- ausencia de duplicados;
- integridad `user_id + log_date`.

## 4. Pruebas de simulación

La simulación debe comprobar:

| ID | Caso | Resultado esperado | Estado |
|---|---|---|---|
| T-SIM-01 | Semilla 2026 | Reproducibilidad con misma versión y dependencias | Documentado |
| T-SIM-02 | Perfiles sintéticos | Distribuciones coherentes con reglas | Verificado mediante dataset |
| T-SIM-03 | Faltantes | 3 % por campo seleccionado | Verificado |
| T-SIM-04 | Anomalías | 3 % de registros marcados | Verificado |
| T-SIM-05 | Etiqueta de riesgo | Se aplica la regla y ajustes descritos | Documentado en código |
| T-SIM-06 | Casos frontera | Comportamiento cerca de 45 y 70 | Debe conservarse como prueba reproducible |
| T-SIM-07 | Valores extremos | Permanecen dentro de límites del generador | Verificación adicional recomendable |

La guía solicita evidencia de reproducibilidad. El script generador y la semilla están disponibles; cualquier cambio de versión debe volver a validarse.

## 5. Pruebas ETL

| ID | Caso | Resultado esperado | Estado |
|---|---|---|---|
| T-ETL-01 | Validar raw | Estructura y conteos correctos | Verificado |
| T-ETL-02 | Eliminar duplicados | No se pierden filas porque no existen duplicados | Verificado |
| T-ETL-03 | Imputar peso | 150 respaldos y `weight_source` | Verificado |
| T-ETL-04 | Completar numéricos | Processed sin nulos | Verificado |
| T-ETL-05 | Completar `mood` | Categorías válidas | Verificado |
| T-ETL-06 | Recalcular BMI | Coherencia con peso y estatura | Documentado |
| T-ETL-07 | Split temporal | Train, validation y test sin mezclar periodos | Verificado por archivos |
| T-ETL-08 | Imputación segura | Estadísticas aprendidas solo con train | Documentado en pipeline |
| T-ETL-09 | Repetición | Misma entrada produce salida coherente | Debe registrarse en ejecución formal |
| T-ETL-10 | Carga Data Mart | Hechos y dimensiones cargados | Pendiente; Data Mart no desplegado |

## 6. Pruebas de modelos supervisados

### 6.1 Clasificación

La Regresión Logística final fue evaluada sobre 851 registros:

| Métrica | Resultado |
|---|---:|
| Accuracy | 0.9048 |
| F1 macro | 0.9037 |
| ROC-AUC macro | 0.9808 |
| Recall `high` | 0.9130 |



### 6.2 Regresión

Ridge Regression:

| Métrica | Resultado |
|---|---:|
| MAE | 3.1230 |
| RMSE | 3.8266 |
| R² | 0.9584 |

### 6.3 Casos de robustez planificados

- campo imputable ausente;
- categoría inválida;
- valor fuera de rango;
- combinación extrema;
- comparación entre predicción y etiqueta;
- revisión de residuos;
- estabilidad con datos nuevos;
- latencia de inferencia.

## 7. Pruebas no supervisadas

### 7.1 K-Means

Se verificó la comparación de `k = 2` a `k = 6`. La configuración seleccionada tiene:

```text
Silhouette = 0.3615
Davies-Bouldin = 1.0408
Calinski-Harabasz = 184.4039
```


### 7.2 PCA

Se dispone de una representación 2D con varianza explicada aproximada de 65.58 %.

Debe comprobarse que el PCA se use como apoyo de visualización y no como etiqueta de usuario.

### 7.3 Isolation Forest

La comparación externa obtuvo:

```text
F1 = 0.1300
```

Por ello no debe utilizarse como único disparador de una alerta sensible.

## 8. Pruebas automatizadas disponibles

El ML Service contiene:

```text
tests/test_api.py
tests/test_chat.py
```

También existen scripts de prueba de inferencia y recomendaciones.

## 9. Backend

Casos funcionales:

| ID | Caso | Resultado esperado | Estado |
|---|---|---|---|
| T-BE-01 | Registrar cuenta | Cuenta creada sin exponer contraseña | Planificado |
| T-BE-02 | Iniciar sesión | Tokens válidos | Planificado |
| T-BE-03 | Renovar sesión | Nuevo acceso con refresh válido | Planificado |
| T-BE-04 | Consultar perfil | Solo datos propios | Planificado |
| T-BE-05 | Registrar hábito | Persistencia por fecha | Planificado |
| T-BE-06 | Registrar síntoma/medición | Persistencia de valores válidos | Planificado |
| T-BE-07 | Registrar medicamento | Nombre, dosis y horario digital | Planificado |
| T-BE-08 | Confirmar toma | Registro manual de estado | Planificado |
| T-BE-09 | Consultar historial | Recuperación correcta | Planificado |
| T-BE-10 | Notificación | Aviso asociado a la cuenta | Planificado |
| T-BE-11 | Consumir ML | Transformación y respuesta FastAPI | Planificado |
| T-BE-12 | Acceso ajeno | Solicitud rechazada | Planificado |


## 10. API inteligente

### 10.1 Salud

```http
GET /health
```

Debe confirmar disponibilidad sin exponer secretos.

### 10.2 Modelos

```http
GET /api/v1/models/info
```

Debe devolver versión y algoritmos cargados.

### 10.3 Endpoint supervisado

```http
POST /api/v1/analyze
```

Casos mínimos:

| Caso | Resultado esperado |
|---|---|
| Datos válidos | Riesgo, bienestar, BMI, recomendaciones y versiones |
| Campo indispensable ausente | 422 |
| Campo imputable ausente | Inferencia + `missing_data_report` |
| `mood` inválido | Error de validación |
| Tipo incorrecto | Error 4xx |
| Modelo no disponible | Error controlado |

### 10.4 Endpoint no supervisado

La guía exige un endpoint no supervisado y K-Means fue seleccionado como mecanismo.

Pruebas :

- entrada válida;
- columnas incompletas;
- normalización;
- cluster devuelto;
- versión del modelo;
- consistencia con el artefacto local;
- latencia;
- errores;
- persistencia de inferencia si se adopta ese requisito.

## 11. Chatbot

```http
POST /api/v1/chat
POST /api/v1/chat/analyze
```

Casos:

- pregunta general;
- explicación de resultado;
- solicitud de diagnóstico;
- solicitud de cambio de medicamento;
- contexto incompleto;
- proveedor no disponible;
- clave ausente;
- respuesta sin inventar mediciones.

El chatbot debe mantenerse dentro de alcance informativo.

## 12. Aplicación Android

Tecnología confirmada:

```text
Kotlin
Android Studio
```

Pruebas planificadas:

- inicio y cierre de sesión;
- perfil;
- navegación;
- formularios;
- errores de red;
- historiales;
- gráficas;
- medicamentos;
- recordatorios;
- notificaciones;
- consumo de análisis;
- manejo de respuesta del chatbot;
- accesibilidad;
- estados vacíos.


## 13. Dashboard

El dashboard disponible utiliza Chart.js y polling.

Pruebas funcionales planificadas:

- autenticación;
- carga de indicadores;
- conjuntos vacíos;
- respuestas parciales;
- errores de API;
- actualización periódica;
- etiquetas y unidades;
- visualización responsiva.

## 14. Socket.IO

La guía exige actualización en tiempo real con Socket.IO
Casos:

| ID | Caso | Resultado esperado |
|---|---|---|
| T-RT-01 | Conexión de socket | Cliente conectado |
| T-RT-02 | Nueva inferencia | Evento visible sin recargar |
| T-RT-03 | Asignación de cluster | Actualización del dashboard |
| T-RT-04 | Desconexión | Estado visible |
| T-RT-05 | Reconexión | Recuperación sin duplicar eventos |
| T-RT-06 | Error | Mensaje controlado |
| T-RT-07 | Persistencia | La actualización no sustituye el almacenamiento requerido |

## 15. Seguridad

Casos:

- contraseña con hash;
- token ausente, vencido o alterado;
- refresh token inválido;
- origen CORS no permitido;
- parámetros manipulados;
- validación de entrada;
- inyección SQL;
- encabezados de seguridad;
- secretos fuera del repositorio;
- mensajes sin credenciales;
- acceso a datos propios.

## 16. Rendimiento y concurrencia

- latencia de endpoints;
- latencia de `/api/v1/analyze`;
- latencia del futuro endpoint K-Means;
- tiempo de respuesta de Mistral;
- concurrencia básica;
- comportamiento cuando ML Service no responde;
- tamaño de respuestas del dashboard.

## 17. Integración end-to-end

Flujo a validar:

```text
Aplicación Kotlin
    ↕ Bluetooth
Wear OS
    ↓/↑
Backend
    ↔ MySQL
    ↔ ML Service
    → Dashboard
```



## 18. Evidencia mínima para aprobar un caso

Se debe conservar al menos una evidencia adecuada:

- salida de suite;
- log;
- captura original;
- reporte de Postman;
- resultado de comparación;
- archivo de métricas;
- video;
- registro de incidencia y corrección.

## 19. Estado general

| Área | Estado |
|---|---|
| Dataset | Verificaciones principales disponibles |
| Simulación | Reglas y resultados disponibles |
| ETL | Transformaciones y salidas disponibles |
| Modelos supervisados | Evaluación final disponible |
| Clustering y PCA | Métricas disponibles |
| Isolation Forest | Evaluación exploratoria disponible |
| Código de pruebas ML | Disponible |
| Endpoint supervisado | Disponible |
| Endpoint no supervisado | Disponible |
| Aplicación Android | Pruebas completas no confirmadas |
| Backend | Pruebas completas por confirmar |
| Wear OS / Bluetooth | Pruebas pendientes |
| Dashboard | Disponible  |
| Socket IO | Pendiente |
| Integración end-to-end | No confirmada |
| Prueba de carga | No confirmada |
| Validación clínica | No realizada |

