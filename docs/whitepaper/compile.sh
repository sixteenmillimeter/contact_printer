#!/bin/bash

set -e

pandoc README.md -o contact_printer_whitepaper.pdf --filter pandoc-citeproc --pdf-engine=pdflatex --template=template.tex