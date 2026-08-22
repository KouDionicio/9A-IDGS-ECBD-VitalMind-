<div align="center">

# 🛠️ VitalMind Frontend
## Guía de Mantenimiento

</div>

<p align="center">

[![Mantenimiento](https://img.shields.io/badge/Mantenimiento-Gu%C3%ADa-0EA5E9?style=for-the-badge)](#) [![Git](https://img.shields.io/badge/Git-Workflow-F05032?style=for-the-badge&logo=git&logoColor=FFFFFF)](https://git-scm.com/) [![Documentación](https://img.shields.io/badge/Documentaci%C3%B3n-Actualizada-16A34A?style=for-the-badge)](#) [![Estado](https://img.shields.io/badge/Estado-Activo-22C55E?style=for-the-badge)](#) [![Versión](https://img.shields.io/badge/Versi%C3%B3n-2.1.0-2E7D32?style=for-the-badge)](#)

</p>

---
##  Propósito

Mantener sincronizados el código, configuración, pruebas, evidencias y documentación.

##  Actualizaciones

Cada cambio importante debe revisar:

- código;
- dependencias;
- variables;
- Docker;
- despliegue;
- pruebas;
- README;
- evidencias.

##  Dependencias

Antes:

```bash
npm outdated
```

Después:

```bash
npm install
npm run build
```

Ejecutar nuevamente las pruebas.

##  Cambios estructurales

Actualizar cuando cambie la estructura:

```text
README.md
Arquitectura_Frontend.md
Manual_Instalacion.md
Plan_Pruebas.md
```

##  Configuración

Toda variable nueva debe documentarse en `.env.example`.

Nunca registrar secretos.

##  Releases

Registrar:

- versión;
- fecha;
- nuevas funciones;
- correcciones;
- pruebas;
- commit/tag;
- incidencias conocidas.

##  Continuidad

Antes de entregar una rama:

1. actualizar desde la rama base;
2. explicar cambios;
3. documentar configuración;
4. ejecutar pruebas;
5. agregar evidencias.

##  Limpieza

Eliminar:

- archivos temporales;
- capturas duplicadas;
- builds accidentales;
- secretos;
- carpetas generadas innecesariamente.

##  Regla principal

La documentación debe reflejar la estructura real del proyecto. Si el código cambia, la documentación debe revisarse en el mismo ciclo de trabajo.
