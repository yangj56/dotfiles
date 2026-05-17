#!/usr/bin/env bash
set -euo pipefail
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew bundle --file "$DOTFILES/Brewfile"

# Oh My Zsh (safe install)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

chmod +x "$DOTFILES/bin/link" "$DOTFILES/bin/doctor"

"$DOTFILES/bin/link" "$DOTFILES/config/zsh/zshrc" "$HOME/.zshrc"
"$DOTFILES/bin/link" "$DOTFILES/config/git/gitconfig" "$HOME/.gitconfig"
"$DOTFILES/bin/link" "$DOTFILES/config/git/gitignore_global" "$HOME/.gitignore_global"

# NVM + Node LTS
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
source "$(brew --prefix nvm)/nvm.sh"
nvm install --lts
nvm use --lts

echo "Install complete"
