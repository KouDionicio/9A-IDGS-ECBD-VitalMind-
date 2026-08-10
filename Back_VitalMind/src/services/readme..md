# Services

## Descripción

La carpeta `services` contiene la lógica de negocio de la aplicación. Su función es procesar información y realizar operaciones necesarias antes de enviar una respuesta al controlador.

## Funciones principales

* Ejecutar la lógica de negocio.
* Realizar operaciones con la base de datos.
* Procesar y validar información.
* Reutilizar funciones entre diferentes controladores.
* Mantener los controladores organizados y simples.

## Estructura

```text
services/
├── usuario.service.js
├── persona.service.js
├── alerta.service.js
└── ...
```

## Ejemplo

```javascript
const Usuario = require("../models/usuario.model");

const obtenerUsuarios = async () => {
  return await Usuario.findAll();
};

const crearUsuario = async (datos) => {
  return await Usuario.create(datos);
};

module.exports = {
  obtenerUsuarios,
  crearUsuario
};
```

## Integración

Los servicios son utilizados principalmente por los controladores:

```text
Router → Controller → Service → Base de datos
```

Esta estructura permite separar responsabilidades y facilita el mantenimiento y escalabilidad del backend.
