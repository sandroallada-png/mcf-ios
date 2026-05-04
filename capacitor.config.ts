import { CapacitorConfig } from '@capacitor/cli';
// MCF iOS LOCAL BUILD — généré par scripts/prepare-ios.js
// NE PAS COMMITER CE FICHIER tel quel (il est temporaire)

const config: CapacitorConfig = {
  appId: 'my.cook.flex',
  appName: 'My Cook Flex',
  webDir: 'public',          // ← Dossier synchronisé pour le build natif (compatible Appflow)
  // PAS de server.url → WebView charge les fichiers locaux (out/)
  // Cela permet de voir les vraies erreurs JS dans la console Xcode / Safari
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      launchAutoHide: true,
      backgroundColor: '#0a0a0a',
      androidScaleType: 'CENTER_CROP',
      showSpinner: true,
      androidSpinnerStyle: 'large',
      iosSpinnerStyle: 'small',
      spinnerColor: '#f97316',
    },
    Keyboard: {
      resize: 'body',
      style: 'dark',
      resizeOnFullScreen: true,
    },
    FirebaseAuthentication: {
      skipNativeAuth: true,
      providers: ['google.com'],
    }
  }
};

export default config;
