# Contratos de API — VitalMind AI

## 1. Arquitectura de servicios

VitalMind AI utiliza dos niveles de servicio:

- **API principal:** Node.js + Express, autenticación JWT, acceso a MySQL y módulos funcionales.
- **ML Service:** FastAPI, carga de modelos serializados y endpoints de inferencia.

```text
Aplicación / Dashboard
        ↓ HTTP JSON
API principal (Express)
   ↓ MySQL       ↓ HTTP
Base de datos   ML Service (FastAPI)
                    ↓
          Modelos + recomendaciones + chatbot
```

## 2. Direcciones locales

| Componente | Dirección habitual |
|---|---|
| API principal | `http://localhost:4000/api` |
| Swagger API principal | `http://localhost:4000/api/docs` |
| Dashboard de la API | `http://localhost:4000/dashboard` |
| ML Service | `http://localhost:8000` |
| Swagger FastAPI | `http://localhost:8000/docs` |
| ReDoc FastAPI | `http://localhost:8000/redoc` |

## 3. Autenticación

La API principal utiliza access token y refresh token. Las rutas funcionales protegidas esperan:

```http
Authorization: Bearer <access_token>
```

Rutas de autenticación:

```http
POST /api/auth/register
POST /api/auth/login
POST /api/auth/refresh
POST /api/auth/logout
GET  /api/auth/me
```

La documentación funcional de VitalMind AI se centra en el usuario general y en el acceso a sus propios datos.

## 4. API principal

### 4.1 Salud del servicio

```http
GET /api/health
```

Devuelve disponibilidad de la API y marca temporal.

### 4.2 Medicamentos

```http
GET    /api/medications
GET    /api/medications/:id
GET    /api/medications/:id/logs
POST   /api/medications
PUT    /api/medications/:id
PATCH  /api/medications/:id/taken
DELETE /api/medications/:id
```

### 4.3 Hábitos

```http
GET    /api/habits
GET    /api/habits/:date
POST   /api/habits
POST   /api/habits/increment
DELETE /api/habits/:date
```

### 4.4 Síntomas y mediciones

```http
GET    /api/symptoms
GET    /api/symptoms/:id
POST   /api/symptoms
PUT    /api/symptoms/:id
DELETE /api/symptoms/:id
```

### 4.5 Notificaciones

```http
GET    /api/notifications
GET    /api/notifications/unread-count
POST   /api/notifications
PATCH  /api/notifications/:id/read
DELETE /api/notifications/:id
```

### 4.6 Dashboard

La API principal expone consultas protegidas para indicadores y series. Entre ellas:

```http
GET /api/dashboard/statistics
GET /api/dashboard/mood-statistics
GET /api/dashboard/pain-statistics
GET /api/dashboard/glucose-history
GET /api/dashboard/blood-pressure
GET /api/dashboard/temperature-history
GET /api/dashboard/water-consumption
GET /api/dashboard/sleep-history
GET /api/dashboard/physical-activity
GET /api/dashboard/habits-weekly
```

### 4.7 Integración ML desde backend

```http
POST /api/ml/analyze
GET  /api/ml/health
GET  /api/ml/models/info
```

`POST /api/ml/analyze` reúne información del usuario en la base operacional y consume el análisis supervisado del ML Service.

## 5. ML Service — FastAPI

| Método | Endpoint | Función | Tipo |
|---|---|---|---|
| GET | `/health` | Estado del servicio y carga de artefactos | Sistema |
| GET | `/api/v1/models/info` | Información de modelos supervisados | Sistema |
| POST | `/api/v1/analyze` | Riesgo + bienestar + recomendaciones | Supervisado |
| POST | `/api/v1/wellbeing-cluster` | Asignación de clúster de bienestar | No supervisado |
| POST | `/api/v1/anomaly-detection` | Detección de observación atípica | No supervisado |
| POST | `/api/v1/chat` | Respuesta conversacional con contexto | IA generativa |
| POST | `/api/v1/chat/analyze` | Análisis + recomendaciones + chatbot | Combinado |

## 6. Análisis supervisado

### `POST /api/v1/analyze`

Ejemplo de solicitud:

```json
{
  "request_id": "REQ-ANALYSIS-001",
  "user_id": "USR_001",
  "analysis_date": "2026-08-20",
  "features": {
    "age": 30,
    "height_cm": 170,
    "weight_kg": 72,
    "water_glasses": 6,
    "exercise_minutes": 30,
    "sleep_hours": 7,
    "healthy_meals_count": 2,
    "meditation_minutes": 8,
    "pain": 2,
    "temperature_c": 36.7,
    "systolic_mmhg": 120,
    "diastolic_mmhg": 78,
    "glucose_mg_dl": 95,
    "heart_rate_bpm": 74,
    "mood": "bien",
    "stress_level": 4,
    "energy_level": 7,
    "sleep_quality": 7
  }
}
```

