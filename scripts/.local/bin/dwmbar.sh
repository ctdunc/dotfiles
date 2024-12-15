function dwmbar_date () {
	DATE=$(date "+%R %D")
	printf "%s\n" "$DATE"
}

function dwmbar_battery () {
	# Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
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

SEP1="  "
while true
do
	dispstr="$(dwmbar_backlight)"
	dispstr="$dispstr$SEP1$(dwmbar_battery)"
	dispstr="$dispstr$SEP1$(dwmbar_date)"
	xsetroot -name "$dispstr"
	sleep 2
done
