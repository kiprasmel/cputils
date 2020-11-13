#!/usr/bin/env bash
# p - develop in production mode (defines "EVAL")
# TODO - synchronize with "d" (this is a little outdated)
 
[ -z "$1" ] && {
	printf "usage: p filename.cpp\n\n"
	exit 1
}

INPUT="$(xclip -selection primary -o || xclip -selection clipboard -o)"

printf "BEGIN INPUT\n$INPUT\nEND INPUT\n\n"

TIME_CMD="$(command -v /usr/bin/time && "/usr/bin/time" || "time")"

echo "time cmd $TIME_CMD"

g++ -std=c++17 "$1" -Wall -DEVAL && printf "$INPUT\n" | (time ./a.out)

## g++ "$1" -Wall -DEVAL && cat ./in | (time ./a.out)
