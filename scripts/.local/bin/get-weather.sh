#!/bin/bash
WEATHER_LOCATIONS=~/.config/weather/locations
WEATHER_CACHE=~/.cache/weather
WEATHER_ICONS=~/.local/bin/icons.txt
APPNAME="Weather"
rm $WEATHER_CACHE/*.json
function fetch_weather {
	LAT=$1
	LON=$2
	LOCATION=$3
	JSON=$(curl "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$OWM_API_KEY")

	STATUS_CODE=$(echo $JSON | jq '.cod')

	if [[ $ERR_CODE -ge 400 ]]; then
		MESSAGE=$(echo $JSON | jq '.message')
		notify-send "Failed to fetch weather for: $LOCATION." "Error Code: $STATUS_CODE" "Message: $MESSAGE" -a $APPNAME
		exit 1
	else	
		notify-send "Refreshed weather for $LOCATION."
		echo $JSON > "$WEATHER_CACHE/$LOCATION.json"
	fi
}

while IFS= read -r line; do
	LOCATION=$(echo $line | cut -f1 -d' ')
	LAT=$(echo $line | cut -f3 -d' ')
	LON=$(echo $line | cut -f4 -d' ')
	
	echo $(fetch_weather $LAT $LON $LOCATION)
done < <(grep ^[^#] $WEATHER_LOCATIONS)
