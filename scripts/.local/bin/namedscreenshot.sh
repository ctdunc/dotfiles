FILENAME=$(dmenu "$@" -p "File Name" < /dev/null)
maim -s > ~/screenshots/$FILENAME.png
