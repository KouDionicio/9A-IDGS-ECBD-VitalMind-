const asyncHandler = require('../utils/asyncHandler');
const notificationService = require('../services/notificationService');

const list = asyncHandler(async (req, res) => {
  const { isRead, kind, page, pageSize } = req.query;
  const result = await notificationService.list({
    userId: req.user.id,
    isRead: isRead !== undefined ? isRead === 'true' : undefined,
    kind,
    page,
    pageSize,
  });
  res.json({ success: true, ...result });
});

const create = asyncHandler(async (req, res) => {
  const notification = await notificationService.create(req.body);
  res.status(201).json({ success: true, message: 'Notificación creada', data: notification });
});

const markRead = asyncHandler(async (req, res) => {
  const notification = await notificationService.markRead(req.params.id);
  res.json({ success: true, message: 'Notificación marcada como leída', data: notification });
});

const remove = asyncHandler(async (req, res) => {
  await notificationService.remove(req.params.id);
  res.json({ success: true, message: 'Notificación eliminada' });
});

const countUnread = asyncHandler(async (req, res) => {
  const total = await notificationService.countUnread(req.user.id);
  res.json({ success: true, data: { unread: total } });
});

module.exports = { list, create, markRead, remove, countUnread };
