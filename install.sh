#!/bin/sh

PREFIX="${PREFIX:-/usr/local}"

mkdir -p                "$PREFIX/bin"
cp -v cputils cputils-* "$PREFIX/bin"

mkdir -p                     "$HOME/.config/cputils"
cp -v -n template*.cpp       "$HOME/.config/cputils" # -n for no overwriting
cp -v -n cputils.config.bash "$HOME/.config/cputils" # -n for no overwriting

if test -n "$INSTALL_DEBUGLIB"; then
	mkdir -p   "$PREFIX/include/"
	curl -sLO https://raw.githubusercontent.com/kiprasmel/debug.h/master/debug.h
	mv debug.h "$PREFIX/include/"
fi

