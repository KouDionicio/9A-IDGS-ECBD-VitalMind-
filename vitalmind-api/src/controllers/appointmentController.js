const asyncHandler = require('../utils/asyncHandler');
const appointmentService = require('../services/appointmentService');

const list = asyncHandler(async (req, res) => {
  const { status, specialty, fromDate, toDate, page, pageSize, userId } = req.query;
  const scopedUserId = req.user.role === 'admin' ? userId : req.user.id;
  const result = await appointmentService.list({
    userId: scopedUserId, status, specialty, fromDate, toDate, page, pageSize,
  });
  res.json({ success: true, ...result });
});

const getById = asyncHandler(async (req, res) => {
  const appt = await appointmentService.getById(req.params.id);
  res.json({ success: true, data: appt });
});

const create = asyncHandler(async (req, res) => {
  const payload = { ...req.body, userId: req.body.userId || req.user.id };
  const appt = await appointmentService.create(req.user.id, payload);
  res.status(201).json({ success: true, message: 'Cita creada', data: appt });
});

const update = asyncHandler(async (req, res) => {
  const updated = await appointmentService.update(req.params.id, req.user.id, req.body);
  res.json({ success: true, message: 'Cita actualizada', data: updated });
});

const remove = asyncHandler(async (req, res) => {
  await appointmentService.remove(req.params.id, req.user.id);
  res.json({ success: true, message: 'Cita eliminada' });
});

module.exports = { list, getById, create, update, remove };
