#!/usr/bin/env bash

sudo mkdir -p                "/usr/local/bin/"
sudo cp -v cputils cputils-* "/usr/local/bin/"

mkdir -p                     "$HOME/.config/cputils"
cp -v -n template*.cpp       "$HOME/.config/cputils" # -n for no overwriting
cp -v -n cputils.config.bash "$HOME/.config/cputils" # -n for no overwriting

# completely optional.
# still adding this here
# so the templates work out of the box
sudo mkdir -p   "/usr/local/include/"
curl -LO https://raw.githubusercontent.com/kiprasmel/debug.h/master/debug.h >/dev/null 2>&1 && \
sudo mv debug.h "/usr/local/include/"

