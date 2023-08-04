#!/bin/bash

if [ -t 0 ] ; then 
  FMT="%l:+%c+%t"
else
  FMT="+%c+%t"
fi

WTTR="$(curl -s -m 1 wttr.in/?format=$FMT)"
if [ ! -z "$WTTR" ]; then
  echo "$WTTR"
  exit 0
fi

INFO="$(curl -s -m 1 ipinfo.io? | jq -r '. | "\(.ip),\(.city),\(.region),\(.country),\(.loc),\(.postal),\(.timezone)"')"
if [ ! -z "$INFO" ]; then
  # echo $INFO
  IFS=, read -r IP CITY REGION COUNTRY LAT LON POSTAL TIMEZ <<< "$INFO"
else
  LAT=48.783619
  LON=2.442819
fi

APIKEY="65516a9d206dcb56f4ea13de7f46eaf2"
QUERY="https://api.openweathermap.org/data/2.5/weather?lat="$LAT"&lon="$LON"&appid="$APIKEY"&units=metric"
WEATHER_JSON=$(curl -Ls -m 1 "$QUERY")
if [ $? -ne 0 ];then
  exit 0
fi

WEATHER_TEXT=$(jq -r '.weather | .[0] | .description' - <<<"$WEATHER_JSON" | xargs);
WEATHER_ICON_CODE=$(jq -r '.weather | .[0] | .icon' - <<<"$WEATHER_JSON" | xargs);
WEATHER_TEMPERATURE=$(jq -r '.main | .temp' - <<<"$WEATHER_JSON" | cut -d '.' -f 1 | xargs);
if   [ "$WEATHER_ICON_CODE" == "01d" ]; then WEATHER_SYMBOL="☼"; elif [ "$WEATHER_ICON_CODE" == "01n" ]; then WEATHER_SYMBOL="☾";
elif [ "$WEATHER_ICON_CODE" == "02d" ]; then WEATHER_SYMBOL="⛅";elif [ "$WEATHER_ICON_CODE" == "02n" ]; then WEATHER_SYMBOL="☁";
elif [ "$WEATHER_ICON_CODE" == "03d" ]; then WEATHER_SYMBOL="☁"; elif [ "$WEATHER_ICON_CODE" == "03n" ]; then WEATHER_SYMBOL="☁";
elif [ "$WEATHER_ICON_CODE" == "04d" ]; then WEATHER_SYMBOL="☁"; elif [ "$WEATHER_ICON_CODE" == "04n" ]; then WEATHER_SYMBOL="☁";
elif [ "$WEATHER_ICON_CODE" == "09d" ]; then WEATHER_SYMBOL="☔"; elif [ "$WEATHER_ICON_CODE" == "09n" ]; then WEATHER_SYMBOL="☔";
elif [ "$WEATHER_ICON_CODE" == "10d" ]; then WEATHER_SYMBOL="☂"; elif [ "$WEATHER_ICON_CODE" == "10n" ]; then WEATHER_SYMBOL="☂";
elif [ "$WEATHER_ICON_CODE" == "11d" ]; then WEATHER_SYMBOL="⚡"; elif [ "$WEATHER_ICON_CODE" == "11n" ]; then WEATHER_SYMBOL="⚡";
elif [ "$WEATHER_ICON_CODE" == "13d" ]; then WEATHER_SYMBOL="❄"; elif [ "$WEATHER_ICON_CODE" == "13n" ]; then WEATHER_SYMBOL="❄";
elif [ "$WEATHER_ICON_CODE" == "50d" ]; then WEATHER_SYMBOL="⛆";elif [ "$WEATHER_ICON_CODE" == "50n" ]; then WEATHER_SYMBOL="⛆";
# if unknown icon, set text instead of symbol
else WEATHER_SYMBOL="$WEATHER_TEXT";
fi

if [ -t 0 ] ; then 
  # if run from shell
  echo "$CITY, $COUNTRY: $WEATHER_SYMBOL"" ""$WEATHER_TEMPERATURE""°C";
else
  echo "$WEATHER_SYMBOL"" ""$WEATHER_TEMPERATURE""°C";
fi

exit 0;
