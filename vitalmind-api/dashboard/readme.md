# VitalMind Dashboard

## Descripción

El **Dashboard de VitalMind** es una interfaz web diseñada para visualizar de forma gráfica la información obtenida del sistema VitalMind API.

Su objetivo es facilitar la consulta y análisis de los datos mediante gráficos, indicadores y elementos visuales.

## Tecnologías utilizadas

* HTML5
* JavaScript
* Chart.js

## Estructura

```text
dashboard/
│
├── vendor/
│   ├── chart.umd.js
│   └── readme.md
│
└── index.html
```

## Archivos principales

### `index.html`

Es el archivo principal del dashboard. Contiene la estructura de la interfaz y los elementos necesarios para mostrar la información y las gráficas.

### `vendor/chart.umd.js`

Contiene la biblioteca **Chart.js**, utilizada para generar gráficas y representar visualmente los datos.

## Funcionalidades

* Visualización gráfica de información.
* Representación de datos mediante Chart.js.
* Interfaz web sencilla para consultar información.
* Integración con los datos proporcionados por VitalMind API.

## Ejecución

Para visualizar el dashboard, abre el archivo:

```text
index.html
```

También se recomienda ejecutarlo mediante un servidor local para un mejor funcionamiento.

Por ejemplo, utilizando **Live Server** en Visual Studio Code:

1. Abrir la carpeta `dashboard`.
2. Seleccionar el archivo `index.html`.
3. Hacer clic derecho.
4. Seleccionar **Open with Live Server**.

## Dependencia principal

El dashboard utiliza **Chart.js** para la creación de gráficas.

La biblioteca se encuentra almacenada localmente en:

```text
vendor/chart.umd.js
```

Esto permite que el dashboard pueda utilizar las funcionalidades de Chart.js sin depender directamente de una conexión externa.

## Objetivo

El objetivo del Dashboard de VitalMind es presentar la información del sistema de una manera más clara y visual, facilitando el análisis y la interpretación de los datos.

## Proyecto

Este dashboard forma parte del proyecto **VitalMind**, junto con la API y la base de datos del sistema.
