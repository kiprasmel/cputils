# cputils

<!-- CLI utilities for competitive programmers -->
<u>c</u>ompetitive <u>p</u>rogramming <u>utils</u>

## Installation

```sh
git clone https://github.com/kiprasmel/cputils.git
# or:  git clone git@github.com:kiprasmel/cputils.git

cd cputils

make install
```

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
    

see individual commands for details

```

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
                        e.g.  "template.cpp"   (default for cpp files),
							  "template.t.cpp" (maybe a regular template with test cases?),
                              "template.py"    (default for python files),
                              "template.js"    (default for javascript files) etc.
  
    -y                = non-interactive (do not open file with editor etc.)
                        default: false; will open created file with editor
                        if editor specified and enabled in the config
  
  
  examples:
    cputils-new a.cpp               # create file a.cpp from default template.cpp
    cputils-new b.cpp -t t          # create file b.cpp from         template.t.cpp
    cputils-new c.py                # create file c.py  from default template.py
    cputils-new d.js                # create file d.js  from default template.js

```

```sh
$ cputils run

usage:

cputils-run FILENAME.cpp [- [INPUT_FILE]] [-a "EXTRA_COMPILER_ARGS"]... [-- EXTRA_COMPILER_ARGS]

  where
    FILENAME.cpp                = source file you want to run

    -                           = reuse previous input
                                  instead of reading from clipboard

    INPUT_FILE                  = input file to take input from.
                                  default: FILENAME.cpp.in
    
    -a "EXTRA_COMPILER_ARGS"    = pass arguments to the compiler (quotes necessary),
                                  can be used multiple times.

                                  hint: set custom #define's from here
                                  or override default settings etc.
                                  very useful for shell aliases / functions
                                  (see the examples below)

    -- EXTRA_COMPILER_ARGS      = same as `-a`, just for extra convenience
                                  (no quotes needed, must be used at most once, since
                                  `--` will stop argument parsing and will forward
                                  everything to the compiler)


  examples:
    simple:
      cputils-run a.cpp               # reads input from clipboard
      cputils-run a.cpp -             # reads input from file "a.cpp.in"
      cputils-run a.cpp - in          # reads input from file "in"

    with args to the compiler:
      cputils-run a.cpp      -- -DDEBUG -std=c++98 -Wextra
      cputils-run a.cpp -    -- -DDEBUG -std=c++17 -Wextra -Wpedantic
      cputils-run a.cpp - in -- -DEVAL  -std=c++20 -O2

    using alias functions:
      .bashrc / .zshrc etc.:

      xd() { cputils-run -a "-DDEBUG" $* }

    simple (using aliases):
      xd a.cpp               # reads input from clipboard
      xd a.cpp -             # reads input from file "a.cpp.in"
      xd a.cpp - in          # reads input from file "in"

    with args to the compiler (using aliases):
      xd a.cpp      --        -std=c++98 -Wextra
      xd a.cpp -    --        -std=c++17 -Wextra -Wpedantic
      xd a.cpp - in -- -DEVAL -std=c++20 -O2

```

## Enhancements

- for extra speed create an alias in i.e. `.bashrc` / `.zshrc` (replace `x` with whatever alias you want):

```sh
x()  { cputils $* }
xr() { cputils run $* }
xd() { cputils run -a "-DDEBUG" $* }
xp() { cputils run -a "-DEVAL"  $* }
```

- auto-open a file created by `cputils new`:

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

