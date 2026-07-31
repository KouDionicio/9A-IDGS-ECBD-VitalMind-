<div align="center">

# ⚖️ Ética, Privacidad y Uso Responsable — VitalMind AI

<img src="https://img.shields.io/badge/Estado-Avance%20documental-F59E0B?style=for-the-badge" alt="Estado">
<img src="https://img.shields.io/badge/Datos-Sintéticos-2563EB?style=for-the-badge" alt="Datos">
<img src="https://img.shields.io/badge/Enfoque-Preventivo-0F766E?style=for-the-badge" alt="Enfoque">

</div>
---

## 1. Propósito

Este documento establece los principios éticos, de privacidad y seguridad que deben orientar el desarrollo de **VitalMind AI**.

La plataforma busca apoyar el seguimiento físico y emocional mediante registros, análisis de datos y modelos de Machine Learning. Sus resultados deben utilizarse únicamente como orientación preventiva e informativa.



---

## 2. Alcance

Estas reglas aplican a:

- Dataset sintético y procesos de transformación.
- Modelos supervisados y no supervisados.
- API inteligente.
- Chatbot.
- Dashboard.
- Base de datos.
- Notificaciones y alertas.
- Integraciones con dispositivos o servicios externos.
- Documentación y pruebas.

---

## 3. Principios éticos

| Principio | Aplicación en VitalMind AI |
|---|---|
| **Beneficio** | Las funciones deben apoyar el bienestar y evitar recomendaciones innecesarias o riesgosas. |
| **No daño** | Ningún resultado debe presentarse como diagnóstico o decisión clínica definitiva. |
| **Autonomía** | El usuario debe poder aceptar, rechazar o ignorar recomendaciones y notificaciones. |
| **Privacidad** | Solo deben recolectarse los datos necesarios para cada funcionalidad. |
| **Transparencia** | La plataforma debe indicar cuándo una respuesta o recomendación fue generada por IA. |
| **Equidad** | Los modelos deben revisarse para detectar diferencias injustificadas entre grupos. |
| **Trazabilidad** | Las predicciones deben registrar fecha, versión del modelo y datos generales de entrada. |
| **Supervisión humana** | Los casos sensibles deben incluir límites claros y orientación hacia ayuda profesional. |

---

## 4. Naturaleza de los datos

El proyecto utiliza actualmente datos **sintéticos** para fines académicos.

Esto significa que:

- Los registros no representan pacientes reales.
- Los identificadores son artificiales.
- Los resultados no pueden considerarse evidencia clínica.
- Los modelos deben volver a validarse antes de utilizar datos reales.
- Los respaldos de demostración deben evitar nombres, correos y datos reconocibles.

Aunque los datos sean sintéticos, deben manejarse con prácticas similares a las que se aplicarían a información sensible.

---

## 5. Privacidad y minimización

VitalMind AI debe recolectar únicamente la información necesaria para ofrecer sus funciones.

### Datos que requieren mayor protección

- Síntomas.
- Signos físicos.
- Medicamentos.
- Antecedentes médicos.
- Estado de ánimo.
- Estrés.
- Conversaciones con el chatbot.
- Inferencias y niveles de riesgo.
- Historial de uso de la aplicación.

### Reglas mínimas

- No utilizar nombres reales en datasets académicos.
- No incluir CURP, NSS, domicilio o teléfonos reales.
- Evitar guardar información sensible dentro de logs técnicos.
- No publicar respaldos de base de datos en repositorios abiertos.
- Anonimizar textos antes de analizarlos.
- Limitar el acceso según el rol del usuario.
- Documentar qué datos se almacenan y para qué se utilizan.

---

## 6. Consentimiento y control del usuario

Cuando la plataforma utilice datos reales, deberá informar:

- Qué información se recopila.
- Para qué se utiliza.
- Qué modelos analizan los datos.
- Qué recomendaciones pueden generarse.
- Cuáles son los límites del sistema.
- Durante cuánto tiempo se conserva la información.

El usuario deberá poder:

- Consultar sus datos.
- Corregir información incorrecta.
- Eliminar registros cuando corresponda.
- Desactivar notificaciones.
- Rechazar recomendaciones.
- Cerrar su cuenta.


---

## 7. Seguridad de la información

Controles definidos o previstos para el proyecto:

| Control | Estado |
|---|---|
| Hash de contraseñas con bcrypt | Previsto / identificado en Backend |
| Autenticación con JWT | Prevista |
| Comunicación mediante HTTPS/TLS | Prevista |
| Control de acceso por roles | Implementación parcial |
| Auditoría de acciones | Identificada en la base operacional |
| Protección de secretos y variables de entorno | Pendiente de validación |
| Cifrado de datos almacenados | Pendiente de definición |
| Política de respaldos | Pendiente |
| Eliminación segura de datos | Pendiente |

