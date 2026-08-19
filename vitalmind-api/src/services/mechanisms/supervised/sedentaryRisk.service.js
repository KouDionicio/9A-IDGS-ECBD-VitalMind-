const { clamp, num } = require("../_base");

async function execute(data) {
  const minutes=num(data.exerciseMinutes,0), sedentary=num(data.sedentaryMinutes,0), breaks=num(data.movementBreaks,0);
  const score=clamp(0.55*clamp(sedentary/720)+0.35*(1-clamp(minutes/150))+0.1*(1-clamp(breaks/5))); const risk=score>=0.67?"alto":score>=0.34?"medio":"bajo";
  return {mechanism:"sedentary-risk",type:"supervised",result:{riskScore:Number(score.toFixed(2)),risk,recommendation:risk==="alto"?"Incrementar pausas activas y actividad física.":risk==="medio"?"Añadir pausas activas durante el día.":"Mantener actividad regular."},input:{exerciseMinutes:minutes,sedentaryMinutes:sedentary,movementBreaks:breaks}};
}
module.exports={execute};
