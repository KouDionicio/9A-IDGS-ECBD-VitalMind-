const { arr, num } = require("../_base");

async function execute(data) {
  const routines=arr(data.routines); const groups={}; routines.forEach(r=>{const key=[num(r.exerciseMinutes),num(r.sleepHours),num(r.meditationMinutes)].map(v=>v>0?1:0).join(""); (groups[key] ||= []).push(r);}); const clusters=Object.entries(groups).map(([pattern,items])=>({pattern,size:items.length,examples:items.slice(0,3)})).sort((a,b)=>b.size-a.size);
  return {mechanism:"wellness-routines",type:"unsupervised",result:{clusterCount:clusters.length,clusters},input:{routines}};
}
module.exports={execute};
