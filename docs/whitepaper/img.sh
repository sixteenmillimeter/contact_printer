#!/bin/bash

if [[ -z "${1}" ]]; then
	echo "Please include a file as the first argument"
	exit 1
fi

if [[ ! -f "${1}" ]]; then
	echo "File ${1} doesn't exist"
	exit 2
fi

INCHWIDTH=5.5

if [[ ! -z "${2}" ]]; then
	INCHWIDTH=${2}
fi

WIDTH=$(identify -ping -format '%w' "${1}")
HEIGHT=$(identify -ping -format '%h' "${1}")

INCHHEIGHT=$(echo "scale=2;${HEIGHT}/(${WIDTH}/${INCHWIDTH})" | bc)

echo "HEIGHT: ${INCHHEIGHT}in"