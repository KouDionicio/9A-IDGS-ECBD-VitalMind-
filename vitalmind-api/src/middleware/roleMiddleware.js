const ApiError = require('../utils/ApiError');

/**
 * Restringe el acceso a una ruta según el rol del usuario autenticado.
 * Uso: router.get('/admin-only', authenticate, authorize('admin'), handler)
 * Los roles válidos según la tabla `users` son: admin, patient, caregiver.
 */
function authorize(...allowedRoles) {
  return (req, res, next) => {
    if (!req.user) {
      return next(ApiError.unauthorized('Debes autenticarte primero'));
    }
    if (!allowedRoles.includes(req.user.role)) {
      return next(
        ApiError.forbidden(
          'Esta acción requiere iniciar sesión con una cuenta de administrador'
        )
      );
    }
    return next();
  };
}

module.exports = { authorize };
