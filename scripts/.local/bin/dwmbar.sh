function dwmbar_date {
	DATE=$(date "+%R %Z %D")
	printf "%s\n" "$DATE"
}

function dwmbar_battery {
	CHARGE=$(cat /sys/class/power_supply/BAT1/capacity)
	STATUS=$(cat /sys/class/power_supply/BAT1/status)

	if [ "$STATUS" = "Charging" ]; then
	    printf "󰂄 %s%%" "$CHARGE"
	elif [ "$STATUS" = "Discharging" ]; then
	    printf "󱧥 %s%%" "$CHARGE"
	else
	    printf "󱟢 %s%%" "$CHARGE"
	fi
	printf "\n"
}

function dwmbar_backlight {
	# depends on acpilight https://wiki.archlinux.org/title/Backlight
	# TODO test this with multiple monitors
	PCT_BRIGHTNESS=$(xbacklight -ctrl amdgpu_bl2 -get)
	printf "%s 󰳲" "$PCT_BRIGHTNESS"
}

function dwmbar_wifi_status { 
	# TODO test this with failing connection, captive portal logins. What are the possible statuses?
	WIFI_STATUS=$(wpa_cli status | grep '^id_str' | cut --delimiter='=' --fields 2)
	if [ -z $WIFI_STATUS ]; then
		WIFI_SYMBOL="󱛅"
	else
		WIFI_SYMBOL="󰖩"
	fi
	printf "%s %s" "$WIFI_STATUS" "$WIFI_SYMBOL"
}

function dwmbar_bluetooth_audio {
	for DEVICE in $(bluetoothctl devices Connected | cut -d' ' -f2);
	do 
		# TODO clean this up and handle other audio output devices? 
		# Is there a nice way to tell what the output device is/whether it's 
		# bluetooth or what?
		DEVICE_IS_AUDIO=$(bluetoothctl info $DEVICE | grep '^\s*Icon: audio')
		if ! [[ -z $DEVICE_IS_AUDIO ]]; then
			DEVICE_NAME=$(bluetoothctl info $DEVICE | grep '^\s*Name' | cut -d' ' -f2)
			printf "%s 󰗾" "$DEVICE_NAME"
			exit 0
		fi
	done
	printf "󰗿"
}

function dwmbar_weather {
	JSON=$(cat ~/.cache/weather/current.json)
	if ! [[ -z $JSON ]]; then
		WEATHER_SYMBOL=$(grep "^$(echo $JSON | jq '.weather[0].id')" ~/.local/bin/icons.txt | cut -f4 -d'	')
		echo "$(echo $JSON | jq '(((.main.temp -273.15) * 1.8) + 32) * 100 | round / 100')$WEATHER_SYMBOL"
	else
		printf "no weather found"
	fi
}

SEP1="  "
while true
do
	dispstr="$(dwmbar_weather)"
	dispstr="$dispstr$SEP1$(dwmbar_wifi_status)"
	dispstr="$dispstr$SEP1$(dwmbar_bluetooth_audio)"
	dispstr="$dispstr$SEP1$(dwmbar_backlight)"
	dispstr="$dispstr$SEP1$(dwmbar_battery)"
	dispstr="$dispstr$SEP1$(dwmbar_date)"
	xsetroot -name "$dispstr"
	sleep 2
done
