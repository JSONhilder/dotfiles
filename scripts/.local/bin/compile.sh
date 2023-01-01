#!/bin/bash
ARGS=""
for user in "$@" 
do
    ARGS+="${user} "   
done

# Check if rust project
FILE=./Cargo.toml
if test -f "$FILE"; then
    alacritty --hold -e cargo run $ARGS
fi

# Check if node project
FILE=./package.json
if test -f "$FILE"; then
    alacritty --hold -e node $ARGS
fi
