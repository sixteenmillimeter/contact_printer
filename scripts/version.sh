#! /bin/bash

VERSION_FILE="./VERSION.txt"
SOURCE_FILE="./ino/contact_printer/contact_printer.ino"
CURRENT=`cat "${VERSION_FILE}"`
DATESTR=`date +"%Y%m%d"`
IFS="."
read -ra VERSION <<< "${CURRENT}"
IFS=" "

if [[ "${1}" == "major" ]]; then
  let "VERSION[0]=${VERSION[0]}+1"
  let "VERSION[1]=0"
  let "VERSION[2]=0"
elif [[ "${1}" == "minor" ]]; then
  let "VERSION[1]=${VERSION[1]}+1"
  let "VERSION[2]=0"
else
  let "VERSION[2]=${VERSION[2]}+1"
fi

V="${VERSION[0]}.${VERSION[1]}.${VERSION[2]}"

#echo "{ \"version\" : \"$V\", \"bin\" : \"/bin/contact_printer.bin\", \"date\" : $DATESTR }" > ./ota.json
VERSION_UPDATE=`sed "s/.*define VERSION.*/ #define VERSION \"${V}\"/" "${SOURCE_FILE}"`
echo "${VERSION_UPDATE}" > "${SOURCE_FILE}"

echo $V > "${VERSION_FILE}"
echo $V