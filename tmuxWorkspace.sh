#! /bin/sh

# Session Name
session="dotfiles"
wNvim="nvim"
wShell="zsh"

# Check if session already exists
if tmux has-session -t $session 2> /dev/null; then
	echo "$session already exists. Attaching to it"
	tmux attach-session -t $session
else
	# Create session and start nvim
	tmux new-session -d -s $session -n $wNvim nvim README.md
	# extra shell ready for random stuff
	tmux new-window -d -t $session -a -n $wShell
	# attach to session
	tmux attach-session -t $session
fi

