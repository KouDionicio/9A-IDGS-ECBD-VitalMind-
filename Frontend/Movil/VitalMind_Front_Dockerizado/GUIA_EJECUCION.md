# README - Guía de Ejecución del Frontend con Docker

Este documento sirve como guía completa para construir, ejecutar y verificar el frontend de **VitalMind** utilizando Docker. También incluye los comandos de Git más comunes que pueden utilizarse durante el desarrollo y despliegue del proyecto.

---

# Docker para el Frontend (Vite + React)

El frontend de **VitalMind** está desarrollado con **React + Vite**. La aplicación se compila durante la construcción de la imagen Docker y posteriormente es servida mediante **Nginx**.

---

# Requisitos

Antes de comenzar verifica que tengas instalado:

* Docker Desktop
* Git
* Node.js (solo si ejecutarás el proyecto sin Docker)

Comprobar instalación:

```bash
docker --version
```

```bash
git --version
```

```bash
node -v
```

---

# Clonar el repositorio

```bash
git clone https://github.com/USUARIO/Front_VitalMind.git
```

Entrar al proyecto

```bash
cd Front_VitalMind
```

---

# Estructura de Docker

En la raíz del proyecto deben existir los siguientes archivos.

```
Front_VitalMind
│
├── Dockerfile
├── nginx.conf
├── .dockerignore
├── package.json
├── vite.config.js
└── src
```

---

# ¿Qué hace cada archivo?

## Dockerfile

Se encarga de:

* Instalar dependencias.
* Compilar la aplicación React.
* Generar la carpeta `dist`.
* Copiar los archivos compilados hacia Nginx.

---

## nginx.conf

Permite que React Router funcione correctamente.

Cuando el usuario refresca una ruta como

```
/dashboard
```

Nginx redirige automáticamente al `index.html`.

---

## .dockerignore

Evita copiar archivos innecesarios como:

```
node_modules
dist
.git
.vscode
```

Esto hace la imagen más ligera.

---

# Variables de entorno

Si el backend utiliza otra URL diferente a la predeterminada, puede especificarse durante la construcción.

Ejemplo:

```
http://localhost:4000/api
```

---

# Construcción de la imagen Docker

Desde la carpeta del proyecto ejecutar:

```bash
docker build -t vitalmind-frontend .
```

Si deseas especificar otra URL del backend:

```bash
docker build -t vitalmind-frontend --build-arg VITE_API_URL=http://localhost:4000/api .
```

---

# Verificar que la imagen fue creada

```bash
docker images
```

Debe aparecer una imagen similar a:

```
vitalmind-frontend
```

---

# Ejecutar el contenedor

```bash
docker run --name vitalmind-frontend -p 8080:80 vitalmind-frontend
```

---

# Abrir la aplicación

Desde cualquier navegador ingresar a

```
http://localhost:8080
```

---

# Verificar contenedores activos

```bash
docker ps
```

---

# Ver todos los contenedores

```bash
docker ps -a
```

---

# Ver registros del contenedor

```bash
docker logs vitalmind-frontend
```

---

# Detener el contenedor

```bash
docker stop vitalmind-frontend
```

---

# Iniciar nuevamente

```bash
docker start vitalmind-frontend
```

---

# Reiniciar

```bash
docker restart vitalmind-frontend
```

---

# Eliminar el contenedor

```bash
docker rm vitalmind-frontend
```

---

# Eliminar la imagen

```bash
docker rmi vitalmind-frontend
```

---

# Flujo recomendado para integrar Docker al proyecto

## 1.

Copiar a la raíz del proyecto:

```
Dockerfile
```

```
nginx.conf
```

```
.dockerignore
```

---

## 2.

Revisar la variable

```
VITE_API_URL
```

---

## 3.

Construir la imagen

```bash
docker build -t vitalmind-frontend .
```

---

## 4.

Ejecutar el contenedor

```bash
docker run --name vitalmind-frontend -p 8080:80 vitalmind-frontend
```

---

## 5.

Abrir

```
http://localhost:8080
```

---

## 6.

Comprobar:

* Navegación
* Login
* Registro
* Consumo de API
* Comunicación con Backend

---

# Comandos Git utilizados durante el desarrollo

## Clonar repositorio

```bash
git clone URL_DEL_REPOSITORIO
```

---

## Entrar al proyecto

```bash
cd Front_VitalMind
```

---

## Verificar rama

```bash
git branch
```

---

## Ver ramas remotas

```bash
git branch -r
```

---

## Ver todas las ramas

```bash
git branch -a
```

---

## Crear una nueva rama

```bash
git checkout -b feature/frontend
```

---

## Cambiar de rama

```bash
git checkout feature/frontend
```

---

## Actualizar referencias del repositorio

```bash
git fetch origin
```

---

## Descargar cambios

```bash
git pull origin feature/frontend
```

---

## Ver estado

```bash
git status
```

---

## Ver diferencias

```bash
git diff
```

---

## Agregar todos los cambios

```bash
git add .
```

---

## Agregar un archivo específico

```bash
git add README.md
```

---

## Crear un commit

```bash
git commit -m "Descripción del cambio"
```

---

## Crear un commit con título y descripción

```bash
git commit -m "Título" -m "Descripción detallada"
```

---

## Ver historial

```bash
git log
```

---

## Historial resumido

```bash
git log --oneline
```

---

## Historial gráfico

```bash
git log --graph --oneline --all
```

---

## Enviar cambios

```bash
git push origin feature/frontend
```

---

## Obtener cambios remotos

```bash
git fetch
```

---

## Fusionar otra rama

```bash
git merge nombre-rama
```

Ejemplo:

```bash
git merge origin/main
```

---

## Resolver conflictos

Después de resolverlos:

```bash
git add .
```

```bash
git commit
```

---

## Cancelar cambios no guardados

```bash
git restore .
```

---

## Restaurar un archivo

```bash
git restore README.md
```

---

## Eliminar un commit local (manteniendo los cambios)

```bash
git reset --soft HEAD~1
```

---

## Eliminar commit y cambios

```bash
git reset --hard HEAD~1
```

---

## Ver repositorio remoto

```bash
git remote -v
```

---

## Cambiar nombre de la rama

```bash
git branch -m feature/frontend
```

---

## Subir la nueva rama

```bash
git push -u origin feature/frontend
```

---

# Verificación final

Antes de entregar el proyecto, verifica:

### Docker

```bash
docker images
```

```bash
docker ps
```

```bash
docker logs vitalmind-frontend
```

### Git

```bash
git status
```

```bash
git branch
```

```bash
git log --oneline
```

---

# Flujo completo de ejecución

1. Clonar el repositorio.
2. Entrar al proyecto.
3. Verificar la rama de trabajo.
4. Actualizar el repositorio con `git pull`.
5. Revisar o configurar `VITE_API_URL`.
6. Construir la imagen Docker.
7. Ejecutar el contenedor.
8. Abrir `http://localhost:8080`.
9. Verificar el funcionamiento del login, navegación y consumo de la API.
10. Consultar los logs y el estado del contenedor si ocurre algún error.
11. Registrar cambios con `git add`, `git commit` y `git push` cuando se realicen modificaciones al proyecto.


