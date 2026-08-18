const asyncHandler = require('../utils/asyncHandler');
const habitService = require('../services/habitService');

const getRange = asyncHandler(async (req, res) => {
  const userId = req.user.role === 'admin' && req.query.userId ? req.query.userId : req.user.id;
  const { fromDate, toDate } = req.query;
  const logs = await habitService.getRange(userId, fromDate, toDate);
  res.json({ success: true, data: logs });
});

const getByDate = asyncHandler(async (req, res) => {
  const userId = req.user.role === 'admin' && req.query.userId ? req.query.userId : req.user.id;
  const log = await habitService.getByDate(userId, req.params.date);
  res.json({ success: true, data: log });
});

const upsert = asyncHandler(async (req, res) => {
  const userId = req.body.userId && req.user.role === 'admin' ? req.body.userId : req.user.id;
  const { logDate, ...habitFields } = req.body;
  const result = await habitService.upsert(userId, req.user.id, logDate, habitFields);
  res.json({ success: true, message: 'Hábitos actualizados', data: result });
});

const increment = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { logDate, habit, amount } = req.body;
  const result = await habitService.increment(userId, req.user.id, logDate, habit, amount || 1);
  res.json({ success: true, message: 'Hábito incrementado', data: result });
});

const remove = asyncHandler(async (req, res) => {
  await habitService.remove(req.user.id, req.user.id, req.params.date);
  res.json({ success: true, message: 'Registro de hábitos eliminado' });
});

module.exports = { getRange, getByDate, upsert, increment, remove };
