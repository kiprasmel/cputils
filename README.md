# cputils

<!-- CLI utilities for competitive programmers -->
competitive programming utilities

## Installation

```sh
git clone https://github.com/kiprasmel/cputils.git
# or:  git clone git@github.com:kiprasmel/cputils.git

cd cputils

sudo cp -v cputils d i m p cfgen "/usr/local/bin/"

CPUTILS_CONFIG_DIR="$HOME/.config/cputils"
mkdir -p                     "$CPUTILS_CONFIG_DIR"
cp -v -n template*.cpp       "$CPUTILS_CONFIG_DIR/" # -n for no overwriting
cp -v -n cputils.config.bash "$CPUTILS_CONFIG_DIR/" # -n for no overwriting

chmod +x "$CPUTILS_CONFIG_DIR/cputils.config.bash"

```

## Usage

```sh
cputils [m|d|p|cfgen] [ARGS...]
```

## Enhancements

- for extra speed create an alias in i.e. `.bashrc` / `.zshrc` (replace `x` with whatever alias you want):

```sh
x() {
	cputils $*
}
```

- auto-open a file created by `cputils m`:

edit the config file `$HOME/.config/cputils/cputils.config.bash` -- inside the `open_with_editor` function provide a way to open the file `"$1"` with your editor:

```sh
#!/usr/bin/env bash
# cputils.config.bash

# ...

open_with_editor() {
	exit 0 # comment out this line and choose your editor if you want to

	# vim "$1"
	# geany "$1" &
	# code "$1"
}
export -f open_with_editor

# ...
```

- customize file templates for `cputils m`:

```sh
cd "$HOME/.config/cputils"
```

and overwrite the default `template.cpp`;

additionally - create other templates named `template.TEMPLATE_NAME.cpp` and use them via `cputils m new_file.cpp -t TEMPLATE_NAME`
