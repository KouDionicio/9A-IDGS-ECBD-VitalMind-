<div align="center">

#  VitalMind Frontend
## Manual de Instalación

</div>

<p align="center">

[![Node.js](https://img.shields.io/badge/Node.js-Requerido-339933?style=for-the-badge&logo=nodedotjs&logoColor=FFFFFF)](https://nodejs.org/) [![NPM](https://img.shields.io/badge/NPM-Paquetes-CB3837?style=for-the-badge&logo=npm&logoColor=FFFFFF)](https://www.npmjs.com/) [![Docker](https://img.shields.io/badge/Docker-Soportado-2496ED?style=for-the-badge&logo=docker&logoColor=FFFFFF)](https://www.docker.com/) [![Git](https://img.shields.io/badge/Git-Control%20de%20versiones-F05032?style=for-the-badge&logo=git&logoColor=FFFFFF)](https://git-scm.com/) [![Vercel](https://img.shields.io/badge/Vercel-Despliegue-000000?style=for-the-badge&logo=vercel&logoColor=FFFFFF)](https://vercel.com/) [![Entorno](https://img.shields.io/badge/Entorno-Desarrollo-0EA5E9?style=for-the-badge)](#) [![Versión](https://img.shields.io/badge/Versi%C3%B3n-2.1.0-2E7D32?style=for-the-badge)](#)

</p>

---

##  Descripción

Este manual explica cómo preparar el entorno, instalar dependencias, configurar variables, ejecutar, probar, dockerizar y preparar el frontend de VitalMind para despliegue.

##  Requisitos

```text
Git
Node.js
npm
Docker Desktop
Navegador actualizado
Editor de código
Acceso a backend / API
```

Verificar:

```bash
node -v
npm -v
git --version
docker --version
docker compose version
```

##  Clonar

```bash
git clone <URL_DEL_REPOSITORIO>
cd <REPOSITORIO>
```

Entrar al frontend:

```bash
cd Web
```

##  Dependencias

```bash
npm install
```

Mantener `package-lock.json` para instalaciones reproducibles.

##  Variables de entorno

Crear `.env` a partir de `.env.example`.

```env
VITE_API_URL=http://localhost:8000
```

El nombre debe coincidir con el código real.

### Seguridad

No subir:

```text
.env
.env.local
tokens
passwords
API keys
connection strings
```

## ▶️ Desarrollo

```bash
npm run dev
```

El servidor mostrará la URL local.

##  Producción

```bash
npm run build
```

Si existe script:

```bash
npm run preview
```

##  Docker

```bash
docker build -t vitalmind-frontend .
docker run -p 3000:3000 vitalmind-frontend
```

Con Compose:

```bash
docker compose up --build
```

Detener:

```bash
docker compose down
```

##  Validación API

Comprobar:

- URL;
- puerto;
- CORS;
- autenticación;
- endpoint;
- body;
- respuesta;
- errores.

##  Vercel

Antes:

```bash
npm run build
```

Después del deploy:

- login;
- rutas;
- API;
- responsive;
- variables;
- recursos;
- consola.

##  Git

```bash
git checkout -b feature/nueva-funcionalidad
git add .
git commit -m "feat: nueva funcionalidad"
git push origin feature/nueva-funcionalidad
```

Antes de comenzar:

```bash
git pull origin main
```

##  Problemas comunes

### Dependencias

```bash
npm cache verify
npm install
```

### API

Revisar `.env`, backend, CORS, URL y puerto.

### Docker

```bash
docker info
```

Revisar Dockerfile y puertos.

### Build

Ejecutar:

```bash
npm run build
```

y corregir errores antes de desplegar.

##  Checklist

- [ ] Git instalado.
- [ ] Node/npm instalados.
- [ ] Dependencias instaladas.
- [ ] `.env` configurado.
- [ ] Aplicación inicia.
- [ ] API responde.
- [ ] Build funciona.
- [ ] Docker funciona.
- [ ] Deploy validado.
