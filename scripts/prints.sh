#!/bin/bash

if [[ "${1}" == "" ]]; then
	echo "Please use a .scad file as first argument"
	exit 1
fi

FILENAME=$(basename "${1}" | tr '[:upper:]' '[:lower:]')
EXTENSION="${FILENAME##*.}"

if [[ "${EXTENSION}" != "scad" ]]; then
	echo "Please use a .scad file as first argument, not .${EXTENSION}"
	exit 2
fi

if [[ ! -f "${1}" ]]; then
	echo "File ${1} does not exist"
	exit 3
fi

mkdir -p hardware

NAME="${FILENAME%.*}"
DESTINATION="./hardware/${NAME}_prints.csv"

echo "module,quantity,stl" > "${DESTINATION}"

tac "${1}" | while read line; do
    module=$(echo "${line}" | grep 'module ' | grep '(' | grep ')')
    if [[ "${module}" != "" ]]; then
    	MODULE=$(echo "${module}" | xargs | awk '{print $2}' | awk -F'{' '{print $1}')
      MODULE=$(echo "${MODULE}" | sed "s/^$NAME//")
      MODULE=$(echo "${MODULE}" | sed "s/^_//")
    fi
    qty=$(echo "${line}" | grep ^'//' | grep 'PRINT' | awk -F'PRINT:' '{print $2}'| xargs)
    if [[ "${qty}" != "" ]]; then
    	QUANTITY="${qty}"
    	echo "[${MODULE//_/ }] ${QUANTITY}x"
    	echo "${MODULE//_/ },${QUANTITY},stl/${NAME}_${MODULE}.stl" >> "${DESTINATION}"
    fi
done

sqlite3 :memory: -cmd '.mode csv' -cmd ".import ${DESTINATION} prints" -cmd '.mode markdown' \
  "SELECT module as 'Part', quantity as 'Print Count', printf( '[%s](%s)', 'STL' , prints.stl ) as 'Download'
  FROM prints;"