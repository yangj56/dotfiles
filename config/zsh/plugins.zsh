autoload -Uz compinit
compinit

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "$(brew --prefix)/etc/profile.d/autojump.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
