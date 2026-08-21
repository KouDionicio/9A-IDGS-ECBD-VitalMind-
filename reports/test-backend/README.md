# Rama: test/backend

## Propósito
Verificar que la API REST del Backend funcione correctamente por sí sola: endpoints, autenticación y conexión con MySQL.

## Responsable
Citlalli Pérez Dionicio (Control de Calidad e Integración)

## Qué se prueba aquí
- Que cada endpoint (registro de usuario, síntomas, hábitos, login, medicamentos) responda con el código de estado correcto.
- Que los datos se guarden y se lean correctamente desde MySQL.
- Que la validación de datos rechace información incompleta o mal formada, con el código de estado adecuado (400, no 500).
- Que el control de sesiones funcione (usuarios autenticados vs. no autenticados, tokens válidos vs. inválidos).

## Cómo probar
1. Levantar solo el servicio de Backend (Node.js + Express) y la base de datos MySQL.
2. Ejecutar las pruebas de esta rama contra cada endpoint (usando PowerShell/Invoke-RestMethod, Postman o curl).
3. Registrar en `reports/test-backend/RESULT.md` los endpoints que fallaron y por qué.
4. Si se detecta un bug, documentarlo y moverlo a `fix/api-errors` o `fix/authentication` según el caso.

## Antes de hacer merge a develop
- [ ] Todos los endpoints probados responden correctamente.
- [ ] No hay conflictos con los últimos cambios de `develop`.
- [ ] Los resultados de las pruebas quedaron documentados.
- [ ] Los bugs encontrados (validación con 500, medicamentos con 500) están reportados en sus ramas `fix/` correspondientes.