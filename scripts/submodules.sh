#!/bin/bash

echo "Updating all git submodules"

git submodule update --recursive scad/common
git submodule update --recursive scad/takeup
git submodule update --recursive scad/sprocketed_roller