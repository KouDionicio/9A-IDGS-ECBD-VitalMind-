# Routers

## Descripción

La carpeta `routers` contiene las rutas de la API. Estas rutas reciben las solicitudes HTTP del cliente y las dirigen hacia los controladores correspondientes.

## Funciones principales

* Definir los endpoints de la API.
* Organizar las rutas por módulo.
* Asociar cada ruta con su controlador.
* Especificar los métodos HTTP utilizados.
* Facilitar la comunicación entre el cliente y el backend.

## Métodos HTTP utilizados

* `GET`: Obtener información.
* `POST`: Crear nuevos registros.
* `PUT`: Actualizar registros.
* `DELETE`: Eliminar registros.

## Estructura

```text
routers/
├── usuario.routes.js
├── persona.routes.js
├── alerta.routes.js
└── ...
```

## Ejemplo

```javascript
const express = require("express");
const router = express.Router();

const {
  obtenerUsuarios,
  crearUsuario
} = require("../controllers/usuario.controller");

router.get("/", obtenerUsuarios);
router.post("/", crearUsuario);

module.exports = router;
```

## Integración

Las rutas se registran en el archivo principal del servidor:

```javascript
const usuarioRoutes = require("./routers/usuario.routes");

app.use("/api/usuarios", usuarioRoutes);
```

De esta manera, los endpoints quedan disponibles mediante:

```text
GET  /api/usuarios
POST /api/usuarios
```