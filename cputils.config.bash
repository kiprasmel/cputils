#!/usr/bin/env bash
# $HOME/.config/cputils/cputils.config.bash

open_with_editor() {
	exit 0 # comment out this line and choose your editor if you want to

	# vim "$1"
	# code "$1"
	# geany "$1" &
	# emacs "$1"
	# emacsclient -t $* || { emacs --daemon && emacsclient -t $* } # terminal emacs
}
export -f open_with_editor

INPUT_CACHE_FILE_EXTENSION="txt"
export $INPUT_CACHE_FILE_EXTENSION

