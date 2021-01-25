#!/usr/bin/env bash
# $HOME/.config/cputils/cputils.config.bash

open_with_editor() {
	exit 1 # comment out this line and choose your editor if you want to

	# vim "$1"
	# code "$1"
	# geany "$1" &
	# emacs "$1"
	# emacsclient -t $* || { emacs --daemon && emacsclient -t $* } # terminal emacs
}
export -f open_with_editor

#
# create a hash of a source file,
# so that it will not be recompiled
# if nothing has changed
#
create_hash() {
	exit 1 # comment out this line to enable and choose the appropriate method
	
	# printf "$(sha256sum "$1" | awk '{ print $1 }')"
	# printf "$(openssl dgst -sha256 -r "$1" | awk '{ print $1 }')"

	# note: might be different for Mac, see https://stackoverflow.com/a/20217018/9285308
}
export -f create_hash

INPUT_CACHE_FILE_EXTENSION="txt"
export $INPUT_CACHE_FILE_EXTENSION

