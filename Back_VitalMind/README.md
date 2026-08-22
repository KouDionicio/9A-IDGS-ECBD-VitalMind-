# VitalMind Backend

API para VitalMind construida con Express y MySQL. Todos los datos persistentes se guardan en MySQL: usuarios, medicamentos, citas, notificaciones y auditoria.

## Stack

- Node.js + Express
- MySQL 8
- JWT + bcrypt
- Validacion con Zod

## Inicio rapido

1. Configura `MYSQL_*` en `.env`.
2. Inicia MySQL.
3. Instala dependencias e inicia la API:

```bash
npm install
npm run dev
```

## Endpoints

- `GET /api/health`
- `POST /api/auth/register`
- `POST /api/auth/login`
- `GET /api/auth/me`
- `GET|POST|PATCH|DELETE /api/users`
- `GET|POST|PATCH|DELETE /api/medications`
- `GET|POST|PATCH|DELETE /api/appointments`
- `GET|POST|PATCH|DELETE /api/notifications`
- `GET /api/dashboard/summary`
- `GET /api/reports/summary`

## Usuarios de prueba

La inicialización no crea credenciales por defecto. Si habilitas `SEED_DEMO_DATA=true`, define las contraseñas mediante `SEED_ADMIN_PASSWORD` y `SEED_PATIENT_PASSWORD` en `.env`.

Los endpoints protegidos usan JWT.
