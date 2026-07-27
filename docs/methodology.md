# Metodología del Proyecto VitalMind AI

## 1. Introducción

VitalMind AI combina dos enfoques metodológicos complementarios:

- **CRISP-DM**, utilizado para organizar el análisis de datos, la simulación del dataset, el proceso ETL, el modelado, la evaluación y el despliegue de los mecanismos de Machine Learning.
- **Scrum**, utilizado para planificar, coordinar, desarrollar, revisar e integrar los componentes de software del proyecto.

Esta separación permite evitar la confusión entre la metodología de análisis de datos y la metodología de desarrollo de software. CRISP-DM guía el trabajo relacionado con datos y modelos, mientras que Scrum organiza el trabajo colaborativo, los sprints, las tareas, los responsables y la entrega incremental del sistema.

---

## 2. Metodologías seleccionadas

### 2.1 Metodología para análisis de datos: CRISP-DM

CRISP-DM se aplicará mediante seis fases:

1. Comprensión del negocio.
2. Comprensión de los datos.
3. Preparación de los datos.
4. Modelado.
5. Evaluación.
6. Despliegue.

### 2.2 Metodología para desarrollo de software: Scrum

Scrum se utilizará para dividir el trabajo en ciclos iterativos llamados sprints, organizar el backlog, asignar responsables, revisar avances, detectar bloqueos y entregar incrementos funcionales del proyecto.

---

## 3. Justificación de la metodología

VitalMind AI integra frontend, backend, bases de datos, Machine Learning, documentación, seguridad, QA e integración. Debido a esta diversidad de módulos, se requiere una metodología que permita:

- Dividir el trabajo en entregables claros.
- Priorizar funcionalidades.
- Asignar responsables.
- Revisar avances de forma periódica.
- Detectar riesgos y bloqueos.
- Mantener trazabilidad mediante Jira y GitHub.
- Integrar datos, modelos, API y frontend.
- Actualizar documentación conforme avance el proyecto.

CRISP-DM es adecuada porque organiza el ciclo completo de análisis de datos y Machine Learning. Scrum complementa este proceso al proporcionar una estructura de trabajo incremental para el desarrollo del sistema.

---

## 4. Aplicación de CRISP-DM en VitalMind AI

| Fase | Aplicación en VitalMind AI | Entregables relacionados |
|---|---|---|
| **Comprensión del negocio** | Definición de la problemática, usuarios, objetivos, alcance, limitaciones y necesidades de información. | `docs/context.md` |
| **Comprensión de los datos** | Identificación de fuentes, entidades, atributos, tipos, variables y reglas de calidad. | `docs/data-sources.md`, `docs/data-dictionary.md` |
| **Preparación de los datos** | Simulación, limpieza, transformación, ETL, anonimización, división de conjuntos y preparación para entrenamiento. | `docs/simulation-rules.md`, `docs/etl-process.md` |
| **Modelado** | Entrenamiento de modelos supervisados y no supervisados. | Notebooks, scripts y modelos serializados |
| **Evaluación** | Comparación de métricas, revisión de sobreajuste, utilidad, interpretabilidad, estabilidad y riesgo. | `docs/model-evaluation.md` |
| **Despliegue** | Integración de modelos mediante FastAPI, consumo desde el prototipo web, persistencia de inferencias y actualización con Socket.IO. | `docs/api-contracts.md`, dashboard, endpoints y pruebas |

---

## 5. Organización de Scrum

### 5.1 Product Owner

**Yazmin Gutiérrez Hernández**

Responsabilidades principales:

- Representar las necesidades del usuario.
- Priorizar funcionalidades.
- Revisar el valor de los entregables.
- Validar que el producto responda a los objetivos del proyecto.
- Participar en la priorización del Product Backlog.
- Coordinar la visión del frontend y la experiencia de usuario.

### 5.2 Scrum Master

**Citlalli Pérez Dionicio**

Responsabilidades principales:

- Facilitar la aplicación de Scrum.
- Dar seguimiento a bloqueos e impedimentos.
- Coordinar la integración entre áreas.
- Verificar el cumplimiento del flujo de trabajo.
- Apoyar la organización del tablero Jira.
- Coordinar actividades de QA e integración.

### 5.3 Equipo de desarrollo

| Nombre | Matrícula | Rol |
|---|---:|---|
| **Yazmin Gutiérrez Hernández** | 230447 | Frontend y Experiencia de Usuario |
| **Carlos Daniel García Pluma** | 230187 | Backend |
| **Jennifer Bautista Barrios** | 230317 | Backend |
| **Michelle Castro Otero** | 230881 | Inteligencia Artificial y Machine Learning |
| **Obed Guzmán Flores** | 230142 | Documentación |
| **Citlalli Pérez Dionicio** | 230237 | Control de Calidad (QA) e Integración |

