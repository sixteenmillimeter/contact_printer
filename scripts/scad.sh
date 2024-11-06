#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "Building ${green}contact_printer${reset} project..."
#build OpenSCAD models

mkdir -p stl

cat scad/contact_printer.scad | grep "PART ==" | awk -F'==' '{print $2}' | awk -F'"' '{print $2}' | awk -F'"' '{print $1}' | sort > models.txt

while read m; do
	echo "Rendering $m..."
	openscad --export-format=asciistl --enable manifold -o "stl/contact_printer_$m.stl" -D "PART=\"$m\"" scad/contact_printer.scad
	python scad/common/c14n_stl.py "stl/contact_printer_$m.stl"
done < models.txt

bash scripts/bom.sh "./scad/contact_printer.scad"

#run client tests?
