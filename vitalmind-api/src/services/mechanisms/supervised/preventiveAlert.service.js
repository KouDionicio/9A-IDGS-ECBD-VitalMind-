const { clamp, num, arr } = require("../_base");

async function execute(data) {
  const pain=clamp(num(data.pain),0,10), temp=num(data.temperature,36.5), hr=num(data.heartRate,72), glucose=num(data.glucose,0);
  const factors=[]; if(pain>=8) factors.push("dolor_alto"); if(temp>=38) factors.push("temperatura_elevada"); if(hr>=120||hr<=50) factors.push("frecuencia_cardiaca_atipica"); if(glucose>0&&(glucose>=200||glucose<70)) factors.push("glucosa_fuera_de_rango"); if(arr(data.medicalHistory).length) factors.push("antecedentes_presentes");
  const level=factors.length>=3?"alta":factors.length>=1?"media":"baja";
  return {mechanism:"preventive-alert",type:"supervised",result:{alert:level!=="baja",level,factors,message:level==="alta"?"Se recomienda valoración profesional prioritaria.":level==="media"?"Se recomienda seguimiento de los datos.":"No se detectaron señales preventivas relevantes con los datos recibidos."},input:{pain,temperature,heartRate,glucose,medicalHistory:arr(data.medicalHistory)}};
}
module.exports={execute};
