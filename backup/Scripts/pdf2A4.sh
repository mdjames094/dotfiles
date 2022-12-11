#!/bin/bash

mkdir A4

for f in *.pdf 
  do 
    i="./A4/${f%%.*}_A4.pdf"
    gs -sDEVICE=pdfwrite -sPAPERSIZE=a4 -dPDFFitPage -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${i}" "$f"
  done
