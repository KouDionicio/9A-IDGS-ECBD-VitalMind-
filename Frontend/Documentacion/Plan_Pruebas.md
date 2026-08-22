<div align="center">

#  VitalMind Frontend
## Plan de Pruebas

</div>

<p align="center">

[![Testing](https://img.shields.io/badge/Testing-Plan-6C63FF?style=for-the-badge)](#) [![Funcionales](https://img.shields.io/badge/Pruebas-Funcionales-16A34A?style=for-the-badge)](#) [![Integración](https://img.shields.io/badge/Pruebas-Integraci%C3%B3n-0284C7?style=for-the-badge)](#) [![UI](https://img.shields.io/badge/Pruebas-UI-F97316?style=for-the-badge)](#) [![Estado](https://img.shields.io/badge/Estado-Preparado-0EA5E9?style=for-the-badge)](#) [![Versión](https://img.shields.io/badge/Versi%C3%B3n-2.1.0-2E7D32?style=for-the-badge)](#)

</p>

---

##  Descripción

Este plan establece cómo comprobar la calidad del frontend de VitalMind antes de una entrega.

##  Objetivos

- Validar funcionalidades.
- Validar integración con API.
- Validar interfaz.
- Detectar regresiones.
- Validar Docker.
- Validar producción.
- Registrar evidencias.

##  Tipos de prueba

### Funcionales

Comprueban el resultado esperado de cada función.

### Integración

Comprueban la comunicación entre frontend, API y componentes.

### UI

Comprueban responsive, componentes y consistencia.

### Regresión

Verifican que un cambio no rompa funciones existentes.

### Smoke

Comprueban rápidamente que la aplicación principal funciona.

##  Formato

```text
ID:
Nombre:
Módulo:
Precondiciones:
Datos:
Pasos:
Resultado esperado:
Resultado obtenido:
Estado:
Evidencia:
Observaciones:
```

##  Autenticación

| ID | Caso | Resultado esperado |
|---|---|---|
| AUTH-01 | Login válido | Acceso |
| AUTH-02 | Credenciales incorrectas | Error |
| AUTH-03 | Campos vacíos | Validación |
| AUTH-04 | Logout | Sesión cerrada |
| AUTH-05 | Ruta protegida | Acceso restringido |

##  Usuario

| ID | Caso | Resultado esperado |
|---|---|---|
| USER-01 | Mostrar perfil | Datos visibles |
| USER-02 | Actualizar perfil | Datos actualizados |
| USER-03 | Datos inválidos | Validación |
| USER-04 | API no disponible | Mensaje de error |

##  Salud

Validar:

- registro;
- consulta;
- actualización;
- validación;
- estados vacíos;
- errores.

##  Mobile /  Wearable

```text
Dato
 ↓
Wearable
 ↓
Mobile
 ↓
API
 ↓
Sistema
```

Validar conectividad, sincronización, errores y recuperación.

##  API

Validar:

- método;
- URL;
- headers;
- token;
- body;
- status;
- respuesta;
- error.

##  Responsive

Probar:

```text
Móvil
Tablet
Escritorio
```

Revisar navegación, botones, formularios, tarjetas, tablas e imágenes.

##  Docker

```bash
docker build -t vitalmind-frontend .
```

Validar construcción, inicio, recursos y conexión.

##  Producción

Validar después del deploy:

- inicio;
- login;
- navegación;
- API;
- rutas;
- responsive;
- consola;
- recursos.

##  Severidad

| Nivel | Descripción |
|---|---|
| Crítico | Bloquea el sistema o compromete seguridad |
| Alto | Bloquea función importante |
| Medio | Afecta función no crítica |
| Bajo | Mejora menor o visual |

## 📸 Evidencias

```text
Evidencias/
├── AUTH/
├── USER/
├── HEALTH/
├── API/
├── MOBILE/
├── WEAR/
├── DOCKER/
└── DEPLOY/
```

##  Criterio de liberación

La versión puede liberarse cuando:

- los flujos principales funcionan;
- no hay defectos críticos;
- los defectos altos están resueltos o controlados;
- las pruebas de integración pasan;
- existen evidencias;
- la documentación está actualizada.
