const asyncHandler = require('../utils/asyncHandler');
const mlIntegrationService = require('../services/mlIntegrationService');

const analyze = asyncHandler(async (req, res) => {
  // Un usuario normal solo puede analizarse a sí mismo; admin/caregiver pueden especificar userId
  const targetUserId = req.user.role === 'admin' || req.user.role === 'caregiver'
    ? (req.body.userId || req.user.id)
    : req.user.id;

  const result = await mlIntegrationService.analyze(targetUserId, req.user.id, {
    analysisDate: req.body.analysisDate,
  });

  res.json({ success: true, data: result });
});

const health = asyncHandler(async (req, res) => {
  const status = await mlIntegrationService.health();
  res.json({ success: true, data: status });
});

const modelsInfo = asyncHandler(async (req, res) => {
  const info = await mlIntegrationService.modelsInfo();
  res.json({ success: true, data: info });
});
async function chat(req, res, next) {
  try {
    const authenticatedUserId =
      req.user.id;

    const requestedUserId =
      req.body.userId;

    const userId =
      req.user.role === 'admin' ||
      req.user.role === 'caregiver'
        ? requestedUserId ||
          authenticatedUserId
        : authenticatedUserId;

    const result =
      await mlIntegrationService.chat({
        userId,
        analysisDate:
          req.body.analysisDate,
        message:
          req.body.message,
        context:
          req.body.context,
      });

    return res.status(200).json({
      success: true,
      data: result,
    });
  } catch (error) {
    next(error);
  }
}


async function chatAnalyze(req, res, next) {
  try {
    const authenticatedUserId =
      req.user.id;

    const requestedUserId =
      req.body.userId;

    const userId =
      req.user.role === 'admin' ||
      req.user.role === 'caregiver'
        ? requestedUserId ||
          authenticatedUserId
        : authenticatedUserId;

    const result =
      await mlIntegrationService.chatAnalyze({
        userId,
        analysisDate:
          req.body.analysisDate,
        message:
          req.body.message,
      });

    return res.status(200).json({
      success: true,
      data: result,
    });
  } catch (error) {
    next(error);
  }
}
module.exports = {chat, chatAnalyze, analyze, health, modelsInfo };
