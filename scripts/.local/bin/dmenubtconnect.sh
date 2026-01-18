SELECTED=$(bluetoothctl devices Paired | cut -d' ' -f3 | dmenu "$@" -i -p "Connect BT Device:")
SELECTED_ID=$(bluetoothctl devices Paired | grep "\s$SELECTED$" | cut -d' ' -f2)
echo $SELECTED_ID
bluetoothctl connect $SELECTED_ID
