#!/bin/bash
grep -q closed /proc/acpi/button/lid/LID/state
if [ $? = 0 ]
then
    echo "closed"
    xrandr --output eDP --off
    xrandr --output DisplayPort-0 -s 2560x1440 --primary
else
    echo "open"
    xrandr --output eDP --auto
    xrandr --output DisplayPort-0 -s 2560x1440 --primary --above eDP
fi
