# VitalMind - Frontend

Frontend web de **VitalMind**, una plataforma inteligente de salud integral desarrollada para centralizar información, hábitos y seguimiento del usuario mediante una interfaz web moderna y accesible.

## Tecnologías utilizadas

* React
* TypeScript
* Vite
* Docker
* Docker Compose
* Vercel
* Git y GitHub

## Estructura del proyecto

El frontend contiene la interfaz principal de VitalMind, incluyendo sus componentes, páginas, navegación y conexión con los servicios del sistema.

```text
Front_VitalMind/
├── src/
├── public/
├── Dockerfile
├── docker-compose.yml
├── package.json
├── tsconfig.json
├── vite.config.ts
└── README.md
```

## Dockerización

El frontend fue **dockerizado** para facilitar su ejecución y mantener un entorno consistente entre diferentes computadoras.

El proyecto cuenta con un `Dockerfile` encargado de preparar la aplicación y sus dependencias.

También se utiliza `docker-compose.yml` para facilitar la ejecución del proyecto mediante Docker.

Para ejecutar el frontend con Docker:

```bash
docker compose up --build
```

Esto construye la imagen y levanta el contenedor del frontend.

## Despliegue en Vercel

El frontend fue publicado en **Vercel** utilizando el repositorio de GitHub del proyecto.

El proceso realizado fue:

1. Subir el código del frontend al repositorio de GitHub.
2. Crear un nuevo proyecto en Vercel.
3. Conectar Vercel con el repositorio de GitHub.
4. Seleccionar la carpeta correspondiente al frontend.
5. Configurar las variables de entorno necesarias.
6. Realizar el despliegue.
7. Vercel genera automáticamente una URL pública para acceder a la aplicación.

Cada vez que se realizan cambios en la rama configurada y se actualiza el repositorio, Vercel puede generar un nuevo despliegue automáticamente.

## Variables de entorno

Las variables utilizadas para conectar el frontend con los servicios externos se configuran mediante variables de entorno.

Ejemplo:

```env
VITE_API_URL=https://tu-api.com
```

Las variables de entorno no deben incluirse directamente en el código fuente ni compartirse públicamente.

## Ejecución local

Para ejecutar el frontend sin Docker:

```bash
npm install
npm run dev
```

Después, Vite proporciona una dirección local para acceder a la aplicación desde el navegador.

## Despliegue

Actualmente, el frontend cuenta con una versión dockerizada para ejecución mediante contenedores y una versión desplegada en **Vercel** para acceso desde Internet.

## Objetivo

El frontend permite proporcionar una interfaz centralizada para las funcionalidades de **VitalMind**, facilitando la interacción del usuario con la plataforma y con los servicios backend que forman parte del sistema.
