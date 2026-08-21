# Bugs documentados: fix/api-errors

**Rama:** `fix/api-errors`
**Responsable:** Citlalli Pérez Dionicio
**Origen de los hallazgos:** `test/backend` (Casos 4, 10, 16) y `test/integration` (Chatbot)

---

## Resumen del problema

Durante las pruebas de `test/backend` se detectaron **tres ocurrencias del mismo patrón de bug**:

| # | Endpoint | Escenario | Respuesta actual | Respuesta esperada |
|---|---|---|---|---|
| 1 | `POST /api/auth/register` | Campo `name` faltante | `500 Internal Server Error` | `400 Bad Request` |
| 2 | `POST /api/symptom-logs` | Valores fuera de rango (`systolic: 500`) | `500`, expone error interno de MySQL | `400 Bad Request` |
| 3 | `POST /api/auth/register` | Contraseña débil (`"123"`) | `500 Internal Server Error` | `400 Bad Request` |

## Causa raíz

Los primeros 3 casos comparten la misma causa: el Backend **sí valida** los datos (usa una librería de validación tipo Zod, a juzgar por los mensajes `"code":"too_small"`, `"invalid_type"`, `"path":[...]`), pero cuando la validación falla, el error **no se captura** en ningún middleware — se propaga tal cual hasta el manejador de errores genérico de Express, que responde `500` en vez de convertirlo en `400`.

Esto **no es un problema de 3 endpoints distintos** — es un problema de que **falta un middleware global de manejo de errores** que intercepte los errores de validación (`ZodError` u otro) antes de que lleguen al manejador genérico.

## Corrección propuesta

Agregar un middleware de manejo de errores al final de la cadena de Express, que detecte errores de validación y responda `400` con un mensaje limpio, en vez de dejar pasar el error crudo.

```javascript
// src/middlewares/errorHandler.js

function errorHandler(err, req, res, next) {
  // Errores de validacion tipo Zod
  if (err.name === "ZodError" || err.issues) {
    return res.status(400).json({
      error: "Validation Error",
      message: "Los datos enviados no son validos.",
      details: err.issues || err.errors,
    });
  }

  // Errores de MySQL (ej. truncamiento, tipo de dato incorrecto)
  if (err.code && err.code.startsWith("ER_")) {
    return res.status(400).json({
      error: "Database Validation Error",
      message: "Uno o mas valores enviados no son validos para este campo.",
    });
  }

  // Cualquier otro error no controlado
  console.error(err);
  return res.status(500).json({
    error: "Internal Server Error",
    message: "Ocurrio un error inesperado en el servidor.",
  });
}

module.exports = errorHandler;
```

Y registrarlo al final de `server.js` o `app.js`, después de todas las rutas:

```javascript
const errorHandler = require("./middlewares/errorHandler");
// ... todas las rutas (app.use("/api/auth", ...), etc.) ...
app.use(errorHandler); // siempre al final
```

**Nota:** Esta corrección debe coordinarse con Carlos y Jennifer, ya que toca el archivo principal del servidor y podría afectar cómo otros endpoints manejan sus errores actualmente. Se sugiere probar de nuevo los Casos 4, 10 y 16 de `test/backend` después de aplicar este cambio, para confirmar que ahora respondan `400`.

## Estado

- [ ] Middleware implementado
- [ ] Registrado en `server.js`/`app.js`
- [ ] Re-probado Caso 4 (registro con campo faltante) → debe responder 400
- [ ] Re-probado Caso 10 (síntoma fuera de rango) → debe responder 400
- [ ] Re-probado Caso 16 (contraseña débil) → debe responder 400
- [ ] Confirmado con Carlos/Jennifer antes de merge a develop