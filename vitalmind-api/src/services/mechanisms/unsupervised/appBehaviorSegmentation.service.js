const { clamp, num } = require("../_base");

async function execute(data) {
  const sessions=num(data.sessionsLast30Days,0), logs=num(data.logsLast30Days,0), days=num(data.activeDays,0), gap=num(data.daysSinceLastActivity,0); const score=0.35*clamp(sessions/20)+0.3*clamp(logs/50)+0.2*clamp(days/30)+0.15*(1-clamp(gap/30)); const segment=score>=0.7?"muy_activo":score>=0.45?"activo":score>=0.25?"ocasional":"inactivo";
  return {mechanism:"app-behavior-segmentation",type:"unsupervised",result:{segment,score:Number(score.toFixed(2)),features:{sessions,logs,days,gap}},input:{sessionsLast30Days:sessions,logsLast30Days:logs,activeDays:days,daysSinceLastActivity:gap}};
}
module.exports={execute};
