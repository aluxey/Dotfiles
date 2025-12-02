# Helium et Mist

Cette configuration conserve uniquement les préférences portables du navigateur et un export importable de Mist.

## Fichiers

- `preferences.json` : disposition Helium, barre de favoris, thème et langues ;
- `extensions.json` : identifiant et URL officielle de Mist ;
- `mist-config.json` : export complet Mist au format v5 ;
- `install.ps1` : fusion prudente des préférences dans le profil Helium.

Le dossier `User Data` de Chromium n'est jamais copié : il peut contenir cookies, sessions, permissions de sites, historique, données de mots de passe et stockage interne des extensions.

## Appliquer les préférences Helium

Fermer complètement Helium puis lancer PowerShell à la racine du dépôt :

```powershell
.\Helium\install.ps1
```

Pour un profil différent :

```powershell
.\Helium\install.ps1 -Profile 'Profile 1'
```

Le script :

1. vérifie que le profil appartient bien au dossier Helium ;
2. refuse de modifier le fichier si Helium est ouvert ;
3. crée une sauvegarde horodatée de `Preferences` ;
4. fusionne uniquement les clés de `preferences.json`.

## Installer et configurer Mist

Ouvrir automatiquement la fiche Chrome Web Store :

```powershell
.\Helium\install.ps1 -OpenMistStore
```

L'installation de l'extension demande toujours une confirmation dans Helium. Ensuite :

1. ouvrir un nouvel onglet ;
2. ouvrir les réglages de Mist ;
3. choisir l'import de configuration complète ;
4. sélectionner `Helium\mist-config.json`.

La configuration utilise le thème `midnight`, masque la météo et désactive les favicons distants. Ainsi, aucune localisation n'est versionnée et l'ouverture d'un nouvel onglet ne contacte pas le service de favicons de Google.

Les raccourcis sont volontairement limités à des services publics. Les liens privés peuvent être ajoutés localement, puis exportés depuis Mist s'ils sont adaptés à un dépôt public.
