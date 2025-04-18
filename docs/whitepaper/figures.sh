#!/bin/bash

cat README.md | grep '\!\[' | grep '\(\)' | grep -v '..\/img' | awk -F'[' '{print $2}' | awk -F']' '{print "- ", $1}'