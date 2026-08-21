# Guía de Ejecución — VitalMind AI

## 1. Requisitos

- Node.js 18 o superior para la API principal.
- MySQL 8.
- Python compatible con `ml-service/requirements.txt`.
- Android Studio para la aplicación móvil y Wear OS.
- Un smartwatch Wear OS o emulador para pruebas del módulo wearable.

## 2. Variables de entorno

Nunca se deben publicar claves reales. Utiliza los archivos `.env.example` de cada componente y crea una copia local `.env`.

Variables habituales de API:

```env
PORT=4000
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=vitalmind
JWT_ACCESS_SECRET=
JWT_REFRESH_SECRET=
ML_SERVICE_URL=http://127.0.0.1:8000
CORS_ORIGIN=http://localhost:5173
```

Variables del servicio ML:

```env
MISTRAL_API_KEY=
MISTRAL_MODEL=mistral-small-latest
```

## 3. API principal — Windows PowerShell

```powershell
cd vitalmind-api
Copy-Item .env.example .env
npm install
npm run dev
```

API: `http://localhost:4000/api`

Swagger: `http://localhost:4000/api/docs`

Dashboard: `http://localhost:4000/dashboard`

## 4. API principal — Linux/macOS

```bash
cd vitalmind-api
cp .env.example .env
npm install
npm run dev
```

## 5. ML Service — Windows PowerShell

```powershell
cd ml-service
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
```

## 6. ML Service — Linux/macOS

```bash
cd ml-service
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
```

Swagger: `http://localhost:8000/docs`

ReDoc: `http://localhost:8000/redoc`

## 7. Base de datos

El repositorio contiene respaldos y scripts SQL dentro de `Data Base/` y archivos de inicialización en los módulos de backend. Antes de iniciar la API verifica que exista la base `vitalmind` y que las credenciales del `.env` tengan permisos únicamente sobre los objetos necesarios.

## 8. Aplicación móvil y Wear OS

1. Abrir `Frontend/Movil_Wearable/Frontend_Movil_Wearable` en Android Studio.
2. Esperar la sincronización de Gradle.
3. Seleccionar el módulo móvil o wearable correspondiente.
4. Ejecutar en emulador o dispositivo compatible.
5. Para un reloj físico, mantener Bluetooth habilitado y conceder los permisos solicitados por la aplicación.

## 9. Comprobación de servicios

```text
GET http://localhost:4000/api/health
GET http://localhost:8000/health
```

El segundo debe indicar que los artefactos ML fueron cargados.

## 10. Flujo básico de prueba

1. Registrar una cuenta con `/api/auth/register`.
2. Iniciar sesión con `/api/auth/login`.
3. Copiar el access token.
4. Usar `Authorization: Bearer <token>` en rutas protegidas.
5. Crear un registro de síntomas o hábitos.
6. Consultar historial.
7. Ejecutar `/api/ml/analyze` o llamar directamente al ML Service.
8. Consultar el dashboard.

## 11. Endpoints ML directos

```http
POST http://localhost:8000/api/v1/analyze
POST http://localhost:8000/api/v1/wellbeing-cluster
POST http://localhost:8000/api/v1/anomaly-detection
```

Los cuerpos completos se encuentran en [`api-contracts.md`](./api-contracts.md).

## 12. Pruebas

```powershell
# ML Service
cd ml-service
.\.venv\Scripts\Activate.ps1
python -m pytest -q
```

```bash
# Comprobación sintáctica puntual de Node
node --check vitalmind-api/src/server.js
```

Los reportes de integración disponibles se encuentran en `reports/test-backend/` y `reports/test-integration/`.

## 13. Dashboard

Abrir `http://localhost:4000/dashboard`, autenticarse y mantener la API y MySQL activos. El dashboard repite sus consultas cada 30 segundos.

## 14. Errores comunes

### MySQL no conecta

- revisar host, puerto, usuario y contraseña;
- confirmar que el servicio MySQL está iniciado;
- comprobar que existe la base configurada.

### ML Service no inicia

- instalar todas las dependencias de `requirements.txt`;
- comprobar que existen los artefactos serializados;
- utilizar una versión de scikit-learn compatible con la usada para serializar los modelos.

### Chatbot no responde

- comprobar `MISTRAL_API_KEY`;
- verificar conectividad con el proveedor;
- validar que el resto del análisis funcione independientemente del chatbot.

### Dashboard sin datos

- confirmar sesión válida;
- revisar registros en MySQL;
- verificar respuestas `/api/dashboard/*`.

## 15. Detención

Detén los procesos de Node y Uvicorn con `Ctrl+C`. Desactiva el entorno Python con:

```text
deactivate
```
