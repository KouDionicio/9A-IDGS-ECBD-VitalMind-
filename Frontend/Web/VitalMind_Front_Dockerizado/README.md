# VitalMind Frontend

Interfaz web de VitalMind desarrollada con React, TypeScript y Vite.

## Variables

```powershell
Copy-Item .env.example .env
```

```env
VITE_API_URL=http://localhost:4000/api
```

## Instalar e iniciar

```powershell
npm ci
npm run dev
```

## Verificar

```powershell
npm run typecheck
npm run lint
npm test
npm run build
npm audit
```

El frontend utiliza `src/app/lib/api.ts` para centralizar la URL, el JWT, los errores y el cierre de sesión. Las rutas de paciente y administrador se protegen en `src/app/components/ProtectedRoute.tsx`, aunque la autorización definitiva siempre se realiza en el backend.

Consulta el README de la carpeta principal para la guía completa.


## Docker

Consulta `DOCKER.md` para construir y ejecutar el frontend con Docker.
