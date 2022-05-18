#!/bin/bash
echo "Name New Window: "
read _name

tmux new-window -n $_name
