function dwmbar_date () {
	DATE=$(date "+%R %Z %D")
	printf "%s\n" "$DATE"
}

function dwmbar_battery () {
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

function dwmbar_backlight () {
	# depends on acpilight https://wiki.archlinux.org/title/Backlight
	# TODO test this with multiple monitors
	PCT_BRIGHTNESS=$(xbacklight -ctrl amdgpu_bl2 -get)
	printf "%s 󰳲" "$PCT_BRIGHTNESS"
}

function dwmbar_wifi_status () { 
	# TODO test this with failing connection, captive portal logins. What are the possible statuses?
	WIFI_STATUS=$(wpa_cli status | grep '^id_str' | cut --delimiter='=' --fields 2)
	if [ -z $WIFI_STATUS ]; then
		WIFI_SYMBOL="󱛅"
	else
		WIFI_SYMBOL="󰖩"
	fi
	printf "%s %s" "$WIFI_STATUS" "$WIFI_SYMBOL"
}

function dwmbar_bluetooth_audio () {
	for DEVICE in $(bluetoothctl devices Connected | cut -d' ' -f2);
	do 
		# here's a complete list of possibilities
		DEVICE_IS_AUDIO=$(bluetoothctl info $DEVICE | grep '^\s*Icon: audio')
		if ! [[ -z $DEVICE_IS_AUDIO ]]; then
			DEVICE_NAME=$(bluetoothctl info $DEVICE | grep '^\s*Name' | cut -d' ' -f2)
			printf "%s 󰗾" "$DEVICE_NAME"
			exit 0
		fi
	done
	printf "󰗿"
}
SEP1="  "
while true
do
	dispstr="$(dwmbar_wifi_status)"
	dispstr="$dispstr$SEP1$(dwmbar_bluetooth_audio)"
	dispstr="$dispstr$SEP1$(dwmbar_backlight)"
	dispstr="$dispstr$SEP1$(dwmbar_battery)"
	dispstr="$dispstr$SEP1$(dwmbar_date)"
	xsetroot -name "$dispstr"
	sleep 2
done
