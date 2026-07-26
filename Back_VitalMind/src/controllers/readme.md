# Controllers

La carpeta `controllers` contiene los controladores del backend de **VitalMind**. Cada controlador se encarga de procesar las solicitudes HTTP, ejecutar la lógica correspondiente y enviar las respuestas al cliente.

## 📁 Controladores

Actualmente, la carpeta contiene los siguientes controladores:

* `admin.controller.js` — Gestión de funciones administrativas.
* `appointments.controller.js` — Gestión de citas médicas.
* `auth.controller.js` — Autenticación y acceso de usuarios.
* `chat.controller.js` — Gestión del chat de la aplicación.
* `dashboard.controller.js` — Obtención de información para el dashboard.
* `emotionalLog.controller.js` — Registro y consulta de información emocional.
* `habits.controller.js` — Gestión de hábitos de los usuarios.
* `medicalHistory.controller.js` — Gestión del historial médico.
* `medications.controller.js` — Gestión de medicamentos.
* `metrics.controller.js` — Obtención y manejo de métricas.
* `notifications.controller.js` — Gestión de notificaciones.
* `reports.controller.js` — Generación y consulta de reportes.
* `symptomLog.controller.js` — Registro y consulta de síntomas.
* `users.controller.js` — Gestión de usuarios.

## 🔄 Funcionamiento

Los controladores reciben las solicitudes provenientes de las rutas y se encargan de ejecutar las operaciones correspondientes.

```text
Cliente
   ↓
Routes
   ↓
Controllers
   ↓
Services / Base de datos
   ↓
Respuesta HTTP
```

## 🎯 Objetivo

La separación de los controladores permite mantener el código organizado y facilita el mantenimiento, reutilización y escalabilidad del backend de VitalMind.

## 🛠️ Tecnologías

* Node.js
* Express.js
* JavaScript
* MySQL
* API REST
