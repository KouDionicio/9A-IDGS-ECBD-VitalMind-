# Rama: fix/api-errors

## Propósito
Corregir los errores de validación y manejo de errores detectados en la API REST del Backend, específicamente los casos donde se devuelve código 500 en lugar del código correspondiente (400, 404, etc.) ante datos incompletos o mal formados.

## Responsable
Citlalli Pérez Dionicio (Control de Calidad e Integración)

## Qué se corrige aquí
- Endpoints que devuelven error 500 al recibir información incompleta o mal formada, cuando deberían devolver 400.
- Falta de validación de datos de entrada (registro de usuario, síntomas, hábitos, medicamentos) antes de procesarlos.
- Manejo inadecuado de excepciones que expone errores internos del servidor en vez de mensajes controlados.
- Casos reportados desde `test/backend`, en particular el bug de "validación con 500" y "medicamentos con 500".

## Cómo corregir
1. Levantar solo el servicio de Backend (Node.js + Express) y la base de datos MySQL.
2. Reproducir el error reportado en `reports/test-backend/RESULT.md` para confirmar el comportamiento incorrecto.
3. Agregar o corregir las validaciones necesarias (middleware de validación, manejo de excepciones con try/catch, respuestas de error estandarizadas).
4. Verificar que el endpoint corregido devuelva el código de estado correcto (400 para datos inválidos, no 500).
5. Documentar la corrección y los endpoints afectados en `reports/fix-api-errors/RESULT.md`.

## Antes de hacer merge a develop
- [ ] Todos los endpoints corregidos devuelven el código de estado correcto ante datos inválidos.
- [ ] Se volvieron a ejecutar las pruebas de `test/backend` sobre los endpoints corregidos.
- [ ] No hay conflictos con los últimos cambios de `develop`.
- [ ] Los bugs originales (validación con 500, medicamentos con 500) quedaron cerrados y documentados.