const { arr, num } = require("../_base");

async function execute(data) {
  const symptoms = arr(data.symptoms);
  const totalDays = Math.max(1, num(data.periodDays, 30));
  const occurrences = symptoms.map((s) => ({ type: s.type || "sin_tipo", frequency: num(s.frequency, 0), durationDays: num(s.durationDays, 0) }));
  const total = occurrences.reduce((a, s) => a + s.frequency, 0);
  const rate = total / totalDays;
  const level = rate >= 0.2 ? "alta" : rate >= 0.1 ? "media" : "baja";
  return { mechanism: "symptom-recurrence", type: "supervised", result: { recurrenceRate: Number(rate.toFixed(3)), level, totalOccurrences: total, mostFrequent: occurrences.sort((a,b)=>b.frequency-a.frequency)[0]?.type || null }, input: { symptoms, periodDays: totalDays } };
}
module.exports = { execute };
