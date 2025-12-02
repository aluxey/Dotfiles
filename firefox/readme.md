# Configuration Firefox

Ce dossier contient uniquement les préférences reproductibles du profil :

```text
firefox/
├── user.js
└── userChrome.css
```

`user.js` est relu à chaque démarrage de Firefox. Une préférence supprimée de ce fichier peut donc rester dans `prefs.js` ; il faut alors la réinitialiser depuis `about:config`.

## Installation

1. Fermer Firefox.
2. Ouvrir `about:profiles` et repérer le **dossier racine** du profil utilisé.
3. Sauvegarder au minimum `prefs.js`, l'ancien `user.js` et le dossier `chrome/`.
4. Copier `user.js` à la racine du profil.
5. Créer le dossier `chrome/` et y copier `userChrome.css`.
6. Redémarrer Firefox.

La préférence `toolkit.legacyUserProfileCustomizations.stylesheets` présente dans `user.js` active automatiquement `userChrome.css`.

## Choix de sécurité

- HTTPS-Only, Global Privacy Control et protection contre le pistage sont activés.
- Les cookies tiers sont partitionnés (`cookieBehavior = 5`) pour préserver davantage de compatibilité qu'un blocage total.
- La télémétrie et les études sont désactivées.
- WebRTC reste disponible pour les appels web.
- Le débogage distant privilégié n'est pas activé dans un profil quotidien.

## Extensions recommandées

- uBlock Origin
- Bitwarden
- Firefox Multi-Account Containers
- SponsorBlock

Les extensions, sessions, cookies, mots de passe et fichiers `prefs.js` ne sont pas versionnés.
