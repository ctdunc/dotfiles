#!/bin/sh
SCP=$(pgrep -x screenkey)
if [[ -z $SCP ]]; then
	screenkey "$@"
else
	kill $SCP
fi
