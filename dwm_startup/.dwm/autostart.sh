#! /bin/bash

# DWM Status
slstatus &
# Wallpaper
feh --bg-scale ~/Pictures/wallpapers/kanagawa-wave.jpg
# Compositor
picom --config ~/.config/picom/picom.conf &

## TEMP remove tray icons:
killall blueman-applet
