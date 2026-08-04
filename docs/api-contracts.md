# Contratos de API — VitalMind AI

## 1. Propósito

Este documento describe los contratos observados entre la aplicación, el backend y el microservicio de Machine Learning, y los compara con los requisitos de endpoints inteligentes de la guía oficial.

Arquitectura de comunicación:

```text
Smartwatch Wear OS
    ↕ Bluetooth
Aplicación Android en Kotlin
    ↓ HTTP/JSON
Backend Node.js / Express
    ↓ SQL                 ↓ HTTP/JSON
MySQL                 ML Service FastAPI
                           ↓
                    Modelos y chatbot
```

El smartwatch utiliza Wear OS y la aplicación se desarrolla en Kotlin con Android Studio. La comunicación reloj-aplicación se realiza mediante Bluetooth. 

## 2. Direcciones locales observadas

| Servicio | Dirección |
|---|---|
| Backend | `http://localhost:4000/api` |
| Swagger backend | `http://localhost:4000/api/docs` |
| ML Service | `http://localhost:8000` |
| OpenAPI FastAPI | `http://localhost:8000/docs` |


## 3. Autenticación

El backend utiliza JWT y refresh tokens.

```http
POST /api/auth/register
POST /api/auth/login
POST /api/auth/refresh
POST /api/auth/logout
GET  /api/auth/me
```

Rutas protegidas:

```http
Authorization:<access_token>
```


## 4. Módulos del backend

### 4.1 Medicamentos

```http
GET    /api/medications
GET    /api/medications/:id
GET    /api/medications/:id/logs
POST   /api/medications
PUT    /api/medications/:id
PATCH  /api/medications/:id/taken
DELETE /api/medications/:id
```

El manejo es digital. `PATCH /:id/taken` registra manualmente el estado de una toma.

### 4.2 Hábitos

```http
GET    /api/habits
GET    /api/habits/:date
POST   /api/habits
POST   /api/habits/increment
DELETE /api/habits/:date
```

Campos operacionales observados:

```text
water
exercise
sleep
nutrition
meditation
```

### 4.3 Síntomas y mediciones

El esquema incluye:

```text
pain
temperature
systolic
diastolic
glucose
weight
heart_rate
notes
```

Las migraciones agregan variables emocionales y fecha lógica necesarias para ML.

### 4.4 Notificaciones

El backend incluye operaciones para avisos y conteo de no leídas.


## 5. Integración backend → ML

El backend expone rutas de integración:

```http
POST /api/ml/analyze
GET  /api/ml/health
GET  /api/ml/models/info
POST /api/ml/chat
POST /api/ml/chat/analyze
```

Estas rutas reúnen información operacional, transforman nombres de campos y consumen FastAPI.

## 6. Endpoints del ML Service

| Método | Endpoint | Función |
|---|---|---|
| GET | `/health` | Estado del servicio y carga de modelos |
| GET | `/api/v1/models/info` | Información de modelos |
| POST | `/api/v1/analyze` | Clasificación, regresión y recomendaciones |
| POST | `/api/v1/chat` | Respuesta conversacional con contexto |
| POST | `/api/v1/chat/analyze` | Análisis + chatbot |

## 7. Endpoint inteligente supervisado

### 7.1 Propósito

`POST /api/v1/analyze` ejecuta el mecanismo supervisado de clasificación de riesgo y, adicionalmente, el regresor de bienestar y recomendaciones.

### 7.2 Método y ruta

```http
POST /api/v1/analyze
```

### 7.3 Modelo principal

```text
Regresión Logística
versión documental: 1.0.0
C = 10.0
class_weight = balanced
solver = lbfgs
```

El mismo flujo carga el regresor Ridge.

### 7.4 Entrada

```json
{
  "request_id": "REQ-ANALYSIS-001",
  "user_id": "USR_001",
  "analysis_date": "2026-08-09",
  "features": {
    "age": 25,
    "height_cm": 165,
    "weight_kg": 65,
    "water_glasses": 5,
    "exercise_minutes": 20,
    "sleep_hours": 6.5,
    "healthy_meals_count": 2,
    "meditation_minutes": 5,
    "pain": 2,
    "temperature_c": 36.7,
    "systolic_mmhg": 120,
    "diastolic_mmhg": 80,
    "glucose_mg_dl": 95,
    "heart_rate_bpm": 75,
    "mood": "regular",
    "stress_level": 6,
    "energy_level": 5,
    "sleep_quality": 5
  }
}
```

### 7.5 Campos indispensables

```text
age
height_cm
weight_kg
mood
stress_level
energy_level
sleep_quality
```

Si falta alguno, FastAPI rechaza la solicitud con validación 422.

### 7.6 Campos imputables

```text
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
```

La imputación usa estadísticas aprendidas únicamente con entrenamiento.

