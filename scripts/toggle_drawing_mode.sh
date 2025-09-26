#!/bin/sh

[ $(ps aux | grep config-pen | wc -l) -gt 1 ] \
	&& kill -9 $(ps aux | grep config-pen | sed 1q | tr -s " " | cut -f2 -d" ") \
	|| waybar -c $HOME/.config/waybar/config-pen.jsonc &
