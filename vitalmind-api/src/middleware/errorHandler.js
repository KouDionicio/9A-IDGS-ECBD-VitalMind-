const ApiError = require('../utils/ApiError');

/**
 * Middleware final de la cadena. Normaliza cualquier error (operacional o no)
 * a una respuesta JSON consistente. Nunca debe filtrar detalles internos
 * (stack, queries SQL, etc.) cuando NODE_ENV=production.
 */
// eslint-disable-next-line no-unused-vars
function errorHandler(err, req, res, next) {
  const isApiError = err instanceof ApiError;
  const statusCode = isApiError ? err.statusCode : 500;
  const isProd = process.env.NODE_ENV === 'production';

  if (!isApiError) {
    // Error no controlado: lo logueamos completo en el servidor
    console.error('[UNHANDLED ERROR]', err);
  }

  // Errores típicos de MySQL2 mapeados a mensajes claros
  let message = err.message || 'Error interno del servidor';
  if (err.code === 'ER_DUP_ENTRY') {
    message = 'Ya existe un registro con esos datos (violación de unicidad)';
  } else if (err.code === 'ER_NO_REFERENCED_ROW_2') {
    message = 'La referencia a otro recurso no existe (llave foránea inválida)';
  }

  res.status(statusCode).json({
    success: false,
    message: isProd && !isApiError ? 'Error interno del servidor' : message,
    details: isApiError ? err.details : undefined,
    stack: !isProd && !isApiError ? err.stack : undefined,
  });
}

module.exports = errorHandler;
