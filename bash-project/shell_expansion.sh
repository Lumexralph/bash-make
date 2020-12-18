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

# The ‘$’ character introduces parameter expansion, command substitution, or arithmetic expansion
# The basic form of parameter expansion is ${parameter}, The value of parameter is substituted.

# ${parameter:−word}
# If parameter is unset or null, the expansion of word is substituted. Otherwise, the value of parameter is substituted.

# ${parameter:=word}
# If parameter is unset or null, the expansion of word is assigned to parameter. The value of parameter is then substituted. Positional parameters and special parameters may not be assigned to in this way.

# ${parameter:?word}
# If parameter is null or unset, the expansion of word (or a message to that effect if word is not present) is written to the standard error and the shell, if it is not interactive, exits. Otherwise, the value of parameter is substituted.

# ${parameter:+word}
# If parameter is null or unset, nothing is substituted, otherwise the expansion of word is substituted.

# ${parameter:offset} ${parameter:offset:length}
# This is referred to as Substring Expansion. It expands to up to length charac- ters of the value of parameter starting at the character specified by offset.

# If length is omitted, it expands to the substring of the value of parameter starting at the character specified by offset and extending to the end of the value.
# If offset evaluates to a number less than zero, the value is used as an offset in characters from the end of the value of parameter.
# If length evaluates to a number less than zero, it is interpreted as an offset in characters from the end of the value of parameter rather than a number of characters,
# and the expansion is the characters between offset and that result.

string=01234567890abcdefgh
echo ${string:7} # => 7890abcdefgh . offset is from 7th character

echo ${string:7:0} # => ""(empty string), Offset is at 7th character but length of 0 character

echo ${string:7:2} # => 78 . Offset is at 7th character but length of 2 characters

echo ${string:7:-2} # => 7890abcdef, Offset is at 7th character but length of -2, removes 2 characters from the right

echo ${string: -7} # => bcdefgh, Offset is a negative value, gets the characters from the right

echo ${string: -7:0} # => ""(empty string), Offset is a negative value, gets the characters from the right but a zero length

echo ${string: -7:2} # => bc, Offset is a negative value, gets the characters from the right but length of 2 characters

echo ${string: -7:-2} # => bcdef, Offset is a negative value, gets the characters from the right but length of -2, removes 2 characters from the right


set -- 01234567890abcdefgh # => I don't know so much what this means but it sets a variable (1) : This is a string

echo ${1:7} # => 7890abcdefgh
echo ${1:7:0} # =>
echo ${1:7:2} # => 78
echo ${1:7:-2} # => 7890abcdef

# Using positional parameters

set -- 1 2 3 4 5 6 7 8 9 0 a b c d e f g h # => This is an array

echo ${@} # => 1 2 3 4 5 6 7 8 9 0 a b c d e f g h

echo ${@:7} # => 7 8 9 0 a b c d e f g h
