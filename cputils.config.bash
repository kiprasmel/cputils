#!/usr/bin/env bash
# cputils.config.bash

open_with_editor() {
	exit 0 # comment out this line and choose your editor if you want to

	# vim "$1"
	# geany "$1" &
	# code "$1"
}
export -f open_with_editor
