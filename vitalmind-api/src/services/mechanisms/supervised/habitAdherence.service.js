const { arr, clamp, num } = require("../_base");

async function execute(data) {
  const habits = arr(data.habits);
  const items = habits.map(h => { const expected=Math.max(1,num(h.expected,1)); const completed=Math.max(0,num(h.completed,0)); const adherence=clamp(completed/expected)*100; return { name:h.name||"sin_nombre", expected, completed, adherence:Number(adherence.toFixed(1)) }; });
  const overall = items.length ? items.reduce((a,h)=>a+h.adherence,0)/items.length : 0;
  const level = overall >= 80 ? "alta" : overall >= 50 ? "media" : "baja";
  return { mechanism:"habit-adherence", type:"supervised", result:{ overallAdherence:Number(overall.toFixed(1)), level, habits:items }, input:{ habits } };
}
module.exports={execute};
