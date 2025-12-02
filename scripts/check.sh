#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repository_root"

json_files=(
  "vsCode/settings.json"
  "zed/settings.json"
  "WindowsTerminal/settings.json"
  "Helium/preferences.json"
  "Helium/extensions.json"
  "Helium/mist-config.json"
)

for json_file in "${json_files[@]}"; do
  python3 -m json.tool "$json_file" >/dev/null
  printf 'JSON valide : %s\n' "$json_file"
done

zsh -n Terminal/zshrc
zsh -n Terminal/p10k.zsh
printf 'Syntaxe Zsh valide\n'

duplicate_preferences="$({
  sed -nE 's/^user_pref\("([^"]+)".*/\1/p' firefox/user.js
} | sort | uniq -d)"

if [[ -n "$duplicate_preferences" ]]; then
  printf 'Préférences Firefox dupliquées :\n%s\n' "$duplicate_preferences" >&2
  exit 1
fi

printf 'Préférences Firefox uniques\n'
git diff --check
printf 'Aucune erreur d’espace dans le diff\n'
