const { arr, clamp, num } = require("../_base");

async function execute(data) {
  const users=arr(data.users); const profiles=users.map((u,i)=>{const risk=clamp(0.3*(num(u.symptomBurden)/10)+0.25*(1-clamp(num(u.habitAdherence)/100))+0.2*clamp(num(u.stressLevel)/10)+0.15*clamp(num(u.sedentaryRisk)/100)+0.1*(1-clamp(num(u.sleepQuality)/10))); const profile=risk>=0.67?"seguimiento_prioritario":risk>=0.34?"seguimiento":"preventivo_básico"; return {index:i,profile,riskScore:Number(risk.toFixed(2))};});
  return {mechanism:"preventive-profiles",type:"unsupervised",result:{profiles,counts:profiles.reduce((a,p)=>(a[p.profile]=(a[p.profile]||0)+1,a),{})},input:{users}};
}
module.exports={execute};
