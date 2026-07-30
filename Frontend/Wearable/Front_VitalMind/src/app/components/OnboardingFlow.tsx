import React, { useState } from 'react';
import { 
  Heart, Bell, Shield, Sparkles, Check, ArrowRight 
} from 'lucide-react';
import { Button } from './ui/button';
import { motion } from 'motion/react';
import robotWelcomeImg from 'figma:asset/03a3b28fa7cd491b4fbb62799bfa2e0fb42d627b.png';
import robotAlarmImg from 'figma:asset/c3577df68b7634c2dfa83ca9bb0cdcb1dd360c80.png';
import robotSecurityImg from 'figma:asset/dfd811b53452431a8ba066e23651c863144a3e87.png';

interface OnboardingFlowProps {
  onComplete: () => void;
}

export default function OnboardingFlow({ onComplete }: OnboardingFlowProps) {
  const [step, setStep] = useState(0);

  const steps = [
    {
      icon: Heart,
      title: '¡Bienvenido a MedAlert!',
      description: 'Tu asistente personal para gestionar medicamentos y nunca olvidar tus tratamientos.',
      color: 'text-primary',
      bgColor: 'bg-primary',
      lightBg: 'bg-primary/10',
      features: [
        'Recordatorios inteligentes 24/7',
        'Historial completo de medicamentos',
        'Gestor inteligente de Avent'
      ],
      image: robotWelcomeImg
    },
    {
      icon: Bell,
      title: 'Recordatorios que salvan vidas',
      description: 'Nunca olvides tomar tus medicamentos. Recibe alertas personalizadas en el momento exacto.',
      color: 'text-secondary',
      bgColor: 'bg-secondary',
      lightBg: 'bg-secondary/10',
      features: [
        'Notificaciones precisas',
        'Alarmas inteligentes',
        'Confirma cuando tomas tus pastillas'
      ],
      image: robotAlarmImg
    },
    {
      icon: Shield,
      title: 'Seguro y Privado',
      description: 'Tus datos médicos están protegidos. Tu salud, tu información, tu control total.',
      color: 'text-accent-green',
      bgColor: 'bg-accent-green',
      lightBg: 'bg-accent-green/10',
      features: [
        'Privacidad garantizada',
        'Datos encriptados',
        'Sin compartir con terceros'
      ],
      image: robotSecurityImg
    },
    {
      icon: Sparkles,
      title: '¡Listo para Empezar!',
      description: 'Comienza a cuidar tu salud hoy. Solo toma 2 minutos configurar tu primer medicamento.',
      color: 'text-primary',
      bgColor: 'bg-primary',
      lightBg: 'bg-primary/10',
      features: [
        'Agrega tus medicamentos',
        'Configura horarios',
        'Mejora tu adherencia'
      ]
    }
  ];

  const currentStep = steps[step];
  const Icon = currentStep.icon;

  const handleNext = () => {
    if (step < steps.length - 1) {
      setStep(step + 1);
    } else {
      onComplete();
    }
  };

  const handleSkip = () => {
    onComplete();
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 to-white dark:from-slate-900 dark:to-slate-800 flex flex-col relative overflow-hidden">
      {/* Skip Button */}
      <div className="p-4 flex justify-end z-10">
        <motion.button
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          onClick={handleSkip}
          className="text-slate-600 dark:text-slate-400 hover:text-[#0066cc] dark:hover:text-[#0066cc] px-4 py-2 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-all text-sm"
        >
          Omitir
        </motion.button>
      </div>

      {/* Content */}
      <div className="flex-1 flex flex-col items-center justify-center px-4 max-w-[375px] mx-auto z-10 w-full">
        <motion.div
          key={step}
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: -20 }}
          transition={{ duration: 0.3 }}
          className="w-full"
        >
          {/* MedAlert+ Title - Same as SignInScreen */}
          <motion.div 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.1 }}
            className="text-center mb-6"
          >
            <h1 className="text-[2.5rem] tracking-tight mb-2 font-bold" style={{ color: '#0066cc' }}>
              MedAlert+
            </h1>
          </motion.div>

          {/* Robot Image - Only for steps 1, 2, and 3 */}
          {currentStep.image && (
            <motion.div 
              initial={{ scale: 0.8, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 0.15, type: "spring", stiffness: 200 }}
              className="mb-6 flex justify-center"
            >
              <div className="w-32 h-32 flex items-center justify-center">
                <img 
                  src={currentStep.image} 
                  alt={currentStep.title}
                  className="w-full h-full object-contain"
                />
              </div>
            </motion.div>
          )}

          {/* Icon Badge at the top */}
          <motion.div 
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="mb-6 flex justify-center"
          >
            <div className={`w-20 h-20 rounded-2xl ${currentStep.bgColor} flex items-center justify-center shadow-lg`}>
              <Icon className="w-10 h-10 text-white" />
            </div>
          </motion.div>

          {/* Title */}
          <motion.h2 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.25 }}
            className="text-center mb-3 px-2 text-slate-900 dark:text-slate-100 text-xl"
          >
            {currentStep.title}
          </motion.h2>

          {/* Description */}
          <motion.p 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.3 }}
            className="text-center text-slate-600 dark:text-slate-400 mb-6 px-4 leading-relaxed text-sm"
          >
            {currentStep.description}
          </motion.p>

          {/* Features */}
          <div className="space-y-3 mb-8 w-full">
            {currentStep.features.map((feature, index) => (
              <motion.div
                key={index}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: 0.4 + index * 0.1 }}
                className="flex items-center gap-3 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 p-4 rounded-xl hover:shadow-sm transition-all"
              >
                <motion.div 
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  transition={{ delay: 0.5 + index * 0.1 }}
                  className={`w-9 h-9 rounded-lg ${currentStep.lightBg} flex items-center justify-center flex-shrink-0`}
                >
                  <Check className={`w-5 h-5 ${currentStep.color}`} />
                </motion.div>
                <span className="text-slate-900 dark:text-slate-100 text-sm">{feature}</span>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </div>

      {/* Progress and Navigation */}
      <div className="p-4 max-w-[375px] mx-auto w-full z-10 pb-8">
        {/* Progress Dots */}
        <div className="flex justify-center gap-2 mb-5">
          {steps.map((s, index) => (
            <motion.div
              key={index}
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              className={`h-2 rounded-full transition-all duration-300 ${
                index === step 
                  ? 'w-8 bg-[#0066cc]' 
                  : index < step
                  ? 'w-2 bg-[#0066cc]/40'
                  : 'w-2 bg-slate-300 dark:bg-slate-700'
              }`}
            />
          ))}
        </div>

        {/* Navigation Buttons */}
        <div className="flex gap-3">
          {step > 0 && (
            <motion.div
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              className="flex-1"
            >
              <Button
                variant="outline"
                onClick={() => setStep(step - 1)}
                className="w-full h-12 rounded-xl border-slate-200 dark:border-slate-700 hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-900 dark:text-slate-100"
              >
                Atrás
              </Button>
            </motion.div>
          )}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            className={step > 0 ? "flex-1" : "w-full"}
          >
            <Button
              onClick={handleNext}
              className="w-full h-12 bg-[#0066cc] hover:bg-[#0052a3] text-white rounded-xl shadow-md hover:shadow-lg active:scale-[0.98] transition-all"
            >
              {step === steps.length - 1 ? (
                <>
                  <Sparkles className="w-5 h-5 mr-2" />
                  ¡Comenzar!
                </>
              ) : (
                <>
                  Siguiente
                  <ArrowRight className="w-5 h-5 ml-2" />
                </>
              )}
            </Button>
          </motion.div>
        </div>

        {/* Step Counter */}
        <motion.p 
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="text-center text-sm text-slate-500 dark:text-slate-400 mt-4"
        >
          {step + 1} de {steps.length}
        </motion.p>
      </div>

      {/* Home Indicator */}
      <div className="fixed bottom-2 left-1/2 -translate-x-1/2">
        <div className="w-[134px] h-[5px] bg-slate-900/20 dark:bg-slate-100/20 rounded-full" />
      </div>
    </div>
  );
}