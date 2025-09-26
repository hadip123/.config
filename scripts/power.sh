#!/bin/sh

PICKED=$(cat $HOME/.config/scripts/power.txt | \
	wmenu -p "POWER" -M 606079  -l 20 -f "MonaspiceAr Nerd Font Mono 16" -i -N 121212 -S 7e98e8 -s 121212 -b  | \
	cut -f2 -d"|" | xargs)

perform() {
	[ "$PICKED" = "systemctl suspend" ] && swaylock -c 121212 &
	$PICKED
}

[ -z "$PICKED" ] || perform
