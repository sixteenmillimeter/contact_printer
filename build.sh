#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "Building ${green}contact_printer${reset} project..."
#build OpenSCAD models

while read m; do
	echo $m
done < models.txt

#run client tests?
