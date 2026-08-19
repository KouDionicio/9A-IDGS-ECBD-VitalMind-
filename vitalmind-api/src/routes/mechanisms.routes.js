const { Router } = require("express");

const controller = require("../controllers/mechanisms.controller");
const { authenticate } = require("../middleware/authMiddleware");

const router = Router();

router.use(authenticate);

// Catálogo
router.get("/", controller.catalog);

// ==============================
// SUPERVISADOS
// ==============================
router.post("/supervised/symptom-priority", controller.symptomPriority);
router.post("/supervised/symptom-recurrence", controller.symptomRecurrence);
router.post("/supervised/habit-adherence", controller.habitAdherence);
router.post("/supervised/emotional-state", controller.emotionalState);
router.post("/supervised/habit-recommendation", controller.habitRecommendation);
router.post("/supervised/preventive-alert", controller.preventiveAlert);
router.post("/supervised/app-abandonment", controller.appAbandonment);
router.post("/supervised/sleep-quality", controller.sleepQuality);
router.post("/supervised/sedentary-risk", controller.sedentaryRisk);
router.post("/supervised/chatbot-sensitive", controller.chatbotSensitive);

// ==============================
// NO SUPERVISADOS
// ==============================
router.post(
  "/unsupervised/health-habits-segmentation",
  controller.healthHabitsSegmentation
);
router.post(
  "/unsupervised/symptom-patterns",
  controller.symptomPatterns
);
router.post(
  "/unsupervised/emotional-profiles",
  controller.emotionalProfiles
);
router.post(
  "/unsupervised/health-anomalies",
  controller.healthAnomalies
);
router.post(
  "/unsupervised/habit-symptom-association",
  controller.habitSymptomAssociation
);
router.post(
  "/unsupervised/app-behavior-segmentation",
  controller.appBehaviorSegmentation
);
router.post(
  "/unsupervised/chatbot-topics",
  controller.chatbotTopics
);
router.post(
  "/unsupervised/wellness-map",
  controller.wellnessMap
);
router.post(
  "/unsupervised/wellness-routines",
  controller.wellnessRoutines
);
router.post(
  "/unsupervised/preventive-profiles",
  controller.preventiveProfiles
);

module.exports = router;
