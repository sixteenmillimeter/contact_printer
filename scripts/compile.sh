#!/bin/bash

set -e

FQBN=esp32:esp32:esp32 			#ESP32

INO="./ino/contact_printer"
INOFILE="${INO}/contact_printer.ino"
OUTPUT="./bin"

mkdir -p "${OUTPUT}"

#esp32
arduino-cli compile --fqbn ${FQBN} --output-dir "${OUTPUT}" "${INO}" || echo 'Compile failed' && exit 1 
