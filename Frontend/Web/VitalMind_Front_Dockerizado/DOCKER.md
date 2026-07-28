# Docker para el frontend

Este frontend es una aplicación Vite + React, así que en Docker se construye primero y luego se publica con Nginx.

## 1) Crear la imagen

Desde la carpeta `Front_VitalMind`:

```bash
docker build -t vitalmind-frontend .
```

Si tu backend no usa `http://localhost:4000/api`, cambia la URL al construir:

```bash
docker build -t vitalmind-frontend --build-arg VITE_API_URL=http://localhost:4000/api .
```

## 2) Ejecutar el contenedor

```bash
docker run --name vitalmind-frontend -p 8080:80 vitalmind-frontend
```

Abre:

```bash
http://localhost:8080
```

## 3) Qué hace cada archivo

- `Dockerfile`: construye la app y la publica en Nginx.
- `nginx.conf`: permite que el router de React funcione al refrescar rutas.
- `.dockerignore`: evita copiar archivos pesados como `node_modules` o `dist`.

## 4) Pasos para llevarlo a tu proyecto

1. Copia `Dockerfile`, `nginx.conf` y `.dockerignore` a la raíz del frontend.
2. Revisa la variable `VITE_API_URL` en `.env.example`.
3. Ejecuta `docker build`.
4. Ejecuta `docker run -p 8080:80 ...`.
5. Prueba navegación, login y llamadas al backend.

## 5) Verificación rápida

```bash
docker ps
docker logs vitalmind-frontend
```
