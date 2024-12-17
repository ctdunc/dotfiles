SELECTED=$(bluetoothctl devices Connected | cut -d' ' -f3 | dmenu "$@" -i -p "Disconnect BT Device:")
SELECTED_ID=$(bluetoothctl devices Connected | grep "\s$SELECTED$" | cut -d' ' -f2)
bluetoothctl disconnect $SELECTED_ID
