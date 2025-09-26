#!/bin/bash

ask_and_make() {
	[ $( \
		echo "yes\nno" | \
		wmenu -p "It doesn't exist, make it?" -M 606079  -l 20 -f "MonaspiceAr Nerd Font Mono 16" -i -N 121212 -S 7e98e8 -s 121212 -b \
	) = "yes" ] && echo "0" > $1
}

start() {
	prompt=$(wmenu -p "A name for the timer" -M 606079  -l 20 -f "MonaspiceAr Nerd Font Mono 16" -i -N 121212 -S 7e98e8 -s 121212 -b < /dev/null)
	[ -z $prompt ] && return

	mkdir -p $HOME/.config/scripts/timer/timers
	t_path=$HOME/.config/scripts/timer/timers/$prompt
	cat $t_path || ask_and_make $t_path
	cat $t_path || return

	num=$(cat $t_path | xargs )
	notify-send "TIMER" "Timer $prompt started"
	while true; do
		num=$((num + 1))
		echo $num > $t_path
		sleep 1
	done
}

start
