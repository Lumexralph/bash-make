#!/bin/bash

# allows the user to pick a filename from the current directory, and displays the name and index of the file selected
select fname in *;
do
echo you picked $fname \($REPLY\)
break;
done