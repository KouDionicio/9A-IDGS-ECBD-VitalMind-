const { arr, num } = require("../_base");

async function execute(data) {
  const habits=arr(data.habits); const goals=arr(data.goals); const rec=[];
  const values=habits.reduce((a,h)=>a+(num(h.adherence,0)),0)/(habits.length||1);
  if (!habits.some(h=>String(h.name||"").toLowerCase().includes("agua")) || habits.find(h=>String(h.name||"").toLowerCase().includes("agua"))?.adherence<70) rec.push({habit:"consumo de agua",reason:"Adherencia baja o sin registro",target:"6-8 vasos al día"});
  if (!habits.some(h=>String(h.name||"").toLowerCase().includes("ejercicio")) || habits.find(h=>String(h.name||"").toLowerCase().includes("ejercicio"))?.adherence<70) rec.push({habit:"actividad física",reason:"Adherencia baja o sin registro",target:"20-30 minutos al día"});
  if (!habits.some(h=>String(h.name||"").toLowerCase().includes("sueño")) || habits.find(h=>String(h.name||"").toLowerCase().includes("sueño"))?.adherence<70) rec.push({habit:"sueño",reason:"Adherencia baja o sin registro",target:"7-9 horas"});
  return {mechanism:"habit-recommendation",type:"supervised",result:{recommendations:rec.slice(0,5),currentAdherence:Number(values.toFixed(1)),goals},input:{habits,goals}};
}
module.exports={execute};
