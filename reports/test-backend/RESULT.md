# Resultados de Pruebas de Backend

**Entorno de prueba:** VitalMind (Docker Compose)

**Responsable:** Citlalli Pérez Dionicio

**Servicios probados:** Backend + MySQL

---

## Caso 1: Estado del entorno

**Resultado:** OK

**Detalle:** Se verificó que los contenedores necesarios para la ejecución del sistema se encontraran activos.

### Evidencia

![Contenedores](./evidences/01-containers.png)

---

## Caso 2: Conexión Backend - MySQL

**Resultado:** OK

**Detalle:** Se verificó que el Backend iniciara correctamente y estableciera conexión con MySQL.

### Evidencia

![Backend conectado a MySQL](./evidence/02-backend-mysql.png)

---

## Caso 3: Estructura de usuarios

**Resultado:** OK

**Detalle:** Se verificó la estructura de la tabla `users` y la existencia del campo `gender`.

### Evidencia

![Estructura users](./evidences/03-users-schema.png)

---

## Caso 4: Validación de datos

**Resultado:** OK

**Detalle:** Se envió una solicitud con una estructura incorrecta para comprobar que el Backend detectara campos requeridos.

### Evidencia

![Error de validación](./evidences/04-validation-error.png)

---

## Caso 5: Registro de usuario

**Resultado:** OK

**Detalle:** Se realizó correctamente el registro de un usuario mediante `POST /api/auth/register`.

### Evidencia

![Registro](./evidences/05-register-success.png)

---

## Caso 6: Persistencia de datos

**Resultado:** OK

**Detalle:** Se verificó directamente en MySQL que el usuario registrado por medio del Backend fuera almacenado correctamente.

### Evidencia

![Persistencia](./evidence/06-user-persisted.png)

---


## Caso 7: Login correcto

**Resultado:** OK

**Detalle:** Se verificó el inicio de sesión utilizando credenciales válidas y se confirmó la generación del token JWT.

### Evidencia

![Login correcto](./evidence/08-login-success.png)

---

## Caso 9: Login con credenciales inválidas

**Resultado:** OK

**Detalle:** Se verificó que el Backend rechazara credenciales incorrectas mediante una respuesta de error controlada.

### Evidencia

![Login inválido](./evidence/09-login-invalid.png)

---

## Caso 10: Protección de endpoints

**Resultado:** OK

**Detalle:** Se verificó que un endpoint protegido rechazara solicitudes sin autenticación válida.

### Evidencia

![Endpoint protegido](./evidences/11-recommendations-unauthorized.png)

---

## Resumen general

| Caso | Resultado |
|---|---|
| Estado del entorno | OK |
| Conexión Backend - MySQL | OK |
| Estructura de usuarios | OK |
| Validación de datos | OK |
| Registro de usuario | OK |
| Persistencia en MySQL | OK |
| Recommendations | OK |
| Login correcto | OK |
| Login inválido | OK |
| Protección de endpoints | OK |

### Resultado final

Las pruebas realizadas sobre el Backend de VitalMind fueron satisfactorias.

Se verificó el funcionamiento del servicio, su comunicación con MySQL, la validación de datos, el registro y autenticación de usuarios, la persistencia de información y el comportamiento de los endpoints evaluados.

Las pruebas negativas también permitieron comprobar que el Backend responde de manera controlada ante solicitudes inválidas y credenciales incorrectas.

### Evidencia

![Resultados Finales](./evidences/13-backend-final-status.png)