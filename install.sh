#!/usr/bin/env bash
set -euo pipefail
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
