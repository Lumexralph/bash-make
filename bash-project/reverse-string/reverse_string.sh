#!/usr/bin/env bash

# This option will make the script exit when there is an error
set -o errexit
# This option will make the script exit when it tries to use an unset variable
set -o nounset
# This option will disable filename expansion using the glob pattern "*"
# OR set -o noglob
set -f

# To preserve all contiguous whitespaces you have to set the IFS to something different:
# $IFS (Internal Field Separator)
# ref: https://logbuffer.wordpress.com/2010/09/23/bash-scripting-preserve-whitespaces-in-variables/
IFS='%'

reverse_string() {
    # get just the first parameter, if you want all the parameters, use $@
    input=$1

    # rev <<< $input (This another approach)
    echo $input | rev
}

reverse_string "$@" # the parameters from the standard input or command line
# run => bats reverse_string_test.sh