Los roles serán **fijos** durante el desarrollo del proyecto.

---

## 6. Organización del trabajo en Jira

### 6.1 Proyecto

| Campo | Configuración propuesta |
|---|---|
| **Nombre** | VitalMind AI |
| **Clave** | `VMAI` |
| **Tipo** | Scrum |
| **Versión inicial** | `0.1.0-alpha` |
| **Versión objetivo** | `1.0.0-mvp` |

### 6.2 Tipos de incidencias

- **Epic:** módulo grande o bloque funcional.
- **Story:** funcionalidad que aporta valor a un usuario.
- **Task:** actividad técnica, documental o de configuración.
- **Subtask:** división de una historia o tarea.
- **Bug:** error detectado durante las pruebas.

### 6.3 Estados del tablero

```text
Backlog
   ↓
Seleccionado
   ↓
En progreso
   ↓
En revisión
   ↓
En QA
   ↓
Terminado
```

Estado adicional:

```text
Bloqueado
```

Una actividad pasa a **Bloqueado** cuando existe una dependencia, error o impedimento que evita continuar.

### 6.4 Estimación

Se utilizarán puntos de historia con la escala de Fibonacci:

```text
1, 2, 3, 5, 8, 13
```

| Puntos | Interpretación |
|---:|---|
| 1 | Cambio muy pequeño |
| 2 | Tarea sencilla |
| 3 | Tarea pequeña |
| 5 | Trabajo medio |
| 8 | Trabajo grande |
| 13 | Trabajo demasiado grande; debe dividirse |

---

## 7. Épicas del proyecto

1. Planeación y contexto del proyecto.
2. Gestión Scrum y colaboración.
3. Fuentes, datos y simulación.
4. Data Warehouse y proceso ETL.
5. Análisis Exploratorio de Datos.
6. Modelos supervisados.
7. Modelos no supervisados.
8. Backend y API inteligente.
9. Frontend y dashboard.
10. Integración y Socket.IO.
11. QA, seguridad y ética.
12. Documentación y entrega final.

---

## 8. Plan de sprints

Se propone trabajar con **6 sprints de 2 semanas** cada uno.


### Sprint 1 — Planeación y bases del proyecto

**Objetivo:** establecer el contexto, la organización, la metodología, la arquitectura inicial y las reglas de trabajo.

Entregables:

- Proyecto Jira configurado.
- Roles definidos.
- Product Backlog inicial.
- Contexto aprobado.
- Metodología documentada.
- Requerimientos.
- Arquitectura preliminar.
- Estrategia de ramas.
- Wireframes iniciales.

### Sprint 2 — Propuestas, fuentes y simulación

**Objetivo:** definir la estructura de datos y generar el dataset sintético.

Entregables:

- Diez propuestas supervisadas.
- Diez propuestas no supervisadas.
- Fuentes y entidades.
- Diccionario de datos.
- Reglas de simulación.
- Script generador.
- Dataset sintético.
- Validaciones iniciales.

### Sprint 3 — Data Warehouse, ETL y EDA

**Objetivo:** transformar, almacenar y analizar los datos.

Entregables:

- Data Warehouse o Data Mart.
- Tabla de hechos y dimensiones.
- Proceso ETL.
- Dataset procesado.
- Notebook EDA.
- Gráficas e interpretaciones.
- Conjuntos de entrenamiento, validación, prueba e inferencia.

### Sprint 4 — Modelado y API de Machine Learning

**Objetivo:** entrenar, evaluar, seleccionar y desplegar modelos.

Entregables:

- Modelos de clasificación.
- Modelos de regresión.
- Agrupamiento.
- Reducción de dimensionalidad.
- Comparación de métricas.
- Selección de un modelo supervisado.
- Selección de un modelo no supervisado.
- Modelos serializados.
- Endpoints inteligentes.
- Swagger/OpenAPI.

### Sprint 5 — Aplicación web, dashboard e integración

**Objetivo:** integrar frontend, backend, modelos y comunicación en tiempo real.

Entregables:

- Registro e inicio de sesión.
- Gestión de perfil.
- Registro de síntomas.
- Registro de hábitos.
- Historial médico.
- Dashboard.
- Consumo de endpoints.
- Persistencia de inferencias.
- Socket.IO.
- Prototipo inicial del chatbot.
- Pruebas iniciales de integración.

