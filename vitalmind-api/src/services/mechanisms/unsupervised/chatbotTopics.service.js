const { arr, text } = require("../_base");

async function execute(data) {
  const messages=arr(data.messages); const keywords={medicacion:["medicamento","pastilla","medicina","dosis"],sintomas:["dolor","síntoma","sintoma","fiebre","mareo"],habitos:["agua","ejercicio","sueño","dormir","alimentación"],emociones:["estrés","estres","ansiedad","ánimo","animo","emocional"],citas:["cita","doctor","médico","medico"]}; const topics=[]; for(const [topic,words] of Object.entries(keywords)){const count=messages.filter(m=>words.some(w=>text(m).toLowerCase().includes(w))).length;if(count)topics.push({topic,count,share:Number((count/(messages.length||1)).toFixed(2))});} topics.sort((a,b)=>b.count-a.count);
  return {mechanism:"chatbot-topics",type:"unsupervised",result:{topics,dominantTopic:topics[0]?.topic||null,totalMessages:messages.length},input:{messages}};
}
module.exports={execute};
