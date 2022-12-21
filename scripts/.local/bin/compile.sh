#!/bin/bash
ARGS=""
for user in "$@" 
do
    ARGS+="${user} "   
done

# Check if rust project
FILE=./Cargo.toml
if test -f "$FILE"; then
    cargo run $ARGS
else
    echo "not a rust project"
fi
