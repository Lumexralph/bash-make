#!/usr/bin/env bash

validate_input() {
     # check the number of arguments supplied
    if [[ (( "$#" = 0 )) || (( "$#" -gt 1 )) ]]; then
        return 1;

    # input should not be alphanumeric, the input will be seen as a string
    # an extra check needs to be done to make sure it's not
    elif [[ "$1" =~ ^[[:alnum:]]*$ ]] && [[ ! "$1" =~ ^[[:digit:]]+$ ]]; then
        return 1;

    # check if input is a float
    elif [[ ! "$1" =~ ^[+-]?[0-9]*$  ]]; then
        return 1;
    fi

}

# on every year that is evenly divisible by 4
#   except every year that is evenly divisible by 100
#     unless the year is also evenly divisible by 400
leap_year() {
    # checks
    validate_input "$@"

    # get the exit status of the last function or command that ran
    local status=$?

    if [[ $status -ne 0 ]]; then
        echo "Usage: leap.sh <year>" && exit 1;
    fi

    input=$1

    if [[ $(( input % 4 )) = 0 ]]; then

        if [[ $(( input % 100 )) = 0 ]]; then

            if [[ $(( input % 400 )) = 0 ]]; then

                echo "true"

            else echo "false"

            fi
        else
            echo "true"
        fi

    else
        echo "false"

    fi
}

leap_year "$@"