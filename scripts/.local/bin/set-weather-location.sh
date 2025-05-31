WEATHER_LOCATIONS=~/.config/weather/locations
WEATHER_CACHE=~/.cache/weather
WEATHER_ICONS=~/.local/bin/icons.txt
APPNAME="Weather"

function refresh_weather_cache {
	LAT=$1
	LON=$2
	LOCATION=$3
	notify-send "refreshing weather for: $LOCATION" -A $APPNAME
	JSON=$(curl "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$OWM_API_KEY")
	echo $JSON > "$WEATHER_CACHE/$LOCATION".json
	echo $JSON
}

function get_weather_json_for_named_location {
	LOCATION=$1
	>&2 echo $LOCATION
	if [[ -a $WEATHER_CACHE/$LOCATION.json ]]; then
		JSON=$(cat "$WEATHER_CACHE/$LOCATION".json)
		(( six_hr_ago = $(date +'%s') - 21600 ))
		# if it has been six hours since we last checked, refresh
		if [[ $(echo $JSON | jq '.dt') -lt $SIX_HR_AGO ]]; then 
			LAT=$(echo $JSON | jq '.coord.lat')
			LON=$(echo $JSON | jq '.coord.lon')
			JSON=$(refresh_weather_cache $LAT $LON $LOCATION)
		fi
	else
		LATLON="$(grep ^$LOCATION $WEATHER_LOCATIONS | cut -f 3-4)"
		if [[ -n $LATLON ]]; then
			LAT=$(echo $LATLON | cut -f1 -d' ')
			LON=$(echo $LATLON | cut -f2 -d' ')
			JSON=$(refresh_weather_cache $LAT $LON $LOCATION)
		else
			notify-send "New location search not implemented!" -A $APPNAME
			exit 1
		fi
	fi
	echo $JSON
}


JSON=$(get_weather_json_for_named_location $(grep ^[^#] $WEATHER_LOCATIONS | cut -f 1 | dmenu "$@" -i -p "Select Location" ))
# set the new value to the current weather
echo $JSON > $WEATHER_CACHE/current.json
