# cputils

<!-- CLI utilities for competitive programmers -->
competitive programming utils

## Installation

```sh
git clone https://github.com/kiprasmel/cputils.git
# or:  git clone git@github.com:kiprasmel/cputils.git

cd cputils

sudo cp -v cputils cputils-* "/usr/local/bin/"

mkdir -p                     "$HOME/.config/cputils"
cp -v -n template*.cpp       "$HOME/.config/cputils" # -n for no overwriting
cp -v -n cputils.config.bash "$HOME/.config/cputils" # -n for no overwriting

```

## Usage

```console
cputils COMMAND [COMMAND_ARGS...]

COMMAND:
        new        - new file from template      (alias n)
        run DEBUG  - run in debug           mode (alias cputils d)
        run EVAL   - run in eval/production mode (alias p)
        cfgen      - codeforces generator from template
	

see individual commands for details

```

## Enhancements

- for extra speed create an alias in i.e. `.bashrc` / `.zshrc` (replace `x` with whatever alias you want):

```sh
x() {
	cputils $*
}
```

- auto-open a file created by `cputils new`:

edit the config file `~/.config/cputils/cputils.config.bash` -- inside the `open_with_editor` function provide a way to open the file `"$1"` with your editor:

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

- customize file templates for `cputils new`:

```sh
cd "$HOME/.config/cputils/"
```

and overwrite the default `template.cpp`;

additionally - create other templates named `template.TEMPLATE_NAME.cpp` and use them via `cputils new file.cpp -t TEMPLATE_NAME`

