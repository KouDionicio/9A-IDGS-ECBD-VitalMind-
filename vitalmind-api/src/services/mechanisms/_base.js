function clamp(value, min = 0, max = 1) {
  return Math.min(max, Math.max(min, Number(value) || 0));
}

function num(value, fallback = 0) {
  const n = Number(value);
  return Number.isFinite(n) ? n : fallback;
}

function arr(value) {
  return Array.isArray(value) ? value : [];
}

function text(value) {
  return String(value ?? '').trim();
}

function requireArray(data, field) {
  if (!Array.isArray(data?.[field])) {
    const error = new Error(`El campo "${field}" debe ser un arreglo.`);
    error.statusCode = 400;
    throw error;
  }
}

function requireNumber(data, field, { min = -Infinity, max = Infinity } = {}) {
  const n = Number(data?.[field]);
  if (!Number.isFinite(n) || n < min || n > max) {
    const error = new Error(`El campo "${field}" debe ser numérico y estar entre ${min} y ${max}.`);
    error.statusCode = 400;
    throw error;
  }
  return n;
}

module.exports = { clamp, num, arr, text, requireArray, requireNumber };
