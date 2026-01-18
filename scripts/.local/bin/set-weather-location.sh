WEATHER_LOCATIONS=~/.config/weather/locations
WEATHER_CACHE=~/.cache/weather
WEATHER_ICONS=~/.local/bin/icons.txt
APPNAME="Weather"


LOCATION=$(grep ^[^#] $WEATHER_LOCATIONS | cut -f 1 | dmenu "$@" -i -p "Select Location" )
JSON=$(get_weather_json_for_named_location $LOCATION)
LOCATION_SYMBOL=$(grep "^$LOCATION" $WEATHER_LOCATIONS)
if [[ -z $LOCATION_SYMBOL ]]; then
	LOCATION_SYMBOL=$LOCATION
else
	LOCATION_SYMBOL=$(echo $LOCATION_SYMBOL | cut -f2 -d' ')
fi
echo $LOCATION_SYMBOL > $WEATHER_CACHE/current_symbol
echo $LOCATION > $WEATHER_CACHE/current_location
# set the new value to the current weather
