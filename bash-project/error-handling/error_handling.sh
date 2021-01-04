#!/usr/bin/env bash

error_handling() {
    # check the number of arguments supplied is more than 1 or empty
    if [[ (( "$#" -gt 1 )) || (( "$#" = 0 )) ]]; then
        echo "Usage: error_handling.sh <person>" && exit 1;
    fi

    echo "Hello, $1"
}

# call the function with all the passed arguments
error_handling "$@"
