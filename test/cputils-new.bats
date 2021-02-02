#!/usr/bin/env bats

# loads helpers, creates default config etc.
load test_helper

@test "fails if config is missing (in non-interactive mode)" {
	rm "$CFGFILEPATH"

	! cputils-new file.cpp -y
}

@test "creates file from *default* template (in non-interactive mode)" {
	LANG="cpp"
	TEMPLATE_FILE="template.$LANG"
	FILENAME="filename.$LANG"

	create_template "$TEMPLATE_FILE"

	cputils-new "$FILENAME" -y

	[ -f "$FILENAME" ]
}

@test "creates file from *selected* template (-t) (in non-interactive mode)" {
	TEMPLATE_ID="some_id69"
	LANG="cpp"
	TEMPLATE_FILENAME="template.$TEMPLATE_ID.$LANG"
	FILENAME="filename.$LANG"

	create_template "$TEMPLATE_FILENAME"

	cputils-new -t "$TEMPLATE_ID" "$FILENAME" -y

	[ -f "$FILENAME" ]
}

@test "does not open created file in *non-interactive* mode (-y)" {
	create_template "template.cpp"

	override_config "

open_with_editor() {
	return 1 # ensures function not called
}
export -f open_with_editor

"

	cputils-new file.cpp -y
}

@test "opens created file in *interactive* mode (-i) (default)" {
	create_template "template.cpp"

	override_config "

open_with_editor() {
	return 0 # ensures function called
}
export -f open_with_editor

"

	cputils-new file.cpp -i
}

