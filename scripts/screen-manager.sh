#!/bin/bash
grep -q closed /proc/acpi/button/lid/LID/state
if [ $? = 0 ]
then
    echo "closed"
    xrandr --output DisplayPort-0 --mode 2560x1440 --primary --output eDP --off
    xrandr --output DisplayPort-1 --mode 2560x1440 --primary --output eDP --off
    xrandr --output DP-1 --mode 2560x1440 --primary --output eDP --off
else
    echo "open"
    xrandr --output DisplayPort-0 --mode 2560x1440 --primary --above eDP --output eDP --mode 1920x1080
    xrandr --output DisplayPort-1 --mode 2560x1440 --primary --above eDP --output eDP --mode 1920x1080
    xrandr --output DP-1 --mode 2560x1440 --primary --above eDP --output eDP --mode 1920x1080
fi
