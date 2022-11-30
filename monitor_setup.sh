#!/bin/sh


# # you need to have mons installed for this. 

intern=eDP1
extern=HDMI1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto --primary
else
    xrandr --output "$intern" --left-of "$extern" --auto --output "$entern" --primary --auto 
    mons --primary HDMI1
    mons -e left
fi

# case "${SRANDRD_OUTPUT} ${SRANDRD_EVENT}" in
#   "HDMI1 connected") xrandr --output "$intern" --left-of "$extern" --auto --output "$entern" --primary --auto;;
#   "HDMI1 disconnected") xrandr --output "$extern" --off --output "$intern" --auto --primary;;
# esac