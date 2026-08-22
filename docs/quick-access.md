# Acceso rápido a archivos y carpetas

Este documento funciona como un **mapa de navegación de VitalMind AI**. Reúne las carpetas principales, las subcarpetas más importantes y los documentos clave del proyecto para facilitar su consulta desde GitHub.

> Los enlaces están definidos desde `docs/acceso-rapido.md`. No se incluyen dependencias, archivos generados ni recursos internos de compilación para mantener una navegación breve y útil.
---

## Repositorios y aplicaciones desplegadas

VitalMind IA está organizado en los siguientes repositorios y servicios:

| Componente | Repositorio / acceso | Descripción |
|---|---|---|
| Aplicación móvil y wearable | [VitalMind Mobile Wear](https://github.com/Ktmich2095/VitalMind-Mobile-Wear) | Aplicación móvil y módulo Wear OS para el monitoreo de métricas de salud mediante smartwatch. |
| Aplicación web, backend y base de datos | [VitalMind Vercel](https://github.com/yaz-gutzz/VitalMind_Vercel) | Código del frontend web, backend y configuración relacionada con la base de datos. |
| Aplicación web desplegada | [Abrir VitalMind Web](https://vital-mind-vercel-3p4r.vercel.app/auth) | Acceso a la interfaz web de VitalMind IA. |
| API desplegada | [Abrir API VitalMind](https://vitalmind-ia.up.railway.app/) | Servicio de API disponible en Railway. |
---
## Navegación principal

| Sección | Contenido | Acceso |
| --- | --- | --- |
| Proyecto | Presentación general de VitalMind AI | [README principal](../README.md) |
| Recursos visuales | Logotipos, organigrama y diagrama de Gantt | [Abrir `assets/`](../assets/) |
| Backend | API principal, lógica de negocio y pruebas | [Abrir `Back_VitalMind/`](../Back_VitalMind/) |
| Base de datos | Respaldos, diagramas, procedimientos y tablas | [Abrir `Data Base/`](../Data%20Base/) |
| Documentación | Guías, metodología, contratos y evaluación | [Abrir `docs/`](./) |
| Evidencias | Capturas de la API, dashboard y aplicaciones | [Abrir `Evidencias/`](../Evidencias/) |
| Frontend | Aplicación web, móvil y módulo Wear OS | [Abrir `Frontend/`](../Frontend/) |
| Machine Learning | Modelos, análisis, datos y pruebas | [Abrir `ml-service/`](../ml-service/) |
| Reportes | Resultados de correcciones y pruebas | [Abrir `reports/`](../reports/) |
| API integrada | Backend, base de datos y dashboard en tiempo real | [Abrir `vitalmind-api/`](../vitalmind-api/) |

## Estructura general

```text
9A-IDGS-ECBD-VitalMind-/
├── assets/
├── Back_VitalMind/
│   ├── src/
│   └── tests/
├── Data Base/
│   ├── Backups/
│   ├── Diagram/
│   └── Scripts/
│       ├── Procedures/
│       └── tables/
├── docs/
├── Evidencias/
│   ├── API/
│   ├── Dashboard/
│   └── Frontend/
├── Frontend/
│   ├── Movil_Wearable/
│   └── Web/
├── ml-service/
│   ├── app/
│   ├── data/
│   ├── docs/
│   ├── reports/
│   ├── scripts/
│   └── tests/
├── reports/
│   ├── fix_api-errors/
│   ├── test-backend/
│   └── test-integration/
└── vitalmind-api/
    ├── dashboard/
    ├── database/
    ├── docs/
    ├── migrations/
    ├── scripts/
    └── src/
```

## Backend principal

| Ruta | Descripción | Acceso |
| --- | --- | --- |
| `Back_VitalMind/` | Servicio backend principal de la plataforma | [Abrir carpeta](../Back_VitalMind/) |
| `Back_VitalMind/src/` | Código fuente, controladores y lógica de negocio | [Abrir carpeta](../Back_VitalMind/src/) |
| `Back_VitalMind/tests/` | Pruebas del servicio backend | [Abrir carpeta](../Back_VitalMind/tests/) |
| `Back_VitalMind/README.md` | Descripción y ejecución del componente | [Consultar README](../Back_VitalMind/README.md) |

## Base de datos

| Ruta | Descripción | Acceso |
| --- | --- | --- |
| `Data Base/` | Módulo general de persistencia de VitalMind AI | [Abrir carpeta](../Data%20Base/) |
| `Data Base/Backups/` | Respaldos completos, de datos y de estructura | [Abrir carpeta](../Data%20Base/Backups/) |
| `Data Base/Backups/full_backup/` | Respaldo integral de la base de datos | [Abrir carpeta](../Data%20Base/Backups/full_backup/) |
| `Data Base/Diagram/` | Modelo y diccionario visual de datos | [Abrir carpeta](../Data%20Base/Diagram/) |
| `Data Base/Scripts/` | Scripts de creación, sincronización y mantenimiento | [Abrir carpeta](../Data%20Base/Scripts/) |
| `Data Base/Scripts/Procedures/` | Procedimientos almacenados y vistas auxiliares | [Abrir carpeta](../Data%20Base/Scripts/Procedures/) |
| `Data Base/Scripts/tables/` | Definiciones SQL de las tablas del sistema | [Abrir carpeta](../Data%20Base/Scripts/tables/) |
| `Data Base/README.md` | Descripción general del módulo | [Consultar README](../Data%20Base/README.md) |

## Frontend

### Aplicación móvil y Wear OS

| Ruta | Descripción | Acceso |
| --- | --- | --- |
| `Frontend/Movil_Wearable/` | Contenedor de la solución móvil y wearable | [Abrir carpeta](../Frontend/Movil_Wearable/) |
| `Frontend/Movil_Wearable/Frontend_Movil_Wearable/` | Proyecto Android desarrollado con Kotlin y Gradle | [Abrir proyecto](../Frontend/Movil_Wearable/Frontend_Movil_Wearable/) |
| `Frontend/Movil_Wearable/Frontend_Movil_Wearable/wear/` | Módulo destinado al smartwatch con Wear OS | [Abrir módulo](../Frontend/Movil_Wearable/Frontend_Movil_Wearable/wear/) |
| `Frontend/Movil_Wearable/Frontend_Movil_Wearable/readme.md` | Descripción e instrucciones del proyecto wearable | [Consultar README](../Frontend/Movil_Wearable/Frontend_Movil_Wearable/readme.md) |

### Aplicación web

| Ruta | Descripción | Acceso |
| --- | --- | --- |
| `Frontend/Web/` | Contenedor del frontend web | [Abrir carpeta](../Frontend/Web/) |
| `Frontend/Web/Front_VitalMind/Front VitalMind/` | Aplicación web principal | [Abrir proyecto](../Frontend/Web/Front_VitalMind/Front%20VitalMind/) |
| `.../guidelines/` | Lineamientos visuales y de desarrollo | [Abrir carpeta](../Frontend/Web/Front_VitalMind/Front%20VitalMind/guidelines/) |
| `.../public/` | Recursos públicos de la aplicación | [Abrir carpeta](../Frontend/Web/Front_VitalMind/Front%20VitalMind/public/) |
| `.../src/` | Componentes, vistas y lógica del frontend | [Abrir carpeta](../Frontend/Web/Front_VitalMind/Front%20VitalMind/src/) |
| `.../README.md` | Configuración y ejecución de la aplicación web | [Consultar README](../Frontend/Web/Front_VitalMind/Front%20VitalMind/README.md) |

## Servicio de Machine Learning

| Ruta | Descripción | Acceso |
| --- | --- | --- |
| `ml-service/` | Microservicio de análisis supervisado y no supervisado | [Abrir carpeta](../ml-service/) |
| `ml-service/app/` | Aplicación principal del servicio ML | [Abrir carpeta](../ml-service/app/) |
| `ml-service/app/api/` | Rutas y endpoints de análisis | [Abrir carpeta](../ml-service/app/api/) |
| `ml-service/app/core/` | Configuración y componentes centrales | [Abrir carpeta](../ml-service/app/core/) |
| `ml-service/app/models/` | Modelos y artefactos de Machine Learning | [Abrir carpeta](../ml-service/app/models/) |
| `ml-service/app/notebooks/` | Cuadernos de exploración y entrenamiento | [Abrir carpeta](../ml-service/app/notebooks/) |
| `ml-service/app/prompts/` | Prompts utilizados por las funciones de IA | [Abrir carpeta](../ml-service/app/prompts/) |
| `ml-service/app/schemas/` | Esquemas de entrada y salida de la API | [Abrir carpeta](../ml-service/app/schemas/) |
| `ml-service/app/services/` | Servicios de inferencia y procesamiento | [Abrir carpeta](../ml-service/app/services/) |
| `ml-service/app/utils/` | Utilidades compartidas | [Abrir carpeta](../ml-service/app/utils/) |
| `ml-service/data/` | Datos utilizados por el microservicio | [Abrir carpeta](../ml-service/data/) |
| `ml-service/docs/` | Documentación específica del componente | [Abrir carpeta](../ml-service/docs/) |
| `ml-service/reports/` | Resultados y reportes de modelos | [Abrir carpeta](../ml-service/reports/) |
| `ml-service/scripts/` | Scripts auxiliares y de procesamiento | [Abrir carpeta](../ml-service/scripts/) |
| `ml-service/tests/` | Pruebas automatizadas del servicio | [Abrir carpeta](../ml-service/tests/) |
| `ml-service/README.md` | Instalación, configuración y uso | [Consultar README](../ml-service/README.md) |

## API integrada y dashboard

| Ruta | Descripción | Acceso |
| --- | --- | --- |
| `vitalmind-api/` | API integrada del proyecto | [Abrir carpeta](../vitalmind-api/) |
| `vitalmind-api/dashboard/` | Dashboard conectado a los datos en tiempo real | [Abrir carpeta](../vitalmind-api/dashboard/) |
| `vitalmind-api/dashboard/index.html` | Punto de entrada del dashboard | [Abrir archivo](../vitalmind-api/dashboard/index.html) |
| `vitalmind-api/database/` | Conexión y recursos de persistencia | [Abrir carpeta](../vitalmind-api/database/) |
| `vitalmind-api/docs/` | Documentación específica de la API | [Abrir carpeta](../vitalmind-api/docs/) |
| `vitalmind-api/migrations/` | Migraciones de la base de datos | [Abrir carpeta](../vitalmind-api/migrations/) |
| `vitalmind-api/scripts/` | Scripts de apoyo y carga de datos | [Abrir carpeta](../vitalmind-api/scripts/) |
| `vitalmind-api/src/` | Código fuente de la API | [Abrir carpeta](../vitalmind-api/src/) |
| `vitalmind-api/README.md` | Configuración y ejecución del componente | [Consultar README](../vitalmind-api/README.md) |

## Evidencias y reportes

| Ruta | Descripción | Acceso |
| --- | --- | --- |
| `Evidencias/API/` | Capturas de endpoints y pruebas de la API | [Ver evidencias](../Evidencias/API/) |
| `Evidencias/Dashboard/` | Capturas de gráficas y actualización del dashboard | [Ver evidencias](../Evidencias/Dashboard/) |
| `Evidencias/Frontend/` | Capturas de las interfaces web, móvil y administrativa | [Ver evidencias](../Evidencias/Frontend/) |
| `docs/evidencias.md` | Índice visual de todas las capturas | [Consultar documento](evidencias.md) |
| `reports/fix_api-errors/` | Registro de correcciones aplicadas a la API | [Abrir reporte](../reports/fix_api-errors/) |
| `reports/test-backend/` | Evidencias y resultados de pruebas del backend | [Abrir reporte](../reports/test-backend/) |
| `reports/test-integration/` | Evidencias y resultados de pruebas de integración | [Abrir reporte](../reports/test-integration/) |

## Documentación del proyecto

### Arquitectura, datos y metodología

| Documento | Contenido | Acceso |
| --- | --- | --- |
| `context.md` | Contexto, problemática y alcance | [Abrir](context.md) |
| `methodology.md` | Metodología de trabajo y desarrollo | [Abrir](methodology.md) |
| `data-sources.md` | Fuentes de datos utilizadas | [Abrir](data-sources.md) |
| `data-dictionary.md` | Definición de variables y campos | [Abrir](data-dictionary.md) |
| `data-warehouse.md` | Organización del almacén de datos | [Abrir](data-warehouse.md) |
| `etl-process.md` | Proceso de extracción, transformación y carga | [Abrir](etl-process.md) |
| `ethics.md` | Consideraciones éticas y de privacidad | [Abrir](ethics.md) |

### API, ejecución y pruebas

| Documento | Contenido | Acceso |
| --- | --- | --- |
| `api-contracts.md` | Contratos, entradas y respuestas de la API | [Abrir](api-contracts.md) |
| `runbook.md` | Puesta en marcha y operación del sistema | [Abrir](runbook.md) |
| `testing.md` | Estrategia y resultados de pruebas | [Abrir](testing.md) |
| `simulation-rules.md` | Reglas empleadas para generar o simular datos | [Abrir](simulation-rules.md) |
| `user-guide.md` | Guía de uso para usuarios | [Abrir](user-guide.md) |

### Inteligencia artificial y resultados

| Documento | Contenido | Acceso |
| --- | --- | --- |
| `ai-usage.md` | Uso de inteligencia artificial en el proyecto | [Abrir](ai-usage.md) |
| `proposals.md` | Propuestas de modelos supervisados y no supervisados | [Abrir](proposals.md) |
| `model-evaluation.md` | Evaluación y comparación de modelos | [Abrir](model-evaluation.md) |
| `evidencias.md` | Recopilación visual de pruebas y pantallas | [Abrir](evidencias.md) |
| `VitalMind_IA_Presentacion.pdf` | Presentación general de VitalMind AI | [Abrir presentación](VitalMind_IA_Presentacion.pdf) |

---

[Volver al README principal](../README.md)
