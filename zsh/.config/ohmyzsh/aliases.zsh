# Navigation
alias dl="cd ~/Downloads"
alias ws="cd ~/workspace"
alias dt="cd ~/dotfiles"
alias {doc,docs}="cd ~/Documents"

#Common
alias la="ls -laFh"
alias cls="clear"
alias printpath="echo $PATH|tr ':' '\n'"
alias dfh="duf"

# Tmux
alias tls="tmux list-sessions"
alias {tma,ta}="tmux attach"

# Maven
alias ci="mvn clean install"
alias sbr="mvn spring-boot:run"

# Docker
alias dcls="docker context list"
alias dcl="docker context use default"
alias dcd="docker context use dockerman"
