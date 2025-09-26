#!/bin/sh

STAT=$(swaymsg -t get_inputs | \
	jq '.[] | select(.identifier == "1386:20795:Wacom_HID_513B_Finger") | .libinput.send_events')

[ $STAT = '"enabled"' ] \
	&& swaymsg input 1386:20795:Wacom_HID_513B_Finger events disabled \
	|| swaymsg input 1386:20795:Wacom_HID_513B_Finger events enabled 
