import { CapacitorConfig } from '@capacitor/cli';

// ─────────────────────────────────────────────────────────────────────────────
// MCF iOS — capacitor.config.ts (racine du dépôt mcf-ios)
// Ce fichier sert à `npx cap sync ios` pour savoir où synchroniser.
// ─────────────────────────────────────────────────────────────────────────────

const config: CapacitorConfig = {
  appId: 'my.cook.flex',
  appName: 'My Cook Flex',

  // Pointe vers le dossier contenant le build web statique
  // (copié ici depuis le projet principal lors de la sync)
  webDir: 'App/App/public',

  ios: {
    // Chemin vers le projet Xcode
    path: 'App',
  },

  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      launchAutoHide: true,
      backgroundColor: '#0a0a0a',
      showSpinner: true,
      iosSpinnerStyle: 'small',
      spinnerColor: '#f97316',
    },
    Keyboard: {
      resize: 'body' as any,
      style: 'dark' as any,
      resizeOnFullScreen: true,
    },
    FirebaseAuthentication: {
      skipNativeAuth: false,
      providers: ['google.com'],
    },
    PushNotifications: {
      presentationOptions: ['badge', 'sound', 'alert'],
    }
  }
};

export default config;
