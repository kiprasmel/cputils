#!/usr/bin/env bash

# https://stackoverflow.com/a/24112741/9285308
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

case "$1" in
	-|-a|--all)
		shift
		"$REPO_ROOT"/bats-core/bin/bats "$REPO_ROOT"/test/ $*
		;;

	-f|--file)
		shift
		FILE="$1"
		shift

		[ ! -f "$FILE" ] && {
			printf "cputils test.sh: file does not exist ($FILE)\n"
			exit 1
		}

		"$REPO_ROOT"/bats-core/bin/bats "$FILE" $*
		;;

	*)
		"$REPO_ROOT"/bats-core/bin/bats $*
		;;

esac

