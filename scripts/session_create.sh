#!/bin/bash

DIRS=(
	"$HOME/w"
	"$HOME"
	"$HOME/.config"
	"$HOME/Projects"
	)

if [[ $# -eq 1 ]]; then
	selected=$1
else
	selected=$(find "${DIRS[@]}" -maxdepth 1 -type d \
		| sed "s|^$HOME/||" \
		| fzf --margin 20% --color "bw")

	[[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)
if ! tmux has-session -t "$selected_name"; then
	tmux new-session -ds "$selected_name" -c "$selected"
	tmux select-window -t "$selected_name:0"
fi

tmux switch-client -t "$selected_name"
