# Rama: test/integration

## Propósito
Verificar que el Frontend, el Backend y el microservicio de IA (ML) se comuniquen correctamente entre sí, es decir, que todo el sistema funcione como un solo flujo, no solo cada parte por separado.

## Responsable
Citlalli Pérez Dionicio (Control de Calidad e Integración)

## Qué se prueba aquí
- Que el Dashboard reciba correctamente las predicciones enviadas por el microservicio de IA.
- Que el Chatbot pueda enviar y recibir mensajes a través del Backend sin errores.
- Que el flujo completo (registro de síntomas → Backend → modelo de IA → resultado en Dashboard) funcione de principio a fin.
- Que el semáforo de riesgo se actualice correctamente según la respuesta del modelo.

## Cómo probar
1. Levantar los tres servicios: frontend, backend y ml-service.
2. Ejecutar las pruebas de integración de esta rama.
3. Documentar en `reports/` cualquier fallo encontrado, indicando en qué parte del flujo ocurrió.
4. Si se detecta un bug, crear un Pull Request desde la rama `fix/` correspondiente hacia `develop`.

## Antes de hacer merge a develop
- [ ] Las pruebas de integración pasan sin errores.
- [ ] No hay conflictos con los últimos cambios de `develop`.
- [ ] Los resultados de las pruebas quedaron documentados.
