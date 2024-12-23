wpa_cli scan;
 SCAN_RESULTS=$(wpa_cli scan_results | tail -n+2)
#SSID=$(wpa_cli scan_results | cut -sf5,2 --output-delimiter=";" | sort --reverse | dmenu -i -p "Select Network" -l 20)
SSID=$(wpa_cli scan_results | cut -sf5 | sort | uniq | dmenu -i -p "Select Network" -l 20)
wpa_cli scan_results | grep "$SSID" | awk -F"\t" '{print $2 " " $1 " " $5}'| sort | head -n1
# wpa_cli scan_results | grep "$SSID"
