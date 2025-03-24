source .path

#Theme
fpath=(~/.config/zsh/theme/ $fpath)
autoload -U promptinit
promptinit
#source ~/.config/zsh/theme/agnoster.zsh-theme

# Aliases
source ~/.aliases

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
