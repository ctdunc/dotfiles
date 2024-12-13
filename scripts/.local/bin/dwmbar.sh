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

SEP1="  "
SEPLEFT=""
while true
do
	dispstr="$(dwmbar_battery)"
	dispstr="$dispstr$SEP1$(dwmbar_date)"
	xsetroot -name "$dispstr"

	sleep 10
done
