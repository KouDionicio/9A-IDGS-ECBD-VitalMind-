const ApiError = require('../utils/ApiError');
const { verifyAccessToken } = require('../utils/jwt');

/**
 * Requiere un header "Authorization: Bearer <token>" válido.
 * Adjunta req.user = { id, role, email } al request.
 */
function authenticate(req, res, next) {
  const header = req.headers.authorization;

  if (!header || !header.startsWith('Bearer ')) {
    return next(ApiError.unauthorized('Token de acceso no proporcionado'));
  }

  const token = header.split(' ')[1];

  try {
    const payload = verifyAccessToken(token);
    req.user = {
      id: payload.sub,
      email: payload.email,
      role: payload.role,
    };
    return next();
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      return next(ApiError.unauthorized('El token de acceso ha expirado'));
    }
    return next(ApiError.unauthorized('Token de acceso inválido'));
  }
}

module.exports = { authenticate };
