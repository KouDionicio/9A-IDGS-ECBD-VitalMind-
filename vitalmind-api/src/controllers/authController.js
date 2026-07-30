const asyncHandler = require('../utils/asyncHandler');
const authService = require('../services/authService');

const register = asyncHandler(async (req, res) => {
  const { fullName, email, password, age, role } = req.body;
  const result = await authService.register({ fullName, email, password, age, role });
  res.status(201).json({ success: true, message: 'Usuario registrado correctamente', data: result });
});

const login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  const result = await authService.login({ email, password });
  res.status(200).json({ success: true, message: 'Inicio de sesión exitoso', data: result });
});

const refresh = asyncHandler(async (req, res) => {
  const { refreshToken } = req.body;
  const result = await authService.refresh({ refreshToken });
  res.status(200).json({ success: true, message: 'Token renovado', data: result });
});

const logout = asyncHandler(async (req, res) => {
  const { refreshToken } = req.body;
  await authService.logout({ refreshToken });
  res.status(200).json({ success: true, message: 'Sesión cerrada correctamente' });
});

const me = asyncHandler(async (req, res) => {
  const user = await authService.getMe(req.user.id);
  res.status(200).json({ success: true, data: user });
});

module.exports = { register, login, refresh, logout, me };
