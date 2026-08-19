const { clamp, num } = require("../_base");

async function execute(data) {
  const water=num(data.waterGlasses,0), exercise=num(data.exerciseMinutes,0), sleep=num(data.sleepHours,0), meditation=num(data.meditationMinutes,0);
  const score=(clamp(water/8)+clamp(exercise/150)+clamp(sleep/8)+clamp(meditation/70))/4; const segment=score>=0.75?"saludable":score>=0.5?"intermedio":"requiere_mejora";
  return {mechanism:"health-habits-segmentation",type:"unsupervised",result:{segment,score:Number(score.toFixed(2)),features:{water,exercise,sleep,meditation}},input:{waterGlasses:water,exerciseMinutes:exercise,sleepHours:sleep,meditationMinutes:meditation}};
}
module.exports={execute};
