#!/bin/bash
exiftool '-filename<${datetimeoriginal}_$filename' -d "%Y-%m-%d_%H.%M.%S%%-c" *.JPG
exiftool '-filename<${datetimeoriginal}_$filename' -d "%Y-%m-%d_%H.%M.%S%%-c" *.jpg

find -iname "*.jpg" -o -iname "*.jpeg" | while read f; do
  LAT="$(exiftool -coordFormat '%.4f' "$f"|egrep 'Latitude\s+:'|cut -d\  -f 23)"
  if [ -z "$LAT" ]; then 
    echo "$f : no geo coordinates";
  else
    LON="$(exiftool -coordFormat '%.4f' "$f"|egrep 'Longitude\s+:'|cut -d\  -f 22)"
    URL='http://nominatim.openstreetmap.org/reverse?format=xml&lat='$LAT'&lon='$LON'&zoom=18&addressdetails=1'
    RES="$(curl -s "$URL"|egrep "<(city|village|town|ruins|state_district|country)")"
    LOC="$(echo "$RES"|grep '<city>'|sed 's/^.*<city>//g'|sed 's/<\/city>.*$//g')"
    [ -z "$LOC" ] &&  LOC="$(echo "$RES"|grep '<city_district>'|sed 's/^.*<city_district>//g'|sed 's/<\/city_district>.*$//g')"
    [ -z "$LOC" ] &&  LOC="$(echo "$RES"|grep '<village>'|sed 's/^.*<village>//g'|sed 's/<\/village>.*$//g')"
    [ -z "$LOC" ] &&  LOC="$(echo "$RES"|grep '<town>'|sed 's/^.*<town>//g'|sed 's/<\/town>.*$//g')"
    [ -z "$LOC" ] &&  LOC="$(echo "$RES"|grep '<state_district>'|sed 's/^.*<state_district>//g'|sed 's/<\/state_district>.*$//g')"
    [ -z "$LOC" ] &&  LOC="$(echo "$RES"|grep '<country>'|sed 's/^.*<country>//g'|sed 's/<\/country>.*$//g')"
    if [ -z "$LOC" ]; then
      echo "no city found at $URL";
    else 
      BASE="${f%.*}"
      mv -v "$f" "$BASE-$LOC.JPG"
    fi
  fi
done

ls -1|cut -d- -f 4|sort|uniq -c|sort -n