La respuesta incluye clasificación `low`, `medium` o `high`, confianza, probabilidades, `wellbeing_score`, BMI calculado, recomendaciones, versiones de modelo y aviso de limitación.

## 7. Clustering no supervisado

### `POST /api/v1/wellbeing-cluster`

Recibe un perfil agregado con 20 características, entre ellas edad, estatura, peso, BMI, promedios de hábitos, mediciones, estado emocional y número de registros.

Ejemplo parcial:

```json
{
  "request_id": "REQ-CL-001",
  "user_id": "USR_001",
  "features": {
    "age": 30,
    "height_cm": 170,
    "weight_kg": 72,
    "bmi": 24.91,
    "water_glasses_mean": 6,
    "exercise_minutes_mean": 30,
    "sleep_hours_mean": 7,
    "healthy_meals_count_mean": 2.5,
    "meditation_minutes_mean": 8,
    "pain_mean": 2,
    "temperature_c_mean": 36.7,
    "systolic_mmhg_mean": 120,
    "diastolic_mmhg_mean": 78,
    "glucose_mg_dl_mean": 95,
    "heart_rate_bpm_mean": 74,
    "stress_level_mean": 4,
    "energy_level_mean": 7,
    "sleep_quality_mean": 7,
    "mood_score_mean": 4,
    "records_count": 20
  }
}
```

Respuesta:

```json
{
  "request_id": "REQ-CL-001",
  "user_id": "USR_001",
  "result": {
    "cluster_id": 1,
    "profile": "hábitos relativamente equilibrados",
    "distance_to_centroid": 4.2736
  },
  "model_version": "1.0.0",
  "disclaimer": "Resultados preventivos generados con modelos entrenados sobre datos sintéticos. No representan un diagnóstico clínico."
}
```

## 8. Detección no supervisada de anomalías

### `POST /api/v1/anomaly-detection`

Recibe un registro con variables de perfil, hábitos, mediciones y estado emocional. Devuelve `is_anomaly`, la predicción cruda del modelo y sus puntuaciones.

Ejemplo de respuesta:

```json
{
  "request_id": "REQ-AN-001",
  "user_id": "USR_001",
  "result": {
    "is_anomaly": false,
    "raw_prediction": 1,
    "decision_score": 0.105904,
    "anomaly_score": -0.105904,
    "interpretation": "Registro dentro del patrón estadístico esperado."
  },
  "model_version": "1.0.0",
  "disclaimer": "Resultados preventivos generados con modelos entrenados sobre datos sintéticos. No representan un diagnóstico clínico."
}
```

## 9. Validación de entradas

FastAPI utiliza modelos Pydantic con límites por campo y `extra="forbid"` en las solicitudes de clustering y anomalías. La API principal utiliza `express-validator` en módulos como autenticación, hábitos, síntomas y análisis ML.

## 10. Errores

| Código | Uso |
|---:|---|
| 200 | Solicitud procesada |
| 400 | Solicitud inválida gestionada por la API principal |
| 401 | Autenticación ausente o inválida |
| 403 | Operación no autorizada |
| 404 | Recurso inexistente |
| 422 | Validación de FastAPI/Pydantic |
| 500 | Error interno controlado |
| 503 | Servicio externo no disponible, cuando aplique |

## 11. Swagger y OpenAPI

- Express publica Swagger en `/api/docs`.
- FastAPI publica `/docs`, `/redoc` y `/openapi.json`.
- La colección `vitalmind-api/docs/VitalMind.postman_collection.json` complementa las pruebas manuales de la API principal.

## 12. Tiempo real

El frontend web contiene un cliente `socket.io-client` y escucha el evento `notification:new`. En la API principal incluida en esta versión no aparece la dependencia ni la creación de un servidor Socket.IO. El dashboard independiente servido en `/dashboard` actualiza sus datos mediante `fetch` y un intervalo de 30 segundos. Por tanto, la actualización automática está implementada mediante polling y la comunicación push por Socket.IO debe considerarse una capacidad no validada en esta versión del backend.

## 13. Seguridad

- JWT para autenticación.
- bcrypt para hash de contraseñas.
- Helmet y CORS configurable.
- Variables de entorno para secretos.
- Validación centralizada de entradas.
- Manejo uniforme de errores.
- HTTPS/TLS requerido fuera del entorno local.

## 14. Límites

Las salidas de los modelos se basan en datos sintéticos. `risk_level`, `wellbeing_score`, clústeres y anomalías son resultados técnicos del prototipo y no equivalen a diagnóstico, pronóstico clínico ni indicación terapéutica.
