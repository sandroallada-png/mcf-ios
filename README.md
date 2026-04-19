# 🍎 MCF iOS — Dépôt Autonome

> Projet Xcode **entièrement isolé** pour **My Cook Flex** (iOS).
> Aucune dépendance vers le projet Next.js parent.
> Structure identique au dépôt Android (`native`).

---

## 📁 Structure du Dépôt

```
mcf-ios/
├── App/                          ← Projet Xcode complet
│   ├── App/
│   │   ├── AppDelegate.swift     ← Point d'entrée iOS (Firebase, Push, URLs)
│   │   ├── Info.plist            ← Métadonnées app (permissions, URL schemes)
│   │   ├── GoogleService-Info.plist  ← Config Firebase iOS
│   │   ├── capacitor.config.json ← Config Capacitor embarquée
│   │   ├── config.xml            ← Héritage Cordova (requis par Capacitor)
│   │   ├── Assets.xcassets/      ← Icônes et images
│   │   ├── Base.lproj/           ← Storyboards (Launch, Main)
│   │   └── public/               ← ⬅ Build web (dist/ copié ici)
│   ├── App.xcodeproj/            ← Fichier de projet Xcode
│   └── CapApp-SPM/               ← Packages Swift (autonomes, depuis GitHub)
│       ├── Package.swift         ← Dépendances SPM (Capacitor, Firebase, etc.)
│       └── Sources/              ← Fichier Swift vide requis par SPM
├── capacitor.config.ts           ← Config Capacitor CLI (racine)
├── package.json                  ← Dépendances Node (Capacitor CLI uniquement)
├── .gitignore
└── README.md
```

---

## 🔗 Dépendances (autonomes, depuis GitHub)

| Package | Source | Version |
|:---|:---|:---:|
| Capacitor Core + Cordova | `ionic-team/capacitor-swift-pm` | `8.1.0` |
| App, Camera, Push | `ionic-team/capacitor-plugins` | `8.1.0` |
| Firebase Auth | `capawesome-team/capacitor-firebase` | `≥7.0.0` |

> ✅ **Aucun chemin vers `node_modules`** — tout vient de GitHub via SPM.

---

## 🚀 Workflow Complet

### Étape 1 — Sur le PC Windows (projet `mcf`)

```bash
# Build complet + sync iOS en une commande
npm run build:ios-native

# OU manuellement :
node scripts/prepare-ios.js   # prépare l'export statique
npm run build                 # génère dist/
node scripts/sync-ios-dist.js # copie dist/ vers mcf-ios-dist/App/App/public/
node scripts/restore-ios.js   # restaure le projet pour Vercel
```

### Étape 2 — Pousser vers ce dépôt

```bash
cd C:\Users\SSD\Desktop\MCF-works\mcf-ios-dist
git add App/App/public/
git commit -m "chore: update web build"
git push
```

### Étape 3 — Sur le Mac

```bash
# Cloner
git clone https://github.com/sandroallada-png/mcf-ios.git
cd mcf-ios

# Installer Capacitor CLI (uniquement)
npm install

# Ouvrir dans Xcode
npm run open
# OU : npx cap open ios
```

---

## 🔍 Déboguer l'Écran Blanc

1. Lancer l'app depuis **Xcode** (simulateur ou iPhone réel)
2. Ouvrir **Safari** sur le Mac
3. Menu **Développement** → simulateur/iPhone → **My Cook Flex**
4. Les erreurs JavaScript apparaissent **en rouge** dans la console

> Équivalent de Chrome DevTools sur Android.

---

## 🔐 Signature (Code Signing)

### Pour tester sur simulateur
→ **Automatic Signing** avec n'importe quel compte Apple (gratuit suffit).

### Pour tester sur un iPhone réel (sans App Store)
→ **Automatic Signing** avec votre compte Apple Developer.

### Pour soumettre à l'App Store
→ **Manual Signing** :
- Team ID : `KV825CMDG7` (Setondji Maxy Djisso)
- Certificat de distribution + Provisioning Profile (via App Store Connect)

---

## 🔄 Mise à jour du Build Web

Quand le code Next.js change, depuis le PC Windows :

```bash
# Dans le dossier mcf/
npm run build:ios-native

# Puis pousser mcf-ios-dist
cd ..\mcf-ios-dist
git add -A && git commit -m "chore: web build update" && git push
```

---

## ⚙️ Prérequis Mac

| Outil | Version | Installation |
|:---|:---|:---|
| Xcode | 14+ (16+ recommandé) | App Store |
| Node.js | 20+ | `brew install node` |
| npm | 10+ | inclus avec Node |

> Les packages Swift (Capacitor, Firebase) sont téléchargés automatiquement par Xcode depuis GitHub la première fois.
