const asyncHandler = require('../utils/asyncHandler');
const symptomService = require('../services/symptomService');

const list = asyncHandler(async (req, res) => {
  const { page, pageSize, userId } = req.query;
  const scopedUserId = req.user.role === 'admin' ? userId : req.user.id;
  const result = await symptomService.list({ userId: scopedUserId, page, pageSize });
  res.json({ success: true, ...result });
});

const getById = asyncHandler(async (req, res) => {
  const log = await symptomService.getById(req.params.id);
  res.json({ success: true, data: log });
});

const create = asyncHandler(async (req, res) => {
  const payload = { ...req.body, userId: req.body.userId || req.user.id };
  const log = await symptomService.create(req.user.id, payload);
  res.status(201).json({ success: true, message: 'Registro de síntomas creado', data: log });
});

const update = asyncHandler(async (req, res) => {
  const updated = await symptomService.update(req.params.id, req.user.id, req.body);
  res.json({ success: true, message: 'Registro actualizado', data: updated });
});

const remove = asyncHandler(async (req, res) => {
  await symptomService.remove(req.params.id, req.user.id);
  res.json({ success: true, message: 'Registro eliminado' });
});

module.exports = { list, getById, create, update, remove };
