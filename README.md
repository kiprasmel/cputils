# cputils

<!-- CLI utilities for competitive programmers -->
<u>c</u>ompetitive <u>p</u>rogramming <u>utils</u>

## Installation

[![](https://github.com/kiprasmel/cputils/workflows/full-setup/badge.svg)](https://github.com/kiprasmel/cputils/actions?query=workflow:full-setup+branch:master)

```sh
git clone https://github.com/kiprasmel/cputils.git
# or:  git clone git@github.com:kiprasmel/cputils.git

cd cputils

make
```

<details>

<summary>
Runtime dependencies
</summary>

- g++ (soon the compiler will be configurable -- choose yours)
- xargs
- (optional) `xclip` / `pbpaste` / `xsel` / `/dev/clipboard` or any other tool to paste from clipboard
- (optional) GNU time (`/usr/bin/env time`) for printing not only time, but also memory usage
 
</details>

## Features

- create files from your custom templates
	- auto-open created file with your editor
- run instantly without recompilation if nothing changed
- forward arguments to the compiler
	- shell aliasing fully supported
- see memory usage
- more to come @ the [Roadmap](https://github.com/kiprasmel/cputils/issues/1)

Everything above is customizable — see [#Usage](#Usage) and [#Enhancements](#Enhancements) below.

## Usage

### Quickstart

```sh
cputils new a.cpp
cputils run a.cpp
```

### Complete info

```sh
$ cputils

usage:

cputils COMMAND [COMMAND_ARGS...]

COMMAND:
        new        - new file from template
        run        - run file
        cfgen      - codeforces generator from template
        config     - edit the configuration file
    

see individual commands for details

```

[![](https://github.com/kiprasmel/cputils/workflows/cputils-new/badge.svg)](https://github.com/kiprasmel/cputils/actions?query=workflow:cputils-new+branch:master)

```sh
$ cputils new

usage:

cputils-new NEW_FILENAME.EXTENSION [OPTIONS]

  where
    NEW_FILENAME      = the name of a new file
  
    EXTENSION         = the file extension (not limited to "cpp" -
                                            you can create templates for various langs)

    -t TEMPLATE_ID    = use template by id (template.TEMPLATE_ID.EXTENSION)
                        default: unset, thus "template.cpp"

                        templates should be added to the config directory
                        ("$HOME/.config/cputils"),
                        named "template.TEMPLATE_ID.EXTENSION",
                        e.g.  "template.t.cpp" (maybe a regular template with test cases?),
                              "template.py"    (default for python files),
                              "template.js"    (default for javascript files) etc.
  
    -y                = non-interactive (do not open file with editor etc.)
                        default: false

    -i                = interactive (overrides previous `-y`)
                        default: true
                        will open created file with editor
                        if editor specified and enabled in the config

    -h, --help        = show this


  examples:
    cputils-new a.cpp               # create file a.cpp from default template.cpp
    cputils-new b.cpp -t t          # create file b.cpp from         template.t.cpp
    cputils-new c.py                # create file c.py  from default template.py
    cputils-new d.js                # create file d.js  from default template.js

```

[![](https://github.com/kiprasmel/cputils/workflows/cputils-run/badge.svg)](https://github.com/kiprasmel/cputils/actions?query=workflow:cputils-run+branch:master)

```sh
$ cputils run

usage:

cputils-run FILENAME.cpp [OPTIONS]... [-- EXTRA_COMPILER_ARGS]

  where
    FILENAME.cpp                = source file you want to run

    -f [INPUT_FILE]             = read input from (default) INPUT_FILE
                                  instead of reading from stdin

    INPUT_FILE                  = specify your own INPUT_FILE instead of the default
                                  default: FILENAME.cpp.txt (configurable)

    -c                          = read input from clipboard

    -r, --recompile             = force recompilation no matter if the file hash
                                  matches previously compiled file's hash
                                  default: false

                                  note: this does not matter if the user has not
                                  provided a hashing function in their config.
                                  see README for more info

    -e, --edit                  = edit the INPUT_FILE with configured editor
    
    -a "EXTRA_COMPILER_ARGS"    = pass arguments to the compiler (quotes necessary),
                                  can be used multiple times.

                                  hint: set custom #define's from here
                                  or override default settings etc.
                                  very useful for shell aliases / functions
                                  (see the examples below)

    -- EXTRA_COMPILER_ARGS      = same as `-a`, just for extra convenience
                                  (no quotes needed, must be used at most once,
                                  since `--` will stop argument parsing
                                  and will forward everything to the compiler)

    -h                          = see this

    --help                      = see this + examples (even if hidden via config)


examples:

  simple:
    cputils-run a.cpp                # reads input from stdin (if a.cpp needs it)
    cputils-run a.cpp -c             # reads input from clipboard
    cputils-run a.cpp -f             # reads input from file `a.cpp.txt`
    cputils-run a.cpp -f in          # reads input from file `in`
    cputils-run a.cpp <  in          # reads input from stdin redirect (from file `in`)
    cat in | cputils-run a.cpp       # reads input from stdin pipe     (from file `in`)

  with args to the compiler:
    cputils-run a.cpp          -- -DDEBUG -std=c++98 -Wextra -Wpedantic
    cputils-run a.cpp -f       -- -DDEBUG -std=c++11 -Wl,--stack,$((2 ** 28)) 
    cputils-run a.cpp -f in    -- -DEVAL  -std=c++14 -O2
	cputils-run a.cpp          --         -std=c++17 -O3 < in
    cat in | cputils-run a.cpp --         -std=c++20 -O3

  using alias functions:

  .bashrc / .zshrc / etc:
  
  ```sh
  xd() { cputils-run -a "-DDEBUG" $* }
  ...

  and replace `cputils-run a.cpp`
  with        `xd a.cpp`

```

## Enhancements

- for extra speed create an alias in i.e. `.bashrc` / `.zshrc` (replace `x` with whatever alias you want):

```sh
x()  { cputils $* }
xn() { cputils new $* }
xr() { cputils run $* }
xd() { cputils run -a "-DDEBUG" $* }
xp() { cputils run -a "-DEVAL"  $* }
```

- enable reading input from clipboard with `cputils run -c`:

edit the config file `$HOME/.config/cputils/cputils.config.bash` -- inside the `paste_from_clipboard` function provide a way to paste input from your clipboard if it's not already handled:

```bash
# cputils.config.bash

# ...

paste_from_clipboard() {
	if   command -v xclip   &>/dev/null; then printf "$(xclip -selection clipboard -o)"
	elif command -v pbpaste &>/dev/null; then printf "$(pbpaste)"
	elif command -v xsel    &>/dev/null; then printf "$(xsel --clipboard)"
	elif ls /dev/clipboard  &>/dev/null; then printf "$(cat /dev/clipboard)"
	# add your's!
	else return 1
	fi
}
export -f paste_from_clipboard

# ...
```


- auto-open a file created by `cputils new`:

edit the config file `$HOME/.config/cputils/cputils.config.bash` -- inside the `open_with_editor` function provide a way to open the file `"$1"` with your editor:

```bash
# cputils.config.bash

# ...

open_with_editor() {
	return 1 # comment out this line and choose your editor if you want to

	# vim "$1"
	# code "$1"
	# emacs "$1"
	# geany "$1" &
}
export -f open_with_editor

# ...
```

- provide a source file hashing function to avoid recompilation if no changes occured

edit the config file `$HOME/.config/cputils/cputils.config.bash` -- inside the `create_hash` function provide a way to hash file `"$1"`:

```bash
# cputils.config.bash

# ...

create_hash() {
	return 1  # comment out this line to enable and choose the appropriate method
	
	# openssl dgst -sha256 -r "$1" | awk '{ print $1 }'
	# sha256sum "$1" | awk '{ print $1 }'
}
export -f create_hash

# ...

```

> note - we handle other side effects ourselves (`EXTRA_COMPILER_ARGS`, `CPP_COMPILER_DEFAULT_ARGS` and (hopefully) anything else that should invalidate the cache). Create an issue if we missed something

- customize file templates for `cputils new`:

```sh
cd "$HOME/.config/cputils/"
```

and overwrite the default `template.cpp`;

additionally - create other templates named `template.TEMPLATE_ID.cpp` and use them via

```sh
cputils new file.cpp -t TEMPLATE_ID
```

you can even have templates for other languages too - just use a different file extension (like `template.py`, `template.js` etc.)

- other configurations

explore the config file `$HOME/.config/cputils/cputils.config.bash`. Some settings include:

- `INPUT_CACHE_FILE_EXTENSION`
- `HIDE_EXAMPLES`
- `CPP_COMPILER_DEFAULT_ARGS`
