const ApiError = require('../utils/ApiError');
const notificationRepository = require('../repositories/notificationRepository');

async function list({ userId, isRead, kind, page = 1, pageSize = 20 } = {}) {
  const limit = Math.min(parseInt(pageSize, 10) || 20, 100);
  const offset = (Math.max(parseInt(page, 10) || 1, 1) - 1) * limit;
  const { rows, total } = await notificationRepository.findAll({ userId, isRead, kind, limit, offset });
  return {
    items: rows,
    pagination: { page: Number(page), pageSize: limit, total, totalPages: Math.ceil(total / limit) },
  };
}

async function create(data) {
  return notificationRepository.create(data);
}

async function markRead(id) {
  const existing = await notificationRepository.findById(id);
  if (!existing) throw ApiError.notFound('Notificación no encontrada');
  return notificationRepository.markRead(id);
}

async function remove(id) {
  const existing = await notificationRepository.findById(id);
  if (!existing) throw ApiError.notFound('Notificación no encontrada');
  await notificationRepository.remove(id);
}

async function countUnread(userId) {
  return notificationRepository.countUnread(userId);
}

module.exports = { list, create, markRead, remove, countUnread };
