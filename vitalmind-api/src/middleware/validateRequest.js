const { validationResult } = require('express-validator');
const ApiError = require('../utils/ApiError');

/**
 * Colocar después de las reglas de express-validator en cualquier ruta.
 * Ejemplo: router.post('/x', [body('email').isEmail()], validateRequest, controller)
 */
function validateRequest(req, res, next) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const details = errors.array().map((e) => ({
      field: e.path,
      message: e.msg,
    }));
    return next(ApiError.badRequest('Error de validación en los datos enviados', details));
  }
  return next();
}

module.exports = validateRequest;
