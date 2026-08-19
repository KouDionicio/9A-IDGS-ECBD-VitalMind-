const asyncHandler = require("../utils/asyncHandler");

const mechanisms = require("../services/mechanisms/mechanisms.catalog");

const createHandler = (service) =>
  asyncHandler(async (req, res) => {
    const result = await service.execute(req.body);

    res.json({
      success: true,
      mechanism: result.mechanism,
      type: result.type,
      result: result.result,
    });
  });

// Supervisados
const symptomPriorityService = require("../services/mechanisms/supervised/symptomPriority.service");
const symptomRecurrenceService = require("../services/mechanisms/supervised/symptomRecurrence.service");
const habitAdherenceService = require("../services/mechanisms/supervised/habitAdherence.service");
const emotionalStateService = require("../services/mechanisms/supervised/emotionalState.service");
const habitRecommendationService = require("../services/mechanisms/supervised/habitRecommendation.service");
const preventiveAlertService = require("../services/mechanisms/supervised/preventiveAlert.service");
const appAbandonmentService = require("../services/mechanisms/supervised/appAbandonment.service");
const sleepQualityService = require("../services/mechanisms/supervised/sleepQuality.service");
const sedentaryRiskService = require("../services/mechanisms/supervised/sedentaryRisk.service");
const chatbotSensitiveService = require("../services/mechanisms/supervised/chatbotSensitive.service");

// No supervisados
const healthHabitsSegmentationService = require("../services/mechanisms/unsupervised/healthHabitsSegmentation.service");
const symptomPatternsService = require("../services/mechanisms/unsupervised/symptomPatterns.service");
const emotionalProfilesService = require("../services/mechanisms/unsupervised/emotionalProfiles.service");
const healthAnomaliesService = require("../services/mechanisms/unsupervised/healthAnomalies.service");
const habitSymptomAssociationService = require("../services/mechanisms/unsupervised/habitSymptomAssociation.service");
const appBehaviorSegmentationService = require("../services/mechanisms/unsupervised/appBehaviorSegmentation.service");
const chatbotTopicsService = require("../services/mechanisms/unsupervised/chatbotTopics.service");
const wellnessMapService = require("../services/mechanisms/unsupervised/wellnessMap.service");
const wellnessRoutinesService = require("../services/mechanisms/unsupervised/wellnessRoutines.service");
const preventiveProfilesService = require("../services/mechanisms/unsupervised/preventiveProfiles.service");

const catalog = asyncHandler(async (req, res) => {
  res.json({
    success: true,
    total: mechanisms.length,
    data: mechanisms,
  });
});

module.exports = {
  catalog,

  symptomPriority: createHandler(symptomPriorityService),
  symptomRecurrence: createHandler(symptomRecurrenceService),
  habitAdherence: createHandler(habitAdherenceService),
  emotionalState: createHandler(emotionalStateService),
  habitRecommendation: createHandler(habitRecommendationService),
  preventiveAlert: createHandler(preventiveAlertService),
  appAbandonment: createHandler(appAbandonmentService),
  sleepQuality: createHandler(sleepQualityService),
  sedentaryRisk: createHandler(sedentaryRiskService),
  chatbotSensitive: createHandler(chatbotSensitiveService),

  healthHabitsSegmentation: createHandler(healthHabitsSegmentationService),
  symptomPatterns: createHandler(symptomPatternsService),
  emotionalProfiles: createHandler(emotionalProfilesService),
  healthAnomalies: createHandler(healthAnomaliesService),
  habitSymptomAssociation: createHandler(habitSymptomAssociationService),
  appBehaviorSegmentation: createHandler(appBehaviorSegmentationService),
  chatbotTopics: createHandler(chatbotTopicsService),
  wellnessMap: createHandler(wellnessMapService),
  wellnessRoutines: createHandler(wellnessRoutinesService),
  preventiveProfiles: createHandler(preventiveProfilesService),
};
