BRIGHTNESS=$(dmenu "$@" -p "Brightness" < /dev/null)
xbacklight -ctrl amdgpu_bl2 -set $BRIGHTNESS
