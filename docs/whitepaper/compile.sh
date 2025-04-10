#!/bin/bash

set -e

DATESTR=$(date -r README.md "+%Y-%m-%d")

pandoc README.md -o contact_printer_whitepaper.pdf -f markdown-implicit_figures --filter pandoc-citeproc --pdf-engine=pdflatex --template=template.tex