### Sprint 6 — QA, documentación y entrega

**Objetivo:** validar, corregir, documentar y preparar la entrega final.

Entregables:

- Pruebas completas.
- Correcciones.
- README final.
- Documentación de `docs/`.
- Manual de instalación.
- Manual de usuario.
- Evidencias de GitHub.
- Presentación.
- Video demostrativo.
- Release `1.0.0-mvp`.

---

## 9. Eventos Scrum

### 9.1 Sprint Planning

Se realizará al inicio de cada sprint.

Propósito:

- Seleccionar historias y tareas.
- Definir el objetivo del sprint.
- Asignar responsables.
- Estimar puntos.
- Revisar dependencias.
- Confirmar criterios de aceptación.

Duración propuesta: **entre 60 y 90 minutos**.

### 9.2 Daily Scrum

Se propone realizar reuniones breves **dos veces por semana**, debido a la disponibilidad académica del equipo.

Duración máxima recomendada: **15 minutos**.

### 9.3 Sprint Review

Se realizará al final de cada sprint.

Participantes:

- Equipo completo.
- Product Owner.
- Scrum Master.
- Docente, cuando corresponda.

Propósito:

- Mostrar los entregables terminados.
- Revisar evidencias.
- Confirmar criterios de aceptación.
- Registrar observaciones.
- Decidir qué se integra.

### 9.4 Sprint Retrospective

Sí se realizará.

Propósito:

- Identificar qué funcionó.
- Detectar problemas.
- Definir mejoras.
- Revisar la comunicación.
- Evaluar la organización del trabajo.

Duración propuesta: **30 a 45 minutos**.

### 9.5 Refinamiento del backlog

Se realizará **una vez por semana**.

Actividades:

- Aclarar historias.
- Dividir tareas grandes.
- Revisar prioridades.
- Actualizar estimaciones.
- Confirmar dependencias.
- Preparar el siguiente sprint.

---

## 10. Gestión del trabajo

### 10.1 Creación y asignación de tareas

- La Scrum Master coordinará la creación y organización de incidencias en Jira.
- El Product Owner participará en la priorización.
- Cada responsable técnico podrá proponer tareas de su módulo.
- La asignación se realizará con base en el rol de cada integrante.
- Las tareas deberán pertenecer a una épica y a un sprint.

### 10.2 Estructura de identificadores

Jira generará identificadores con la clave del proyecto:

```text
VMAI-1
VMAI-2
VMAI-3
```

Los títulos deberán ser claros, por ejemplo:

```text
VMAI-12 — Crear diccionario de datos
VMAI-24 — Implementar endpoint supervisado
VMAI-31 — Ejecutar pruebas de integración
```

### 10.3 Prioridades

| Prioridad | Uso |
|---|---|
| **Highest** | Bloquea la entrega, la seguridad o la integración |
| **High** | Requerimiento obligatorio |
| **Medium** | Funcionalidad necesaria no bloqueante |
| **Low** | Mejora visual o funcionalidad adicional |

---

## 11. Criterios de aceptación

### 11.1 Aprobación de tareas

Una tarea será validada por integrantes distintos al responsable directo del módulo.

| Área | Revisión |
|---|---|
| **Frontend** | Todos los integrantes, excepto Yazmin |
| **Backend** | Todos los integrantes, excepto Carlos y Jennifer |
| **Machine Learning** | Todos los integrantes, excepto Michelle |
| **QA** | Todos los integrantes, excepto Citlalli |
| **Documentación** | Todos los integrantes, excepto Obed |
| **Integración final** | Docente |

### 11.2 Requisitos para considerar una tarea terminada

- Cumple su objetivo.
- Cumple los criterios de aceptación.
- Tiene responsable.
- Tiene evidencias.
- Fue revisada por integrantes distintos al autor.
- No contiene errores críticos.
- Tiene pruebas cuando corresponde.
- Tiene documentación actualizada cuando corresponde.
- Se integró mediante Pull Request.
- No expone secretos ni datos sensibles.

### 11.3 Pull Requests

- Los cambios deberán integrarse mediante Pull Request.
- Al menos **una persona distinta al autor** deberá revisar el Pull Request.
- Para cambios de integración final, QA deberá participar en la revisión.
- No se deberá trabajar directamente sobre `main`.

---

## 12. Definition of Ready

Una incidencia está lista para entrar a un sprint cuando:

- Tiene título claro.
- Tiene descripción.
- Pertenece a una épica.
- Tiene responsable.
- Tiene prioridad.
- Tiene estimación.
- Tiene criterios de aceptación.
- Tiene dependencias identificadas.
- El equipo comprende qué debe hacerse.
- Existen insumos suficientes para comenzar.

