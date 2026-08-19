const asyncHandler = require('../utils/asyncHandler');
const medicationService = require('../services/medicationService');

const list = asyncHandler(async (req, res) => {
  const { userId, type, taken, page, pageSize } = req.query;
  const scopedUserId = req.user.role === 'admin' ? userId : req.user.id;
  const result = await medicationService.list({
    userId: scopedUserId,
    type,
    taken: taken !== undefined ? taken === 'true' : undefined,
    page,
    pageSize,
  });
  res.json({ success: true, ...result });
});

const getById = asyncHandler(async (req, res) => {
  const med = await medicationService.getById(req.params.id);
  res.json({ success: true, data: med });
});

const create = asyncHandler(async (req, res) => {
  const payload = {
    ...req.body,
    timeLabel: req.body.timeLabel || req.body.time_label || req.body.time,
    userId: req.body.userId || req.user.id,
  };
  const med = await medicationService.create(req.user.id, payload);
  res.status(201).json({ success: true, message: 'Medicamento creado', data: med });
});

const update = asyncHandler(async (req, res) => {
  const updated = await medicationService.update(req.params.id, req.user.id, req.body);
  res.json({ success: true, message: 'Medicamento actualizado', data: updated });
});

const remove = asyncHandler(async (req, res) => {
  await medicationService.remove(req.params.id, req.user.id);
  res.json({ success: true, message: 'Medicamento eliminado' });
});

const markTaken = asyncHandler(async (req, res) => {
  const taken = req.body.taken !== undefined ? req.body.taken : true;
  const result = await medicationService.markTaken(req.params.id, req.user.id, req.user.id, taken);
  res.json({ success: true, message: taken ? 'Marcado como tomado' : 'Desmarcado', data: result });
});

const getLogs = asyncHandler(async (req, res) => {
  const { page, pageSize } = req.query;
  const logs = await medicationService.getLogs({
    medicationId: req.params.id,
    userId: req.user.role === 'admin' ? req.query.userId : req.user.id,
    page,
    pageSize,
  });
  res.json({ success: true, data: logs });
});

module.exports = { list, getById, create, update, remove, markTaken, getLogs };
