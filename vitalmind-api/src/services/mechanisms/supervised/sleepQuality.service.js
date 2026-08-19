const { clamp, num } = require("../_base");

async function execute(data) {
  const hours=num(data.sleepHours,0), quality=clamp(num(data.sleepQuality,5),1,10), interruptions=Math.max(0,num(data.interruptions,0));
  const duration=clamp(1-Math.abs(8-hours)/4); const interruptionScore=1-clamp(interruptions/5); const score=clamp(0.45*duration+0.4*(quality/10)+0.15*interruptionScore)*100;
  const level=score>=80?"buena":score>=60?"regular":"baja";
  return {mechanism:"sleep-quality",type:"supervised",result:{score:Number(score.toFixed(1)),level,recommendation:level==="baja"?"Revisar rutina y duración del sueño.":level==="regular"?"Mantener horarios consistentes.":"Mantener la rutina actual."},input:{sleepHours:hours,sleepQuality:quality,interruptions}};
}
module.exports={execute};
