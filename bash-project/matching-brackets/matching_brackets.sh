#!/usr/bin/env bash

matching_brackets() {
    declare -A bracket
    bracket=(
        ["["]=0
        ["{"]=0
        ["("]=0
    )

    # iterate through the string
    input=$1
    for (( i=0; i<${#input}; i++ )); do
        case "${input:$i:1}" in

            "[")
                # the key should be qouted because the token means something to bash
                (( bracket['"["']+=1 ))
                ;;

            "{")
                (( bracket['"{"']+=1 ))
                ;;

            "(")
                (( bracket['"("']+=1 ))
                ;;

            "}")
                if [[ ! ${bracket["{"]} -gt 0 ]]; then
                    echo false && exit;
                fi

                (( bracket['"{"']-=1 ))
                ;;

            "]")
                if [[ ! ${bracket["["]} -gt 0 ]]; then
                    echo false && exit;
                fi

                (( bracket['"["']-=1 ))
                ;;

            ")")
                if [[ ! ${bracket["("]} -gt 0 ]]; then
                        echo false && exit;
                fi

                (( bracket['"("']-=1 ))
                ;;
        esac
    done

    # loop through bracket to find unmatching
    for val in "${bracket[@]}"; do
        if [[ $val -ne 0 ]]; then
            echo false && exit;
        fi
    done

    echo true

}

matching_brackets "$@"
