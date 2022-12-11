#!/bin/bash

cattedPDFname="${1:?Concatenated PDF filename}"

# make each PDF contain a single bookmark to first page
tempPDF=`mktemp`
for i in *.pdf
do
    bookmarkTitle=`basename "$i" .pdf`
    bookmarkInfo="BookmarkBegin\nBookmarkTitle: $bookmarkTitle\nBookmarkLevel: 1\nBookmarkPageNumber: 1"
    pdftk "$i" update_info <(echo -en $bookmarkInfo) output $tempPDF verbose
    mv $tempPDF "$i"
done

# concatenate the PDFs
pdftk *.pdf cat output "$cattedPDFname" verbose

