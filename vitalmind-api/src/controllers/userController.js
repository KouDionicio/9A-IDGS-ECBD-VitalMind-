const asyncHandler = require('../utils/asyncHandler');
const userService = require('../services/userService');

const list = asyncHandler(async (req, res) => {
  const { page, pageSize, role, status, search } = req.query;
  const result = await userService.list({ page, pageSize, role, status, search });
  res.json({ success: true, ...result });
});

const getById = asyncHandler(async (req, res) => {
  const user = await userService.getById(req.params.id);
  res.json({ success: true, data: user });
});

const updateProfile = asyncHandler(async (req, res) => {
  const targetId = req.params.id;
  // Un usuario normal solo puede editar su propio perfil; admin puede editar cualquiera
  if (req.user.role !== 'admin' && String(req.user.id) !== String(targetId)) {
    return res.status(403).json({ success: false, message: 'No puedes editar el perfil de otro usuario' });
  }
  const allowedFields = ['full_name', 'age', 'blood_type', 'phone', 'weight_kg', 'height_cm'];
  if (req.user.role === 'admin') allowedFields.push('status', 'role', 'color', 'email');

  const fields = {};
  for (const key of allowedFields) {
    if (req.body[key] !== undefined) fields[key] = req.body[key];
  }

  const updated = await userService.updateProfile(targetId, req.user.id, fields);
  res.json({ success: true, message: 'Perfil actualizado', data: updated });
});

const changePassword = asyncHandler(async (req, res) => {
  const { currentPassword, newPassword } = req.body;
  await userService.changePassword(req.user.id, { currentPassword, newPassword });
  res.json({ success: true, message: 'Contraseña actualizada correctamente' });
});

const remove = asyncHandler(async (req, res) => {
  await userService.remove(req.params.id, req.user.id);
  res.json({ success: true, message: 'Usuario eliminado' });
});

module.exports = { list, getById, updateProfile, changePassword, remove };
