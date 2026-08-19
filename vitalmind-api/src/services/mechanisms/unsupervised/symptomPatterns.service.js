const { arr, num } = require("../_base");

async function execute(data) {
  const symptoms=arr(data.symptoms); const grouped={}; symptoms.forEach(s=>{const k=s.type||"sin_tipo"; grouped[k]=(grouped[k]||0)+num(s.frequency,1);}); const patterns=Object.entries(grouped).sort((a,b)=>b[1]-a[1]).map(([type,count])=>({type,count}));
  return {mechanism:"symptom-patterns",type:"unsupervised",result:{patterns,dominantPattern:patterns[0]?.type||null,patternCount:patterns.length},input:{symptoms}};
}
module.exports={execute};
