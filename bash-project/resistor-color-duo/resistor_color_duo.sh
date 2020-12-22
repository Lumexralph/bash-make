#!/usr/bin/env bash

resistor_color_duo() {
    # declare an hash map
    # ref: https://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash
    declare -A colours
    colours=(
        ["black"]=0
        ["brown"]=1
        ["red"]=2
        ["orange"]=3
        ["yellow"]=4
        ["green"]=5
        ["blue"]=6
        ["violet"]=7
        ["grey"]=8
        ["white"]=9
        )

    # check for invalid colour
    if [[ ! ${colours["$1"]} || ! ${colours["$2"]} ]]; then
        echo "invalid color" && exit 1;
    fi

    echo "${colours["$1"]}${colours["$2"]}"

    # another longer solution using switch and for loop
    # using switch statement
    # case EXPRESSION in

    # PATTERN_1)
    #     STATEMENTS
    #     ;;

    # PATTERN_2)
    #     STATEMENTS
    #     ;;

    # PATTERN_N)
    #     STATEMENTS
    #     ;;

    # *)
    #     STATEMENTS
    #     ;;
    # esac

    # result=

    # for i in "$1" "$2"
    #     do
    #         case $i in

    #         black)
    #             result+=0
    #             ;;

    #         brown)
    #             result+=1
    #             ;;

    #         red)
    #            result+=2
    #             ;;

    #         orange)
    #             result+=3
    #             ;;

    #         yellow)
    #            result+=4
    #             ;;

    #         green)
    #             result+=5
    #             ;;

    #         blue)
    #             result+=6
    #             ;;

    #         violet)
    #             result+=7
    #             ;;

    #         grey)
    #             result+=8
    #             ;;

    #         white)
    #            result+=9
    #             ;;
    #         esac
    # done
}

resistor_color_duo "$@"
