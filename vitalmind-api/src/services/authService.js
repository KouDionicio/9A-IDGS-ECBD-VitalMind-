const bcrypt = require('bcrypt');
const crypto = require('crypto');
const ApiError = require('../utils/ApiError');
const userRepository = require('../repositories/userRepository');
const refreshTokenRepository = require('../repositories/refreshTokenRepository');
const auditLogRepository = require('../repositories/auditLogRepository');
const { signAccessToken, signRefreshToken, verifyRefreshToken } = require('../utils/jwt');

const SALT_ROUNDS = 10;

/** El refresh token se guarda en BD como un hash SHA-256, no en texto plano. */
function hashToken(token) {
  return crypto.createHash('sha256').update(token).digest('hex');
}

function buildTokenPayload(user) {
  return { sub: user.id, email: user.email, role: user.role };
}

function toPublicUser(user) {
  const { password_hash, ...publicUser } = user;
  return publicUser;
}

async function issueTokenPair(user) {
  const accessToken = signAccessToken(buildTokenPayload(user));
  const refreshToken = signRefreshToken(buildTokenPayload(user));

  const decoded = verifyRefreshToken(refreshToken);
  await refreshTokenRepository.store({
    userId: user.id,
    tokenHash: hashToken(refreshToken),
    expiresAt: new Date(decoded.exp * 1000),
  });

  return { accessToken, refreshToken };
}

async function register({ fullName, email, password, age, role }) {
  const exists = await userRepository.existsByEmail(email);
  if (exists) {
    throw ApiError.conflict('Ya existe una cuenta registrada con ese correo');
  }

  const passwordHash = await bcrypt.hash(password, SALT_ROUNDS);
  const user = await userRepository.create({
    fullName,
    email,
    passwordHash,
    age,
    role: role || 'patient',
  });

  await auditLogRepository.log({
    actorId: user.id,
    action: 'auth.register',
    entity: 'users',
    entityId: user.id,
    payload: { email: user.email, role: user.role },
  });

  const tokens = await issueTokenPair(user);
  return { user: toPublicUser(user), ...tokens };
}

async function login({ email, password }) {
  const user = await userRepository.findByEmail(email);
  if (!user) {
    throw ApiError.unauthorized('Correo o contraseña incorrectos');
  }

  const passwordMatches = await bcrypt.compare(password, user.password_hash);
  if (!passwordMatches) {
    throw ApiError.unauthorized('Correo o contraseña incorrectos');
  }

  await userRepository.updateLastActive(user.id, 'Hace unos segundos');
  await auditLogRepository.log({
    actorId: user.id,
    action: 'auth.login',
    entity: 'users',
    entityId: user.id,
    payload: { email: user.email },
  });

  const tokens = await issueTokenPair(user);
  return { user: toPublicUser(user), ...tokens };
}

async function refresh({ refreshToken }) {
  let decoded;
  try {
    decoded = verifyRefreshToken(refreshToken);
  } catch (err) {
    throw ApiError.unauthorized('Refresh token inválido o expirado');
  }

  const tokenHash = hashToken(refreshToken);
  const stored = await refreshTokenRepository.findValidByHash(tokenHash);
  if (!stored) {
    throw ApiError.unauthorized('Refresh token revocado o no reconocido');
  }

  const user = await userRepository.findById(decoded.sub);
  if (!user) {
    throw ApiError.unauthorized('El usuario asociado ya no existe');
  }

  // Rotación de refresh token: se invalida el anterior y se emite uno nuevo
  await refreshTokenRepository.deleteByHash(tokenHash);
  const tokens = await issueTokenPair(user);

  return { user: toPublicUser(user), ...tokens };
}

async function logout({ refreshToken }) {
  if (!refreshToken) return;
  const tokenHash = hashToken(refreshToken);
  await refreshTokenRepository.deleteByHash(tokenHash);
}

async function getMe(userId) {
  const user = await userRepository.findById(userId);
  if (!user) throw ApiError.notFound('Usuario no encontrado');
  return user;
}

module.exports = { register, login, refresh, logout, getMe };
