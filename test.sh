#!/usr/bin/env bash

# https://stackoverflow.com/a/24112741/9285308
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

"$REPO_ROOT"/bats-core/bin/bats "$REPO_ROOT"/test $*

