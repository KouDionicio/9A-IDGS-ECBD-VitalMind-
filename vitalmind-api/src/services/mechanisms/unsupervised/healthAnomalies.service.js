const { arr, num } = require("../_base");

async function execute(data) {
  const metrics=arr(data.metrics); const fields=["temperature","heartRate","glucose","systolic","diastolic"]; const anomalies=[]; for(const m of metrics){const flags=[]; if(m.temperature!=null&&(num(m.temperature)<35||num(m.temperature)>39))flags.push("temperature"); if(m.heartRate!=null&&(num(m.heartRate)<50||num(m.heartRate)>120))flags.push("heartRate"); if(m.glucose!=null&&(num(m.glucose)<70||num(m.glucose)>200))flags.push("glucose"); if(m.systolic!=null&&(num(m.systolic)<90||num(m.systolic)>180))flags.push("systolic"); if(m.diastolic!=null&&(num(m.diastolic)<60||num(m.diastolic)>120))flags.push("diastolic"); if(flags.length) anomalies.push({record:m,fields:flags});}
  return {mechanism:"health-anomalies",type:"unsupervised",result:{anomalyCount:anomalies.length,anomalies,hasAnomalies:anomalies.length>0},input:{metrics}};
}
module.exports={execute};
