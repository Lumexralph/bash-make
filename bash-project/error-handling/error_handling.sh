#!/usr/bin/env bash

error_handling() {
    # check the number of arguments supplied is not more than 1 or empty
    if ! (( "$#" == 1 )); then
        echo "Usage: error_handling.sh <person>"
        return 1
    fi

    echo "Hello, $1"
    return 0
}

# call the function with all the passed arguments
error_handling "$@"
