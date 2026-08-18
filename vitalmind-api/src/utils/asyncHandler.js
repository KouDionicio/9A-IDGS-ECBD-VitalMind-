/**
 * Envuelve un controlador async y reenvía cualquier error a next(),
 * para que lo capture el middleware centralizado de errores.
 */
const asyncHandler = (fn) => (req, res, next) => {
  Promise.resolve(fn(req, res, next)).catch(next);
};

module.exports = asyncHandler;
