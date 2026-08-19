const { arr, num } = require("../_base");

async function execute(data) {
  const records=arr(data.records), associations=[]; const habits=[...new Set(records.flatMap(r=>arr(r.habits)))], symptoms=[...new Set(records.flatMap(r=>arr(r.symptoms)))]; for(const h of habits){for(const s of symptoms){const subset=records.filter(r=>arr(r.habits).includes(h)); const withSym=subset.filter(r=>arr(r.symptoms).includes(s)).length; if(subset.length&&withSym){associations.push({habit:h,symptom:s,support:Number((withSym/records.length).toFixed(3)),confidence:Number((withSym/subset.length).toFixed(3))});}}}
  associations.sort((a,b)=>b.confidence-a.confidence); return {mechanism:"habit-symptom-association",type:"unsupervised",result:{associations:associations.slice(0,20),strongest:associations[0]||null},input:{records}};
}
module.exports={execute};
