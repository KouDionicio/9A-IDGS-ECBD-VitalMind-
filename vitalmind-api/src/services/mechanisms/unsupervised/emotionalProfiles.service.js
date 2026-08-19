const { arr, clamp, num } = require("../_base");

async function execute(data) {
  const logs=arr(data.logs); const avg=(field,fallback=5)=>logs.length?logs.reduce((a,x)=>a+num(x[field],fallback),0)/logs.length:fallback; const stress=avg("stressLevel"), energy=avg("energyLevel"), sleep=avg("sleepQuality"); const profile=stress>=7&&energy<=4?"estresado":energy>=7&&sleep>=7?"equilibrado":sleep<=4?"fatiga": "mixto";
  return {mechanism:"emotional-profiles",type:"unsupervised",result:{profile,centroid:{stress:Number(stress.toFixed(2)),energy:Number(energy.toFixed(2)),sleepQuality:Number(sleep.toFixed(2))},records:logs.length},input:{logs}};
}
module.exports={execute};