Las contraseñas, tokens, cadenas de conexión y claves privadas nunca deben almacenarse directamente en el repositorio.

---

## 8. Uso responsable de Machine Learning

### Reglas generales

- Separar entrenamiento, validación y prueba.
- Evitar fuga de información.
- Documentar variables utilizadas y excluidas.
- Evaluar métricas globales y por clase.
- Revisar errores en la clase de mayor riesgo.
- Mantener una versión identificable del modelo.
- No ocultar limitaciones.
- No utilizar una métrica alta como prueba de validez clínica.

### Riesgos principales

| Riesgo | Consecuencia | Medida preventiva |
|---|---|---|
| Falso negativo | No detectar un registro relevante | Priorizar Recall en clases sensibles y revisar errores |
| Falso positivo | Generar preocupación innecesaria | Usar lenguaje preventivo y solicitar confirmación |
| Sesgo | Peor desempeño para ciertos grupos | Evaluar métricas por edad, perfil y otras variables disponibles |
| Fuga de información | Métricas artificialmente altas | Usar particiones temporales o por usuario |
| Sobreajuste | Mal desempeño con datos nuevos | Validación independiente y control de complejidad |
| Falta de explicación | El usuario no entiende el resultado | Mostrar factores generales y nivel de confianza |
| Dependencia excesiva | El usuario confía demasiado en la IA | Repetir límites y recomendar atención profesional cuando aplique |

---

## 9. Alertas y clasificación de riesgo

Las alertas deben:

- Utilizar lenguaje claro y no alarmista.
- Evitar afirmar que el usuario tiene una enfermedad.
- Indicar que la recomendación se basa en datos registrados.
- Permitir confirmar o corregir información.
- Diferenciar entre seguimiento básico, prevención y posible atención profesional.
- Registrar la versión del modelo que generó la inferencia.

Ejemplo de mensaje adecuado:

> Se identificaron cambios en tus registros recientes. Considera dar seguimiento a tus síntomas y consultar a un profesional si continúan o empeoran.

Ejemplo que debe evitarse:

> Tienes una enfermedad grave.

---

## 10. Chatbot y mensajes sensibles

El chatbot debe:

- Informar que es un asistente automatizado.
- Evitar diagnóstico y prescripción.
- Reconocer preguntas fuera de alcance.
- No solicitar datos innecesarios.
- Proteger el historial conversacional.
- Redirigir a atención profesional en situaciones sensibles.
- Utilizar respuestas previamente revisadas para escenarios de riesgo.
- Evitar lenguaje culpabilizante o manipulador.

La clasificación de mensajes sensibles deberá validarse con especial atención a los falsos negativos.

---

## 11. Aprendizaje no supervisado

Los clusters, perfiles y anomalías deben presentarse como patrones exploratorios.

No deben interpretarse como:

- Diagnósticos.
- Personalidades definitivas.
- Condiciones psicológicas.
- Causas médicas.
- Clasificaciones permanentes del usuario.

Los nombres de grupos deben ser neutrales y descriptivos, por ejemplo:

```text
Actividad baja y sueño irregular
```

Debe evitarse:

```text
Usuario poco saludable
```

---

## 12. Auditoría y trazabilidad

Cada inferencia debería registrar, como mínimo:

```text
inference_id
user_id o identificador anonimizado
model_name
model_version
inference_date
result
confidence
input_schema_version
```

No es recomendable almacenar en los logs más datos sensibles de los necesarios.

---

## 13. Responsabilidades del equipo

| Área | Responsabilidad |
|---|---|
| Machine Learning | Evaluar métricas, sesgo, fuga de datos y limitaciones |
| Backend | Proteger datos, autenticación, permisos, logs y endpoints |
| Frontend | Mostrar advertencias, consentimiento y resultados comprensibles |
| QA | Probar seguridad, validaciones, alertas y casos sensibles |
| Documentación | Mantener límites, riesgos, decisiones y evidencias actualizados |
| Todo el equipo | Revisar funciones sensibles antes de integrarlas |

---

## 14. Aspectos pendientes

Este documento deberá actualizarse cuando se definan:

- Política formal de consentimiento.
- Tiempo de conservación de datos.
- Procedimiento de eliminación de cuentas.
- Cifrado en almacenamiento.
- Gestión de respaldos.
- Protocolo final del chatbot.
- Evaluación de sesgos por grupo.
- Modelo no supervisado definitivo.
- Política de uso de datos reales.
- Responsable de aprobar funciones sensibles.
- Normativa aplicable al contexto de despliegue.

---

## 15. Conclusión

VitalMind AI debe mantener un enfoque preventivo, transparente y centrado en el usuario.

La calidad ética del sistema no depende únicamente de sus métricas, sino también de cómo protege los datos, comunica sus límites, reduce riesgos y permite que las decisiones importantes permanezcan bajo control humano.
