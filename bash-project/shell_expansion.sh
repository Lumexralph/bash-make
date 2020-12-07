#!/bin/bash

############ Shell Expansion

### Brace Expansion

# A sequence expression takes the form {x..y[..incr]}, where x and y are either integers or single characters, and incr, an optional increment, is an integer.

echo a{b, c, d}e # abe, ace, ade, in no particular order

echo {1..9} # count from 1 - 9, 1 2 3 4 5 6 7 8 9
echo {1..9..2} # count from 1 - 9, 1 3 5 7 9 - increment by 2

# Supplied integers may be prefixed with ‘0’ to force each term to have the same width.
echo {01..9} # 01 02 03 04 05 06 07 08 09, zero-padding where necessary

# can be used for characters too in lexicographic order
echo {a..p} # a b c d e f g h i j k l m n o p

touch {type1,type2}.sh # will create 2 files - type1.sh and type2.sh

mkdir /usr/local/src/bash/{old,new,dist,bugs}

chown root /usr/{ucb/{ex,edit},lib/{ex?.?*,how_ex}}

##########################################################
# Tilde Expansion (~)
##########################################################

# If this login name is the null string, the tilde is replaced with the value of the HOME shell variable.
# If HOME is unset, the home directory of the user executing the shell is substituted instead.
# Otherwise, the tilde-prefix is replaced with the home directory associated with the specified login name.

# If the tilde-prefix is ‘~+’, the value of the shell variable PWD replaces the tilde-prefix
# If the tilde-prefix is ‘~-’, the value of the shell variable OLDPWD, if it is set, is substituted

# ~ ==> The value of $HOME
# ~/foo ==> $HOME/foo
# ~+/foo ==> $PWD/foo
# ~N ==> The string that would be displayed by ‘dirs +N’
# ~+N ==> The string that would be displayed by ‘dirs +N’
# ~-N ==> The string that would be displayed by ‘dirs -N’

##########################################################
# Shell Parameter Expansion
##########################################################
