# Rama: test/backend

## Propósito
Verificar que la API REST del Backend funcione correctamente por sí sola: endpoints, autenticación y conexión con MongoDB.

## Responsable
Citlalli Pérez Dionicio (Control de Calidad e Integración)

## Qué se prueba aquí
- Que cada endpoint (registro de síntomas, hábitos, login, chatbot) responda con el código de estado correcto.
- Que los datos se guarden y se lean correctamente desde MongoDB.
- Que la validación de datos rechace información incompleta o mal formada.
- Que el control de sesiones funcione (usuarios autenticados vs. no autenticados).

## Cómo probar
1. Levantar solo el servicio de Backend (Node.js + Express) y la base de datos.
2. Ejecutar las pruebas de esta rama contra cada endpoint.
3. Registrar en `reports/` los endpoints que fallaron y por qué.
4. Si se detecta un bug, moverlo a `fix/api-errors` o `fix/authentication` según el caso.

## Antes de hacer merge a develop
- [ ] Todos los endpoints probados responden correctamente.
- [ ] No hay conflictos con los últimos cambios de `develop`.
- [ ] Los resultados de las pruebas quedaron documentados.
