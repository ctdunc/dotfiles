#!/bin/sh
echo "hi"
PANE_PATH=$(tmux display-message -p -F "#{pane_current_path}")
cd $PANE_PATH

git_changes() {
	local changes=$(git diff --shortstat | sed -E -e 's/[^0-9|,]//g' | awk -F"," '{print "~"$1"  +"$2"  -"$3}')
	local untracked=$(git status --porcelain 2>/dev/null | grep -c "^??")
	echo $changes  ?$untracked
}

git_changes
