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