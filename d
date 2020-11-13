#!/usr/bin/env bash
# d - develop in debug mode (defines "DEBUG")

[ -z "$1" ] && {
	printf "usage: d filename.cpp\n\n"
	exit 1
}

# INPUT_FROM_CLIPBOARD="$(xclip -selection primary -o || xclip -selection clipboard -o)"
INPUT_FROM_CLIPBOARD="$(xclip -selection clipboard -o || xclip -selection primary -o)"

INPUT_CACHE_FILE="$1.in"
touch "$INPUT_CACHE_FILE"
INPUT_FROM_CACHE_FILE="$(cat $INPUT_CACHE_FILE)"

if [ -z "$2" ]; then
	WHICH_INPUT_USED="CLIPBOARD"
	INPUT="$INPUT_FROM_CLIPBOARD"

	# prepend the input from clipboard into the cache file
	mv "$INPUT_CACHE_FILE" "$INPUT_CACHE_FILE.bp"
	printf "$INPUT\n\n\n" >> "$INPUT_CACHE_FILE"
	cat "$INPUT_CACHE_FILE.bp" >> "$INPUT_CACHE_FILE"
	rm "$INPUT_CACHE_FILE.bp"
elif [ -z "$3" ]; then
	WHICH_INPUT_USED="FILE ($INPUT_CACHE_FILE)"

	INPUT="$INPUT_FROM_CACHE_FILE"

	# do not prepend the input
else
	WHICH_INPUT_USED="FILE ($3)"

	INPUT_FROM_CUSTOM_FILE="$(cat $3)"
	INPUT="$INPUT_FROM_CUSTOM_FILE"
fi

printf "BEGIN INPUT\n$INPUT\nEND INPUT\n"
printf "$WHICH_INPUT_USED\n\n"


g++ -std=c++17 "$1" -Wall -DDEBUG && printf "$INPUT\n" | (time ./a.out)
