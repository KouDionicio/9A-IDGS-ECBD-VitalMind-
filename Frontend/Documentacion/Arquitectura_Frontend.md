<div align="center">

#  VitalMind Frontend
## Arquitectura del Frontend

</div>
<div align="center">

[![Arquitectura](https://img.shields.io/badge/Arquitectura-Frontend-2563EB?style=for-the-badge)](#) [![Web](https://img.shields.io/badge/Web-Frontend-00A67E?style=for-the-badge)](#) [![Mobile](https://img.shields.io/badge/Mobile-Integrado-7C3AED?style=for-the-badge)](#) [![Wearable](https://img.shields.io/badge/Wearable-Integrado-E11D48?style=for-the-badge)](#) [![React](https://img.shields.io/badge/React-19-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)](https://react.dev/) [![Vite](https://img.shields.io/badge/Vite-7-646CFF?style=for-the-badge&logo=vite&logoColor=FFD62E)](https://vite.dev/) [![Estado](https://img.shields.io/badge/Estado-Documentado-0EA5E9?style=for-the-badge)](#)

</div>

##  Descripción

Este documento describe la arquitectura lógica y organizativa del frontend de **VitalMind**, considerando Web, Mobile y Wearable como partes de un mismo ecosistema.

La arquitectura busca mantener una separación clara entre presentación, navegación, estado, servicios, integración con API y configuración, permitiendo que el proyecto crezca sin perder mantenibilidad.

##  Objetivos

- Separar responsabilidades.
- Evitar duplicación.
- Facilitar pruebas.
- Centralizar servicios.
- Mantener coherencia entre plataformas.
- Reducir acoplamiento.
- Facilitar nuevas funcionalidades.
- Simplificar mantenimiento y despliegue.

##  Vista general

```text
Usuario
   │
   ├───────────────┬─────────────────┐
   ▼               ▼                 ▼
  Web            Mobile           Wearable
   │               │                 │
   └───────────────┼─────────────────┘
                   ▼
              Servicios
                   │
                   ▼
                  API
                   │
                   ▼
             Backend / BD
```

##  Capas

### 1. Presentación

Incluye:

- páginas;
- componentes;
- formularios;
- navegación;
- estados visuales;
- responsive.

### 2. Estado

Gestiona:

- sesión;
- usuario;
- datos cargados;
- filtros;
- formularios;
- carga y errores.

### 3. Servicios

Centraliza:

- llamadas HTTP;
- autenticación;
- manejo de respuestas;
- errores;
- endpoints.

### 4. Integración

Considera:

- API;
- almacenamiento local;
- Socket.IO;
- Mobile;
- Wearable;
- configuración por ambiente.

##  Flujo Web

```text
Vista
 ↓
Evento
 ↓
Validación
 ↓
Servicio
 ↓
API
 ↓
Respuesta
 ↓
Estado
 ↓
Interfaz
```

##  Mobile

Mobile funciona como cliente adicional del ecosistema, manteniendo las mismas reglas generales de autenticación, comunicación y sincronización.

##  Wearable

El flujo conceptual es:

```text
Wearable
   ↓
Mobile
   ↓
Sincronización
   ↓
API
   ↓
Sistema
```

La implementación real debe documentar qué datos se generan, cuándo se sincronizan y qué ocurre cuando existe pérdida de conectividad.

##  Autenticación

```text
Formulario
   ↓
Servicio Auth
   ↓
API
   ↓
Token / Sesión
   ↓
Estado autenticado
   ↓
Rutas protegidas
```

Buenas prácticas:

- no imprimir tokens;
- no subir secretos;
- limpiar sesión al cerrar;
- controlar expiración;
- manejar errores 401/403.

##  API

Se recomienda:

```text
Componente
   ↓
Hook / Controlador
   ↓
Servicio
   ↓
Axios / Fetch
   ↓
API
```

Evitar distribuir llamadas HTTP directamente por todas las vistas.

##  Tiempo real

Cuando Socket.IO esté implementado:

```text
Frontend ⇄ Socket.IO ⇄ Servidor
```

Debe documentarse cada evento utilizado, su emisor, receptor y propósito.

##  Docker

```text
Código
 ↓
Dockerfile
 ↓
Imagen
 ↓
Contenedor
 ↓
Frontend
```

##  Deploy

```text
GitHub → Vercel → Build → Deploy → Producción
```

##  Escalabilidad

La arquitectura puede extenderse con módulos como:

- notificaciones;
- historial;
- reportes;
- recomendaciones;
- administración;
- analítica;
- nuevas integraciones.

##  Criterios

Una implementación saludable debe:

- mantener responsabilidades claras;
- manejar errores;
- centralizar API;
- separar configuración;
- proteger rutas;
- tener pruebas;
- actualizar documentación.

##  Nota

Los nombres exactos de carpetas, archivos, endpoints y variables deben permanecer alineados con el código real del repositorio.
