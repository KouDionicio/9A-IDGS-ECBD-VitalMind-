# VitalMind en Windows: comandos de ejecución

Ruta base usada en esta guía:

```powershell
C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido
```

## 1. Verificar Node.js y npm

```powershell
node --version
npm --version
```

## 2. Verificar e iniciar MySQL

```powershell
Get-Service *mysql*
```

Si el servicio aparece detenido:

```powershell
Start-Service MySQL80
```

## 3. Entrar al backend

```powershell
cd C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido\Back_VitalMind
```

## 4. Crear y editar el archivo `.env` del backend

```powershell
Copy-Item .env.example .env
notepad .env
```

Contenido sugerido:

```env
NODE_ENV=development
PORT=4000
CORS_ORIGIN=http://localhost:5173
JWT_SECRET=ESCRIBE_UNA_CLAVE_ALEATORIA_DE_MAS_DE_32_CARACTERES
JWT_EXPIRES_IN=1h
MYSQL_HOST=127.0.0.1
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=TU_CONTRASEÑA_DE_MYSQL
MYSQL_DATABASE=vitalmind
MYSQL_CONNECT_TIMEOUT_MS=5000
AUTO_MIGRATE=true
AUTO_SEED=false
OPENFDA_BASE_URL=https://api.fda.gov
OPENFDA_API_KEY=
OPEN_METEO_AIR_BASE_URL=https://air-quality-api.open-meteo.com
WGER_BASE_URL=https://wger.de
EXTERNAL_TIMEOUT_MS=8000
EXTERNAL_CACHE_TTL_MS=300000
```

## 5. Limpiar npm si da error

```powershell
npm cache clean --force
npm cache verify
```

Si hay instalación dañada:

```powershell
Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
Remove-Item -Force package-lock.json -ErrorAction SilentlyContinue
```

Si npm sigue fallando, bajar a npm 10:

```powershell
npm install -g npm@10
npm --version
```

## 6. Instalar dependencias del backend

```powershell
npm ci
```

Si falla:

```powershell
npm install
```

## 7. Crear base de datos y tablas

```powershell
npm run db:migrate
```

## 8. Cargar datos ficticios

```powershell
npm run db:seed
```

## 9. Revisar y probar el backend

```powershell
npm run check
npm test
npm audit
```

## 10. Levantar el backend

```powershell
npm run dev
```

Prueba en el navegador:

```text
http://localhost:4000/api/health
```

## 11. Abrir una segunda ventana y entrar al frontend

```powershell
cd C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido\Front_VitalMind
```

## 12. Crear y editar el `.env` del frontend

```powershell
Copy-Item .env.example .env
notepad .env
```

Contenido:

```env
VITE_API_URL=http://localhost:4000/api
```

## 13. Instalar dependencias del frontend

```powershell
npm ci
```

Si falla:

```powershell
npm install
```

## 14. Revisar el frontend

```powershell
npm run typecheck
npm run lint
npm test
npm run build
npm audit
```

## 15. Levantar el frontend

```powershell
npm run dev
```

Abre la URL que muestre Vite, normalmente:

```text
http://localhost:5173
```

## 16. Orden diario de ejecución

### Ventana 1: backend

```powershell
cd C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido\Back_VitalMind
npm run dev
```

### Ventana 2: frontend

```powershell
cd C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido\Front_VitalMind
npm run dev
```

## 17. Cerrar servidores

En cada ventana:

```powershell
Ctrl + C
```

Si PowerShell pregunta, confirma con `S`.

## 18. Comandos Git básicos

```powershell
cd C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido
git init
git status
git add .
git commit -m "feat: entrega funcional de VitalMind"
git branch -M main
git remote add origin URL_DEL_REPOSITORIO
git push -u origin main
```

## 19. Comandos rápidos de diagnóstico

### Ver puertos ocupados

```powershell
Get-NetTCPConnection -LocalPort 4000 -ErrorAction SilentlyContinue
Get-NetTCPConnection -LocalPort 5173 -ErrorAction SilentlyContinue
```

### Ver servicios MySQL

```powershell
Get-Service *mysql*
```

### Ver versión de npm y node

```powershell
node --version
npm --version
```

## 20. Orden mínimo recomendado

```powershell
# Backend
cd C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido\Back_VitalMind
Copy-Item .env.example .env
npm ci
npm run db:migrate
npm run db:seed
npm run dev
```

En otra ventana:

```powershell
# Frontend
cd C:\Users\yaz\Downloads\VitalMind_Corregido\VitalMind_Corregido\Front_VitalMind
Copy-Item .env.example .env
npm ci
npm run dev
```
