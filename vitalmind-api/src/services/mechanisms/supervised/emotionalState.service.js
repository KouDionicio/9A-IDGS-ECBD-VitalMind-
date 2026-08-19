const { clamp, num, text } = require("../_base");

async function execute(data) {
  const mood=text(data.mood).toLowerCase(); const stress=clamp(num(data.stressLevel),1,10); const energy=clamp(num(data.energyLevel),1,10); const sleep=clamp(num(data.sleepQuality),1,10);
  const moodScore={"muy bien":1,"bien":0.8,"regular":0.5,"mal":0.25,"muy mal":0.1}[mood] ?? 0.5;
  const score=clamp(0.4*moodScore+0.25*(1-stress/10)+0.2*(energy/10)+0.15*(sleep/10));
  const state=score>=0.7?"estable":score>=0.45?"vulnerable":"desfavorable";
  return {mechanism:"emotional-state",type:"supervised",result:{score:Number(score.toFixed(2)),state,followUp:state!=="estable"},input:{mood:data.mood||null,stressLevel:stress,energyLevel:energy,sleepQuality:sleep}};
}
module.exports={execute};
