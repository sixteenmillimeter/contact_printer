#!/bin/bash

WIDTH=2400
HEIGHT=2000
SCHEME=DeepOcean
IMG=img/contact_printer.png

# setting PART equal to a non-existent module will render the debug layout

openscad -o ${IMG} --colorscheme ${SCHEME} --imgsize ${WIDTH},${HEIGHT} -D "PART=\"DEBUGxxxxxxx\"" scad/contact_printer.scad
convert ${IMG} -resize 1200x1000 -gravity center -extent 1000x700 ${IMG}