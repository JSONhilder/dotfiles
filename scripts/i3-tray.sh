#!/bin/bash
pkill -f pasystray
pkill -f blueman-applet
pkill -f nm-applet
pkill -f megasync

pasystray --notify=all &
blueman-applet &
megasync &
nm-applet --indicator &
