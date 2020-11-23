#!/bin/bash

# allows the user to pick a filename from the current directory, and displays the name and index of the file selected
select fname in *;
do
echo you picked $fname \($REPLY\)
break;
done

# using GNU parallel to run commands in parallel, might have to install it.
{
echo foss.org.my ;
echo debian.org ;
echo freenetproject.org ;
} | parallel -k traceroute # delivers the output in listed order