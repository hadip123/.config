#!/bin/sh


kill_the_timer() {
	echo "here"
	prompt=$(echo "yes\nno" | wmenu -p "kill the timer" -M 606079  -l 20 -f "MonaspiceAr Nerd Font Mono 16" -i -N 121212 -S 7e98e8 -s 121212 -b)
	[ -z $prompt ] && return
	[ $prompt = "yes" ] && \
		kill -9 $(ps aux | grep -i timer_start.sh | tr -s " " | cut -f2 -d " " | sed 1q) && \
		notify-send "TIMER" "Timer ended."

}

count=$(ps aux | grep -i timer_start.sh | tr -s " " | cut -f2 -d " " | wc -l)
echo $count 
[ $count -gt 1 ] && kill_the_timer || sh $HOME/.config/scripts/timer/timer_start.sh

