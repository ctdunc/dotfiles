WEATHER_LOCATIONS=~/.config/weather/locations
WEATHER_CACHE=~/.cache/weather
WEATHER_ICONS=~/.local/bin/icons.txt
APPNAME="Weather"

function refresh_weather_cache {
	LAT=$1
	LON=$2
	LOCATION=$3
	notify-send "refreshing weather for: $LOCATION" -a $APPNAME
	JSON=$(curl "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$OWM_API_KEY")
	echo $JSON > "$WEATHER_CACHE/$LOCATION".json
	echo $JSON
}

function get_weather_json_for_named_location {
	LOCATION=$1
	# if we have a cache for the location, use that.
	if [[ -a $WEATHER_CACHE/$LOCATION.json ]]; then
		JSON=$(cat "$WEATHER_CACHE/$LOCATION".json)
		(( SIX_HR_AGO = $(date +'%s') - 21600 ))
		# if it has been six hours since we last checked, refresh
		LAST_UPDATED=$(echo $JSON | jq '.dt')
		if [[ "$LAST_UPDATED" -lt "$SIX_HR_AGO" ]]; then 
			LAT=$(echo $JSON | jq '.coord.lat')
			LON=$(echo $JSON | jq '.coord.lon')
			JSON=$(refresh_weather_cache $LAT $LON $LOCATION)
		else
			notify-send "$LOCATION weather last updated at: $(date -d "@$LAST_UPDATED" +'%Y-%m-%d %H:%M:%S')" -a $APPNAME
		fi
	else
		LATLON="$(grep ^$LOCATION $WEATHER_LOCATIONS | cut -f 3-4)"
		if [[ -n $LATLON ]]; then
			LAT=$(echo $LATLON | cut -f1 -d' ')
			LON=$(echo $LATLON | cut -f2 -d' ')
			JSON=$(refresh_weather_cache $LAT $LON $LOCATION)
		else
			notify-send "New location search not implemented!" -a $APPNAME
			exit 1
		fi
	fi
	echo $JSON
}

LOCATION=$(grep ^[^#] $WEATHER_LOCATIONS | cut -f 1 | dmenu "$@" -i -p "Select Location" )
JSON=$(get_weather_json_for_named_location $LOCATION)
LOCATION_SYMBOL=$(grep "^$LOCATION" $WEATHER_LOCATIONS)
if [[ -z $LOCATION_SYMBOL ]]; then
	LOCATION_SYMBOL=$LOCATION
else
	LOCATION_SYMBOL=$(echo $LOCATION_SYMBOL | cut -f2 -d' ')
fi
echo $LOCATION_SYMBOL > $WEATHER_CACHE/current_symbol
# set the new value to the current weather
echo $JSON > $WEATHER_CACHE/current.json
