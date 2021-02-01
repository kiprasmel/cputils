#!/usr/bin/env bash

# pulling initially (broken does not work)
# see https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin
### git pull --recurse-submodules

# pulling up to what our repo has been using (expected)
# https://stackoverflow.com/questions/16773642/pull-git-submodules-after-cloning-project-from-github
git submodule update --init --recursive

