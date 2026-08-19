const { clamp, num } = require("../_base");

async function execute(data) {
  const pain = clamp(num(data.pain), 0, 10);
  const temperature = num(data.temperature, 36.5);
  const heartRate = num(data.heartRate, 72);
  const painScore = pain / 10;
  const tempScore = clamp((temperature - 37.5) / 3);
  const heartScore = clamp((heartRate - 100) / 60);
  const score = clamp(0.5 * painScore + 0.3 * tempScore + 0.2 * heartScore);
  const priority = score >= 0.67 ? "alta" : score >= 0.34 ? "media" : "baja";
  return { mechanism: "symptom-priority", type: "supervised", result: { score: Number(score.toFixed(2)), priority, interpretation: priority === "alta" ? "Requiere atención prioritaria." : priority === "media" ? "Conviene dar seguimiento." : "Prioridad baja." }, input: { pain, temperature, heartRate } };
}
module.exports = { execute };
