#!/bin/bash

echo -n "Enter the name of animal: "
read ANIMAL
echo -n "The $ANIMAL has "

# If the ‘;;’ operator is used, no subsequent matches are attempted after the first pattern match
# ‘;&’ in place of ‘;;’ causes execution to continue with the command-list associated with the next clause, if any
# Using ‘;;&’ in place of ‘;;’ causes the shell to test the patterns in the next clause, if any, and execute any
# associated command-list on a successful match, continuing the case statement execution as if the pattern list had not matched.
case $ANIMAL in
  horse | dog | cat ) echo -n "four ";;
  man | kangaroo ) echo -n "two ";;
esac
echo "legs."

## Shell Expansion
### Brace Expansion
echo a{b, c, d}e # abe, ace, ade, in no particular order

echo {1..9} # count from 1 - 9, 1 2 3 4 5 6 7 8 9
echo {1..9..2} # count from 1 - 9, 1 3 5 7 9 - increment by 2
touch {type1,type2}.sh # will create 2 files - type1.sh and type2.sh
mkdir /usr/local/src/bash/{old,new,dist,bugs}

### Tilde Expansion