---

## 13. Definition of Done

Una incidencia puede marcarse como terminada cuando:

- El cambio solicitado fue implementado.
- Cumple los criterios de aceptación.
- Fue revisado.
- Tiene pruebas cuando corresponde.
- No existen errores críticos.
- La documentación fue actualizada.
- Tiene evidencias en Jira.
- Se creó un Pull Request.
- El cambio fue integrado.
- No contiene credenciales ni datos sensibles.

---

## 14. Control de cambios

### 14.1 Solicitud de cambios

Los cambios de requerimientos deberán registrarse en Jira como:

- Nueva historia.
- Nueva tarea.
- Cambio en una historia existente.
- Bug.
- Mejora.

### 14.2 Aprobación

- El Product Owner revisará el impacto funcional.
- La Scrum Master revisará el impacto en planificación e integración.
- El equipo técnico revisará la viabilidad.
- El docente aprobará cambios relevantes que afecten la entrega final.

### 14.3 Registro

Los cambios se registrarán principalmente en:

- Jira.
- GitHub.
- Microsoft Teams.
- Documentación del proyecto.

WhatsApp podrá utilizarse para comunicación rápida, pero las decisiones importantes deberán reflejarse en Jira o GitHub.

### 14.4 Tareas no terminadas

Cuando una tarea no se complete:

1. Se identificará la causa.
2. Se actualizará su estado.
3. Se registrará el bloqueo.
4. Se dividirá si es demasiado grande.
5. Se regresará al backlog o se moverá al siguiente sprint.
6. Se revisará su prioridad.

---

## 15. Seguimiento y evidencias

Se conservarán las siguientes evidencias:

- Capturas del tablero Jira.
- Commits.
- Ramas.
- Pull Requests.
- Prototipos de Figma.
- Resultados de pruebas.
- Capturas del dashboard.
- Evidencias de integración.
- Modelos y métricas.
- Documentos Markdown.

No se utilizarán actas o minutas formales para las reuniones. Por ello, las decisiones relevantes deberán quedar registradas en Jira, GitHub o en la documentación correspondiente.

---

## 16. Herramientas

| Herramienta | Uso |
|---|---|
| **Jira** | Backlog, épicas, historias, tareas, sprints y seguimiento |
| **Microsoft Teams** | Reuniones y comunicación formal |
| **WhatsApp** | Comunicación rápida |
| **GitHub** | Repositorio, ramas, commits, Pull Requests y releases |
| **Figma** | Diseño UX/UI y prototipos |
| **VS Code** | Desarrollo y documentación |
| **Git** | Control de versiones |

---

## 17. Relación entre Scrum y CRISP-DM

CRISP-DM define qué debe ocurrir en el proceso de datos y Machine Learning. Scrum define cómo se organiza el trabajo para lograrlo.

| CRISP-DM | Sprints relacionados |
|---|---|
| Comprensión del negocio | Sprint 1 |
| Comprensión de los datos | Sprint 2 |
| Preparación de los datos | Sprints 2 y 3 |
| Modelado | Sprint 4 |
| Evaluación | Sprints 4 y 6 |
| Despliegue | Sprints 4 y 5 |
| Validación final | Sprint 6 |

---

## 18. Riesgos metodológicos

| Riesgo | Medida de control |
|---|---|
| Tareas demasiado grandes | Dividir en subtareas |
| Falta de información | Marcar como bloqueado y registrar dependencia |
| Cambios constantes | Registrar en Jira y priorizar |
| Falta de revisión | Aplicar revisión cruzada |
| Trabajo directo en `main` | Uso obligatorio de ramas y Pull Requests |
| Documentación desactualizada | Incluir documentación en Definition of Done |
| Métricas inventadas | Publicar solo resultados obtenidos y validados |
| Datos sensibles expuestos | Revisiones de seguridad y uso de `.env.example` |

---

## 19. Conclusión

VitalMind AI utilizará CRISP-DM para organizar el análisis de datos y Machine Learning, y Scrum para gestionar el desarrollo colaborativo del software.

La combinación de ambas metodologías permitirá relacionar la problemática, los datos, la preparación, los modelos, la API, el dashboard, las pruebas y la documentación dentro de un proceso ordenado, incremental y verificable.

El proyecto se organizará mediante seis sprints de dos semanas, con roles fijos, seguimiento en Jira, control de versiones en GitHub, revisión cruzada, pruebas, evidencias y validación final por parte del docente.