### 7.7 `mood`

Valores aceptados:

```text
muy mal
mal
regular
bien
muy bien
```

### 7.8 Salida

Estructura representativa:

```json
{
  "request_id": "REQ-ANALYSIS-001",
  "user_id": "USR_001",
  "analysis_date": "2026-08-09",
  "results": {
    "risk_classification": {
      "risk_level": "medium",
      "confidence": 0.72,
      "probabilities": {
        "low": 0.18,
        "medium": 0.72,
        "high": 0.10
      }
    },
    "wellbeing": {
      "score": 56.69,
      "level": "medium"
    },
    "calculated_bmi": 23.88,
    "recommendations": []
  },
  "model_versions": {
    "risk_classifier": "1.0.0",
    "wellbeing_regressor": "1.0.0"
  },
  "missing_data_report": {
    "required_missing": [],
    "imputed_fields": [],
    "warnings": []
  },
  "disclaimer": "Resultados preventivos generados con modelos entrenados sobre datos sintéticos. No representan un diagnóstico clínico."
}
```

### 7.9 Errores

| Código | Situación |
|---:|---|
| 200 | Solicitud procesada |
| 400 | Error traducido por backend o solicitud no construible |
| 401 | Autenticación inválida en rutas protegidas del backend |
| 422 | Campo, tipo, categoría o rango inválido |
| 503 | ML Service o proveedor conversacional no disponible |
| 500 | Error interno |



## 8. Variables del análisis supervisado

| Variable | Tipo | Unidad / escala |
|---|---|---|
| `age` | Entero | años |
| `height_cm` | Decimal | cm |
| `weight_kg` | Decimal | kg |
| `water_glasses` | Decimal | vasos |
| `exercise_minutes` | Decimal | min |
| `sleep_hours` | Decimal | h |
| `healthy_meals_count` | Decimal | conteo |
| `meditation_minutes` | Decimal | min |
| `pain` | Decimal | 0-10 |
| `temperature_c` | Decimal | °C |
| `systolic_mmhg` | Decimal | mmHg |
| `diastolic_mmhg` | Decimal | mmHg |
| `glucose_mg_dl` | Decimal | mg/dL |
| `heart_rate_bpm` | Decimal | bpm |
| `mood` | Texto | catálogo |
| `stress_level` | Decimal | 1-10 |
| `energy_level` | Decimal | 1-10 |
| `sleep_quality` | Decimal | 1-10 |

`bmi` se calcula dentro del ML Service.

## 9. Mapeo backend → ML

| Backend / MySQL | ML Service |
|---|---|
| `habit_logs.water` | `water_glasses` |
| `habit_logs.exercise` | `exercise_minutes` |
| `habit_logs.sleep` | `sleep_hours` |
| `habit_logs.nutrition` | `healthy_meals_count` |
| `habit_logs.meditation` | `meditation_minutes` |
| `symptom_logs.temperature` | `temperature_c` |
| `symptom_logs.systolic` | `systolic_mmhg` |
| `symptom_logs.diastolic` | `diastolic_mmhg` |
| `symptom_logs.glucose` | `glucose_mg_dl` |
| `symptom_logs.heart_rate` | `heart_rate_bpm` |
| `symptom_logs.weight` | `weight_kg` |

## 10. Chatbot

### `POST /api/v1/chat`

Recibe un mensaje y contexto previamente calculado.

```json
{
  "request_id": "REQ-CHAT-001",
  "user_id": "USR_001",
  "analysis_date": "2026-08-09",
  "message": "¿Qué puedo hacer para mejorar mi bienestar?",
  "context": {
    "risk_level": "medium",
    "wellbeing_score": 68.4,
    "wellbeing_level": "medium",
    "bmi": 26.1,
    "recommendations": []
  }
}
```

### `POST /api/v1/chat/analyze`

Ejecuta primero el análisis estructurado y después genera la respuesta conversacional.

El chatbot no debe inventar mediciones ni emitir diagnóstico.


## 11. Dashboard y tiempo real

El dashboard entregado:

- consume la API;
- usa Chart.js;
- muestra indicadores y gráficas;
- realiza polling cada 30 segundos.




## 12. Seguridad

- credenciales en variables de entorno;
- JWT en rutas protegidas;
- validación de entrada;
- CORS configurable;
- Helmet;
- errores centralizados;
- sin secretos en respuestas;
- HTTPS/TLS fuera del entorno local;
- ML Service sin acceso directo a MySQL;
- acceso de cada cuenta a sus propios datos.


## 13. Documentos relacionados

- [`context.md`](./context.md)
- [`model-evaluation.md`](./model-evaluation.md)
- [`testing.md`](./testing.md)
- [`ethics.md`](./ethics.md)
- [`ai-usage.md`](./ai-usage.md)
