#!/bin/bash
pkill -f pasystray
pkill -f nm-applet
pkill -f megasync
pkill -f blueman-applet

pasystray --notify=all &
megasync &
nm-applet --indicator &
blueman-applet &
