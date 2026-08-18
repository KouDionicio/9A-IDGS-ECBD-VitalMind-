const asyncHandler = require('../utils/asyncHandler');
const medicalHistoryService = require('../services/medicalHistoryService');

const list = asyncHandler(async (req, res) => {
  const { category, page, pageSize, userId } = req.query;
  const scopedUserId = req.user.role === 'admin' ? userId : req.user.id;
  const result = await medicalHistoryService.list({ userId: scopedUserId, category, page, pageSize });
  res.json({ success: true, ...result });
});

const getById = asyncHandler(async (req, res) => {
  const item = await medicalHistoryService.getById(req.params.id);
  res.json({ success: true, data: item });
});

const create = asyncHandler(async (req, res) => {
  const payload = { ...req.body, userId: req.body.userId || req.user.id };
  const item = await medicalHistoryService.create(req.user.id, payload);
  res.status(201).json({ success: true, message: 'Registro creado', data: item });
});

const update = asyncHandler(async (req, res) => {
  const updated = await medicalHistoryService.update(req.params.id, req.user.id, req.body);
  res.json({ success: true, message: 'Registro actualizado', data: updated });
});

const remove = asyncHandler(async (req, res) => {
  await medicalHistoryService.remove(req.params.id, req.user.id);
  res.json({ success: true, message: 'Registro eliminado' });
});

module.exports = { list, getById, create, update, remove };
