#!/bin/bash

#####################################################################################
## ARITHMETIC EXPANSION
#####################################################################################
# Arithmetic expansion allows the evaluation of an arithmetic expression and the substitution of the result
#
# $(( expression ))
#
# The expression is treated as if it were within double quotes, but a double quote inside the parentheses is not treated specially.
# All tokens in the expression undergo parameter and variable expansion, command substitution, and quote removal.

# id++ id--
# variable post-increment and post-decrement

# ++id --id
# variable pre-increment and pre-decrement

# - +
# unary minus and plus

# ! ~
# logical and bitwise negation

# **
# exponentiation

# * / %
# multiplication, division, remainder

# + -
# addition, subtraction

# << >>
# left and right bitwise shifts

# <= >= < >
# comparison

# == !=
# equality and inequality

# &
# bitwise AND

# ^
# bitwise exclusive OR

# |
# bitwise OR

# &&
# logical AND

# ||
# logical OR

# expr ? expr : expr
# conditional operator

# = *= /= %= += -= <<= >>= &= ^= |=
# assignment

# expr1 , expr2
# comma

main() {
    a=$1
    b=$2
    result=$(( $a * $b ))
    echo $result
}

main "$@"

# chmod +x file.sh - make it executable
# ./arithmetic_expansion.sh 10 20