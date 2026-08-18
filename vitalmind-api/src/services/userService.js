const bcrypt = require('bcrypt');
const ApiError = require('../utils/ApiError');
const userRepository = require('../repositories/userRepository');
const auditLogRepository = require('../repositories/auditLogRepository');

const SALT_ROUNDS = 10;

async function list({ page = 1, pageSize = 20, role, status, search } = {}) {
  const limit = Math.min(parseInt(pageSize, 10) || 20, 100);
  const offset = (Math.max(parseInt(page, 10) || 1, 1) - 1) * limit;
  const { rows, total } = await userRepository.findAll({ limit, offset, role, status, search });
  return {
    items: rows,
    pagination: { page: Number(page), pageSize: limit, total, totalPages: Math.ceil(total / limit) },
  };
}

async function getById(id) {
  const user = await userRepository.findById(id);
  if (!user) throw ApiError.notFound('Usuario no encontrado');
  return user;
}

async function updateProfile(id, actorId, fields) {
  const existing = await userRepository.findById(id);
  if (!existing) throw ApiError.notFound('Usuario no encontrado');

  const updated = await userRepository.update(id, fields);
  await auditLogRepository.log({
    actorId,
    action: 'users.update',
    entity: 'users',
    entityId: id,
    payload: fields,
  });
  return updated;
}

async function changePassword(id, { currentPassword, newPassword }) {
  const full = await userRepository.findByEmail((await userRepository.findById(id)).email);
  const matches = await bcrypt.compare(currentPassword, full.password_hash);
  if (!matches) throw ApiError.unauthorized('La contraseña actual no es correcta');

  const passwordHash = await bcrypt.hash(newPassword, SALT_ROUNDS);
  await userRepository.updatePassword(id, passwordHash);
  await auditLogRepository.log({
    actorId: id,
    action: 'users.changePassword',
    entity: 'users',
    entityId: id,
    payload: {},
  });
}

async function remove(id, actorId) {
  const existing = await userRepository.findById(id);
  if (!existing) throw ApiError.notFound('Usuario no encontrado');
  await userRepository.remove(id);
  await auditLogRepository.log({
    actorId,
    action: 'users.delete',
    entity: 'users',
    entityId: id,
    payload: { email: existing.email },
  });
}

module.exports = { list, getById, updateProfile, changePassword, remove };
