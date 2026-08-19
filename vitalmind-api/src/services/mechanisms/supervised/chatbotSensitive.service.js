const { text } = require("../_base");

async function execute(data) {
  const message=text(data.message); const lower=message.toLowerCase();
  const categories={crisis:["suicid","matarme","quitarme la vida","no quiero vivir"],violence:["matar","hacer daño","violencia"],medicalEmergency:["no puedo respirar","dolor intenso en el pecho","desmayo"]};
  const matches=[]; for(const [category,words] of Object.entries(categories)){if(words.some(w=>lower.includes(w))) matches.push(category);}
  const sensitive=matches.length>0;
  return {mechanism:"chatbot-sensitive",type:"supervised",result:{sensitive,categories:matches,priority:matches.includes("crisis")?"critica":matches.length?"alta":"normal",action:sensitive?"Escalar a revisión humana o recursos profesionales según el caso.":"Continuar conversación normal."},input:{message}};
}
module.exports={execute};
