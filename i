#!/usr/bin/env bash
# i

# prepend: https://superuser.com/a/246841/1012390
#   paste: https://stackoverflow.com/a/4208191/9285308

TARGET_FILE="in"
CONTENT="$(xclip -selection primary -o) \n\n\n"
# CONTENT="$(xclip -selection primary -o) \n\n $(cat - \$TARGET_FILE)"

# feedback
printf "$CONTENT"

printf "$CONTENT" | cat - "$TARGET_FILE" > __temp && mv __temp "$TARGET_FILE"
# echo "$CONTENT" > "$TARGET_FILE"

