#!/bin/bash

CHANGE_DIR="./ino/contact_printer"
if git diff --cached --name-only | grep --quiet "${CHANGE_DIR}"
then
  echo "none"
  exit 0
fi