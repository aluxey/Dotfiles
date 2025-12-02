# Dotfiles

Configurations personnelles utilisées sous Windows 11 et Ubuntu via WSL.

## Contenu

| Dossier | Configuration | Destination |
| --- | --- | --- |
| `Terminal/` | Zsh, Powerlevel10k et Neofetch | `~/.zshrc`, `~/.p10k.zsh`, `~/.config/neofetch/config.conf` |
| `vsCode/` | Réglages et extensions VS Code | `%APPDATA%\Code\User\settings.json` |
| `zed/` | Réglages Zed sous WSL | `~/.config/zed/settings.json` |
| `WindowsTerminal/` | Profil Windows Terminal | `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json` |
| `firefox/` | Préférences et interface Firefox | Dossier du profil Firefox |
| `Helium/` | Préférences Helium et configuration Mist | `%LOCALAPPDATA%\imput\Helium\User Data` |
| `LeagueOfLegends/` | Réglages en jeu et raccourcis | Dossier `Config` de League of Legends |

Les fonds d'écran et captures sont conservés dans `Wallpapers/` et `Assets/`.

## Installation

Les fichiers existants doivent être sauvegardés avant de les remplacer. Les commandes suivantes installent uniquement les configurations WSL :

```sh
git clone <url-du-depot> ~/Workspace/Dotfiles
cd ~/Workspace/Dotfiles

ln -s "$PWD/Terminal/zshrc" ~/.zshrc
ln -s "$PWD/Terminal/p10k.zsh" ~/.p10k.zsh
mkdir -p ~/.config/neofetch ~/.config/zed
ln -s "$PWD/Terminal/neofetch.conf" ~/.config/neofetch/config.conf
ln -s "$PWD/zed/settings.json" ~/.config/zed/settings.json
```

Les fichiers Windows sont à copier depuis l'Explorateur ou PowerShell après avoir fermé l'application concernée. Les destinations exactes sont indiquées dans le tableau ci-dessus.

### Helium et Mist

Depuis PowerShell, appliquer les préférences portables de Helium :

```powershell
.\Helium\install.ps1
```

Le script refuse de continuer si Helium est ouvert et sauvegarde le fichier `Preferences` avant de le modifier. Il peut aussi ouvrir la page d'installation de Mist :

```powershell
.\Helium\install.ps1 -OpenMistStore
```

Après l'installation de Mist, ouvrir ses réglages puis importer `Helium\mist-config.json` en mode **configuration complète**.

### Dépendances du terminal

- Zsh et Oh My Zsh
- Powerlevel10k
- `zsh-autosuggestions`
- `zsh-history-substring-search`
- `zsh-syntax-highlighting`
- une Nerd Font, idéalement JetBrains Mono
- Neofetch, facultatif

La machine peut définir des chemins ou secrets spécifiques dans `~/.zshrc.local`. Ce fichier n'est jamais versionné.

### Extensions VS Code

Installer la sélection versionnée avec PowerShell :

```powershell
Get-Content .\vsCode\extensions.txt |
  Where-Object { $_ -and -not $_.StartsWith('#') } |
  ForEach-Object { code --install-extension $_ }
```

Les versions ne sont pas figées afin de récupérer une version compatible avec le VS Code installé.

### Firefox

1. Ouvrir `about:profiles` et repérer le profil actif.
2. Copier `firefox/user.js` à la racine du profil.
3. Copier `firefox/userChrome.css` dans le sous-dossier `chrome/`.
4. Redémarrer Firefox.

Les préférences choisies restent équilibrées : HTTPS-Only, protection contre le pistage, partitionnement des cookies et télémétrie désactivée. WebRTC et les outils de débogage distant ne sont pas forcés afin de ne pas casser les appels web ou d'élargir inutilement la surface d'attaque.

## Vérification

```sh
./scripts/check.sh
```

Le script vérifie les fichiers JSON, la syntaxe Zsh et les doublons de préférences Firefox.

## Éléments volontairement non versionnés

- identités Git (`user.name`, `user.email`) ;
- historiques de shell et caches ;
- jetons, sessions et états Discord/OpenCode ;
- `prefs.js`, mots de passe et profils complets Firefox ;
- profils Helium complets, cookies, historique et stockage brut des extensions ;
- chemins locaux temporaires générés par les extensions VS Code.
