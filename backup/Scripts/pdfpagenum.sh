#/bin/bash

if [ $# -lt 2 ]; then
    echo "Add page numbers to a pdf file."
    echo "usage: $(basename $0) input-file output-file"
    exit 1
fi

inputfile="$1"
outputfile="$2"
fontfamily="Times"
fontcolor="12538a"
fontcolor="000000"
fontsize="10"
hoffset="50" # workaround for center positioning bug
voffset="30" # distance from the bottom of the page

fontcolor="$(echo "$fontcolor" | tr 'a-z' 'A-Z')"
red="$(echo "scale=6; ibase=16; x=$(echo "$fontcolor" | cut -c1-2)/FF; if (x<1) print 0; x" | bc)"
green="$(echo "scale=6; ibase=16; x=$(echo "$fontcolor" | cut -c3-4)/FF; if (x<1) print 0; x" | bc)"
blue="$(echo "scale=6; ibase=16; x=$(echo "$fontcolor" | cut -c5-6)/FF; if (x<1) print 0; x" | bc)"
totalpages="$(pdftk "$inputfile" data_dump | sed -r "s|^NumberOfPages: (.*)|\1|;t;d")"
dim=$(pdftk "$inputfile" data_dump | egrep -m 1 "^PageMediaDimensions:")
set - $dim; index=0; while [ "$1" ]; do let index=$index+1; eval var${index}="$1"; shift; done
width=$var2
height=$var3
#center="$(echo "scale=0; $width / 2 - $hoffset" | bc)"
center="$(echo "scale=0; $width / 1 - $hoffset" | bc)"
width10="$(echo "scale=0; 10.0 * $width / 1" | bc)"
height10="$(echo "scale=0; 10.0 * $height / 1" | bc)"

gs -q -o - -sDEVICE=pdfwrite -g${width10}x${height10} -c "/${fontfamily} findfont ${fontsize} scalefont setfont 1 1 ${totalpages} { $red $green $blue setrgbcolor /PageNo exch def PageNo 2 string cvs dup stringwidth pop 0.5 mul ${center} exch sub ${voffset} moveto show ( / ${totalpages}) show showpage } for" | \
pdftk "$inputfile" multistamp - output - | pdftk - cat output "$outputfile"

