/**
 * Validaciones base para los endpoints de mecanismos.
 *
 * Los campos exactos de cada mecanismo deben mantenerse alineados
 * con el modelo ML/FastAPI correspondiente.
 */

function requireFields(data, fields) {
  const missing = fields.filter(
    (field) => data[field] === undefined || data[field] === null
  );

  return {
    valid: missing.length === 0,
    missing,
  };
}

function assertObject(data, name = "body") {
  if (!data || typeof data !== "object" || Array.isArray(data)) {
    const error = new Error(`${name} debe ser un objeto JSON`);
    error.statusCode = 400;
    throw error;
  }
}

module.exports = {
  requireFields,
  assertObject,
};
