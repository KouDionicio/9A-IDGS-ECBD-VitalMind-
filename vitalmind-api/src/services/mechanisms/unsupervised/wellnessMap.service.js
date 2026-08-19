const { arr, num } = require("../_base");

async function execute(data) {
  const records=arr(data.records); const points=records.map((r,i)=>{const x=(num(r.exerciseMinutes)/150)-(num(r.stressLevel)/10); const y=(num(r.sleepHours)/8)-(num(r.pain)/10); return {index:i,x:Number(x.toFixed(3)),y:Number(y.toFixed(3)),label:r.label||`registro_${i+1}`};});
  return {mechanism:"wellness-map",type:"unsupervised",result:{dimensions:2,points,axes:{x:"actividad vs estrés",y:"sueño vs dolor"}},input:{records}};
}
module.exports={execute};
