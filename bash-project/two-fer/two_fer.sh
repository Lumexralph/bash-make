#!/usr/bin/env bash

set -f

# To preserve all contiguous whitespaces you have to set the IFS to something different:
# $IFS (Internal Field Separator)
# ref: https://logbuffer.wordpress.com/2010/09/23/bash-scripting-preserve-whitespaces-in-variables/
IFS='%'

two_fer() {
  input="you"

   # check the number of arguments supplied
    if [[ ! (( "$#" = 0 )) ]]; then
        input=$1;
    fi

    echo "One for "$input", one for me."
}

two_fer "$@"
