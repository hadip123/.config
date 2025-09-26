#!/bin/sh

kill_drawing_options() {
	kill -9 $(ps aux | grep config-pen | sed 1q | tr -s " " | cut -f2 -d" ")
	for var in $(ps aux | grep -i Gromit-mpx | sed 3q | tr -s " " | cut -f2 -d" "); do
		kill -9 $var
	done
}

run_drawing_options() {
	flatpak run net.christianbeier.Gromit-MPX &
	waybar -c $HOME/.config/waybar/config-pen.jsonc &
}

[ $(ps aux | grep config-pen | wc -l) -gt 1 ] \
	&& kill_drawing_options \
	|| run_drawing_options

