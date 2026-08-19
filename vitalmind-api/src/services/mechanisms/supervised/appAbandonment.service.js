const { num } = require("../_base");

async function execute(data) {
  const days=num(data.daysSinceLastActivity,0), sessions=num(data.sessionsLast30Days,0), trend=num(data.activityTrend,0);
  const score=Math.min(1,0.5*Math.min(days/30,1)+0.3*(1-Math.min(sessions/20,1))+0.2*(trend<0?Math.min(Math.abs(trend),1):0));
  const risk=score>=0.67?"alto":score>=0.34?"medio":"bajo";
  return {mechanism:"app-abandonment",type:"supervised",result:{riskScore:Number(score.toFixed(2)),risk,actions:risk==="alto"?["Enviar recordatorio","Revisar barreras de uso"]:risk==="medio"?["Enviar recordatorio"]:[]},input:{daysSinceLastActivity:days,sessionsLast30Days:sessions,activityTrend:trend}};
}
module.exports={execute};
