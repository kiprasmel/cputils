#!/usr/bin/env bash
# m - as in main.cpp - create a new file from a given (or default) template

USAGE="\
usage: m new_filename.cpp [<options>]

opts:
    -t    use template with test cases (main.t.cpp)
	-y    non-interactive (do not open file with editor etc.)

"

CFGDIR="$HOME/.config/cputils"

OUTFILE="$1"

[ -z "$OUTFILE" ] && {
	printf "$USAGE"
	exit 1
}

case "$2" in
	-t) INFILE="$CFGDIR/template.t.cpp" ;;
	*)  INFILE="$CFGDIR/template.cpp"   ;;
esac

cp -i -v "$INFILE" "$OUTFILE"

case "$3" in 
	-y)
		;;
	*)
		source "$HOME/.config/cputils/cputils.config.bash"
		open_with_editor "$OUTFILE"
		;;
esac
