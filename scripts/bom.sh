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
DESTINATION="./hardware/${NAME}_BOM.csv"
TOTAL="./hardware/${NAME}_BOM_total.csv"

touch "${DESTINATION}"
touch "${TOTAL}"

DESTINATION=$(realpath "${DESTINATION}")
TOTAL=$(realpath "${TOTAL}")
PRICES=$(realpath "./hardware/prices.csv")
MODULE=""

echo "module,quantity,part,part_id,description" > "${DESTINATION}"

tac "${1}" | while read line; do
    module=$(echo "${line}" | grep 'module ' | grep '(' | grep ')')
    if [[ "${module}" != "" ]]; then
    	MODULE=$(echo "${module}" | xargs | awk '{print $2}' | awk -F'{' '{print $1}')
    fi
    bom=$(echo "${line}" | grep '//' | grep 'BOM' | awk -F'BOM:' '{print $2}'| xargs)
    if [[ "${bom}" != "" ]]; then
    	QUANTITY=$(echo "${bom}" | awk -F',' '{print $1}' | xargs)
    	PART=$(echo "${bom}" | awk -F',' '{print $2}' | xargs)
    	ID=$(echo "${bom}" | awk -F',' '{print $3}' | xargs)
    	DESCRIPTION=$(echo "${bom}" | awk -F',' '{print $4}' | xargs)
    	echo "[${MODULE}] ${QUANTITY}x ${PART} (${ID})"
    	echo "${MODULE},${QUANTITY},${PART},${ID},${DESCRIPTION}" >> "${DESTINATION}"
    fi
done

echo "quantity,part,part_id,price" > "${TOTAL}"
sqlite3 :memory: -cmd '.mode csv' -cmd ".import ${DESTINATION} bom" -cmd ".import ${PRICES} prices"\
  'SELECT SUM(quantity),part,part_id, SUM(quantity) * (COALESCE((SELECT CEIL(prices.price / prices.quantity) FROM prices WHERE prices.part = bom.part LIMIT 1), 0)) as price FROM bom GROUP BY part ORDER BY part DESC;' >> "${TOTAL}"

sqlite3 :memory: -cmd '.mode csv' -cmd ".import ${TOTAL} bom"  -cmd '.mode markdown' \
  "SELECT part as Part, quantity as Qty, CAST(price / 100.00 as MONEY) as 'Cost (USD)' FROM bom ORDER BY part DESC;"

sqlite3 :memory: -cmd '.mode csv' -cmd ".import ${TOTAL} bom" -cmd '.mode markdown' \
  "SELECT 'TOTAL', SUM(quantity), CAST(SUM(price) / 100.00 as MONEY) FROM bom;" | grep -v 'SUM('

sqlite3 :memory: -cmd '.mode csv' -cmd ".import ${TOTAL} bom"\
  "SELECT SUM(quantity), 'TOTAL', 'N/A', SUM(price) FROM bom;" | tr -d '"' >> "${TOTAL}"

NONEFOUND=$(sqlite3 :memory: -cmd '.mode csv' -cmd ".import ${DESTINATION} bom" -cmd ".import ${PRICES} prices" -cmd '.mode column' -cmd '.headers off' \
  'SELECT DISTINCT part FROM bom WHERE part NOT IN (SELECT part FROM prices) ORDER BY part;')

if [[ "${NONEFOUND}" != "" ]]; then
  echo "No price found for the following parts:"
  echo "${NONEFOUND}"
fi