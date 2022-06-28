#!/bin/bash

# Check if rust project
FILE=./Cargo.toml
if test -f "$FILE"; then
    ARGS=./compile
    if test -f "$ARGS"; then
        IFS= read -r rust_args <"$ARGS"
        cargo run $rust_args
    else
        cargo run
    fi
else
    echo "not a rust project"
fi
