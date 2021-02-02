#!/usr/bin/env bash

# stolen from https://github.com/pyenv/pyenv/blob/4c302a022d653eb687c6b7b2d089d2a6cb55464a/test/test_helper.bash

unset CPUTILS_VERSION
unset CPUTILS_DIR

### guard against executing this block twice due to bats internals
#if [ -z "$CPUTILS_TEST_DIR" ]; then
#fi

# before each test
setup() {
  CPUTILS_TEST_DIR="${BATS_TMPDIR}/cputils"
  export CPUTILS_TEST_DIR="$(mktemp -d "${CPUTILS_TEST_DIR}.XXX" 2>/dev/null || echo "$CPUTILS_TEST_DIR")"

  #if enable -f "${BATS_TEST_DIRNAME}"/../libexec/cputils-realpath.dylib realpath 2>/dev/null; then
  #  export CPUTILS_TEST_DIR="$(realpath "$CPUTILS_TEST_DIR")"
  #else
  #  if [ -n "$CPUTILS_NATIVE_EXT" ]; then
  #    echo "cputils: failed to load \`realpath' builtin" >&2
  #    exit 1
  #  fi
  #fi

  #export CPUTILS_ROOT="${CPUTILS_TEST_DIR}/root"
  export HOME="${CPUTILS_TEST_DIR}/home/sample-user"

  export CFGDIR="${HOME}/.config/cputils"
  export CFGFILENAME="cputils.config.bash"
  export CFGFILEPATH="$CFGDIR/$CFGFILENAME"

  # export CPUTILS_HOOK_PATH="${CPUTILS_ROOT}/cputils.d"

  mkdir -p "$CFGDIR"

  # root of the actual repository
  # (relative to this script, thus additional "..")
  # https://stackoverflow.com/a/24112741/9285308
  export REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd -P)"

  PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

  # add cputils scripts to path
  # (thus no need to re-compile / re-install before running tests)
  PATH="$REPO_ROOT:$PATH"
  # PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$PATH"
  PATH="${CPUTILS_TEST_DIR}/bin:$PATH"
  PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"
  PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
  PATH="${CPUTILS_ROOT}/shims:$PATH"
  export PATH

  for xdg_var in `env 2>/dev/null | grep ^XDG_ | cut -d= -f1`; do unset "$xdg_var"; done
  unset xdg_var

  create_default_config() {
    cp "$REPO_ROOT/$CFGFILENAME" "$CFGFILEPATH"
  }
  # export create_default_config
  create_default_config

  local SAMPLE_PROJECT="$HOME/sample-project"
  mkdir -p "$SAMPLE_PROJECT"
  cd "$SAMPLE_PROJECT"
}


# after each test
teardown() {
  rm -rf "$CPUTILS_TEST_DIR"
}

# --- #

override_config() {
	cat > "$CFGFILEPATH" <<EOF
#!/usr/bin/env bash

$1
EOF
}

create_template() {
	FULL_FILENAME="$1"

	[ -n "$FULL_FILENAME" ]

	CONTENT="$2"

	[ -z "$CONTENT" ] && {
		CONTENT="
#include <cstdio>

int main() {
	printf(\"hello world!\");
	return 0;
}

"
	}

	
	printf "$CONTENT" > "$CFGDIR/$FULL_FILENAME" 

}

create_template_with_input() {
	FULL_FILENAME="$1"

	[ -n "$FULL_FILENAME" ]

	create_template "$FULL_FILENAME" \
"
#include <iostream>
#include <string>

int main() {
	std::string s;
	std::cin >> s;

	std::cout << s << std::endl;

	return 0;
}

"
}

create_file() {
	filename="$1"
	shift
	[ -n "$filename" ]

	extension="${filename##*.}"
	create_template "template.$extension"

	cputils-new "$filename" -y $*

}

create_file_with_input() {
	filename="$1"
	shift
	[ -n "$filename" ]

	extension="${filename##*.}"
	create_template_with_input "template.$extension"

	cputils-new "$filename" -y $*
}

assert_any_line() {
  local line
  for line in "${lines[@]}"; do
    if [ "$line" = "$1" ]; then return 0; fi
  done
  return 1
}

with_hash() {
	HASH="$1"

	[ -n "$HASH" ]

	override_config \
"
create_hash() {
	printf \"$HASH\"
	return 0
}
export -f create_hash

create_output_file_name() {
	printf \"\$1.out\"
}
export -f create_output_file_name
"

}

