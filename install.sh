#!/usr/bin/env bash

sudo cp -v cputils cputils-* "/usr/local/bin/"

mkdir -p                     "$HOME/.config/cputils"
cp -v -n template*.cpp       "$HOME/.config/cputils" # -n for no overwriting
cp -v -n cputils.config.bash "$HOME/.config/cputils" # -n for no overwriting

