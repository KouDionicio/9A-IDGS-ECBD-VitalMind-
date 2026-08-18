# VitalMind Frontend

Frontend web de **VitalMind**, construido con **React + TypeScript + Vite** y preparado para ejecutarse de forma local, mediante Docker o desplegarse en plataformas como Vercel.

## Tecnologías

- React 18
- TypeScript
- Vite 6
- React Router
- Tailwind CSS 4
- Material UI
- Radix UI
- Recharts
- Socket.IO Client
- Nginx para producción

## Requisitos

Para trabajar sin Docker:

- Node.js 20+
- npm 10+

Para Docker:

- Docker Desktop
- Docker Compose

## Ejecutar localmente sin Docker

```bash
npm install
npm run dev
```

Vite mostrará la URL local, normalmente:

```text
http://localhost:5173
```

## Variables de entorno

Copia `.env.example` como `.env`:

```env
VITE_API_URL=http://localhost:4000/api
VITE_SOCKET_URL=http://localhost:4000
VITE_ML_API_URL=http://localhost:8000/api/v1
```

### Importante

Las variables `VITE_*` se incorporan al frontend durante `npm run build`. Si cambias la URL del backend después de construir la imagen, debes volver a construirla.

## Ejecutar con Docker

La forma recomendada es:

```bash
docker compose build --no-cache
docker compose up -d
```

Frontend:

```text
http://localhost:8080
```

Ver estado:

```bash
docker compose ps
```

Ver logs:

```bash
docker compose logs -f vitalmind-frontend
```

Detener:

```bash
docker compose down
```

## Docker con backend local

Por defecto el frontend usa:

```text
API:    http://localhost:4000/api
Socket: http://localhost:4000
ML:     http://localhost:8000/api/v1
```

Esto significa que el navegador del usuario intentará conectarse a esos puertos del equipo donde está abierto el frontend.

## Docker con backend desplegado

Antes de construir, define las URLs reales:

### PowerShell

```powershell
$env:VITE_API_URL="https://TU-BACKEND/api"
$env:VITE_SOCKET_URL="https://TU-BACKEND"
$env:VITE_ML_API_URL="https://TU-ML/api/v1"

docker compose build --no-cache
docker compose up -d
```

### CMD

```cmd
set VITE_API_URL=https://TU-BACKEND/api
set VITE_SOCKET_URL=https://TU-BACKEND
set VITE_ML_API_URL=https://TU-ML/api/v1

docker compose build --no-cache
docker compose up -d
```

No subas `.env` al repositorio.

## Rutas y recarga de página

La aplicación utiliza React Router. Nginx está configurado para devolver `index.html` cuando se entra directamente a rutas como:

```text
/dashboard
/medicamentos
/medicamentos/123
/admin/dashboard
```

Así se evita el error 404 al recargar una ruta interna.

## Estructura principal

```text
src/
├── app/
│   ├── components/
│   ├── hooks/
│   ├── imports/
│   ├── lib/
│   │   ├── api.ts
│   │   ├── session.ts
│   │   └── socket.ts
│   ├── routes.tsx
│   └── App.tsx
├── assets/
├── imports/
├── styles/
└── main.tsx
```

## Correcciones realizadas para Docker

- Se elimina la dependencia de `node_modules` incluido en el ZIP.
- `npm ci` instala las dependencias desde `package-lock.json`.
- Se mantiene un build multietapa: Node para compilar y Nginx para servir producción.
- Se añadió healthcheck de Nginx.
- Se corrigió el manejo de rutas de API para evitar dobles `/`.
- Se agregó `VITE_SOCKET_URL` para separar correctamente Socket.IO de la URL `/api`.
- Se configuró Nginx para SPA y recarga de rutas.
- `index.html` no se cachea para reducir problemas después de nuevas versiones.
- Los assets versionados de Vite sí utilizan caché.
- El `README` incluye comandos de Windows, ya que el proyecto puede trabajarse desde PowerShell/CMD.

## Verificación

Para comprobar el frontend antes de desplegar:

```bash
npm ci
npm run build
```

Después:

```bash
docker compose build
docker compose up -d
```

Abrir:

```text
http://localhost:8080
```

Comprobar salud:

```text
http://localhost:8080/health
```

Debe responder:

```text
ok
```

## Nota sobre el backend

Dockeriza únicamente este frontend. El backend y, en su caso, la API de Machine Learning deben estar disponibles en sus propias URLs y permitir las peticiones CORS/Socket.IO provenientes del dominio donde se publique VitalMind.
