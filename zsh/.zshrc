source ~/.path

#Theme
fpath=(~/.config/zsh/theme/ $fpath)
autoload -U promptinit
promptinit
prompt agnoster

source ~/.config/zsh/theme/zshcolors

# Aliases
source ~/.aliases

bindkey -e

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
