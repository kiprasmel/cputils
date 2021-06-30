#!/usr/bin/env bats

load test_helper

@test "does not run file if filename not provided (!)" {
	! cputils-run
}

@test "does not run file if file does not exist (!)" {
	! cputils-run "non-existant-filename.cpp"
}

@test "runs existing file" {
	file="filename.cpp"

	create_file "$file"

	cputils-run "$file"
}

@test "does not run *non-existant* file" {
	file="filename.cpp"

	! cputils-run "$file"
}

@test "runs file with input from stdin (default)" {
	file="filename.cpp"

	create_file_with_input "$file"

	input="ayyy_lmao"
	printf "$input" | cputils-run "$file" | grep "$input"
}

@test "runs file with input from *default* *file* (-f)" {
	file="filename.cpp"

	create_file "$file"

	cputils-run "$file" -f
	cputils-run -f "$file"
}

# TODO: not sure about this behavior
# it's good to have since it's good for keybinds for either case
#   a) program does not need input so default file is empty (good) / filled (good)
#   b) program does     need input so default file is empty (bad)  / filled (good)
#
# 3 vs 1 -> seems good:D
#
# but if a enters input into a miss-spelled default file,
# they'd expect to receive an error if it was empty.
# -> bad
#
# though they'd likely use -f with a custom file anyway,
# so perhaps -> not as bad
#
@test "still does run file with input from *non-existant* *default* *file* (-f)" {
# @test "does not run file with input from *non-existant* default file (! -f)" {
	file="filename.cpp"

	create_file "$file"

	cputils-run "$file" -f
	cputils-run -f "$file"
}

@test "runs file with input from *custom* *file* (-f FILENAME)" {
	file="filename.cpp"
	input_file="in"

	create_file_with_input "$file"

	printf "content" > "$input_file"

	cputils-run "$file" -f "$input_file"
	cputils-run -f "$input_file" "$file"
}

@test "does not run file with input from *non-existant* *custom* *file* (! -f FILENAME)" {
	file="filename.cpp"
	input_file="non-existant-input-file"

	create_file_with_input "$file"

	! cputils-run "$file" -f "$input_file"
	! cputils-run -f "$input_file" "$file"
}

@test "runs file with input from *clipboard* (-c)" {
	input="hehe_have_some_input_fam"

	override_config \
"
paste_from_clipboard() {
	printf \"$input\"
	return 0
}
export -f paste_from_clipboard
"

	file="filename.cpp"
	create_file_with_input "$file"

	cputils-run "$file" -c | grep "$input"
}

# TODO: not sure about this functionality tho,
# esp. since it also varies by clipboard manager tool
@test "still does run file with input from *empty* *clipboard* (-c)" {
	override_config \
"

paste_from_clipboard() {
	return 0
}
export -f paste_from_clipboard

create_output_file_name() {
	printf \"\$1.out\"
}
export -f create_output_file_name
"

	file="filename.cpp"
	create_file_with_input "$file"

	cputils-run "$file" -c
}

@test "does not run file with input from *clipboard* when clipboard function not setup (! -c)" {
	override_config \
"
paste_from_clipboard() {
	return 1
}
export -f paste_from_clipboard

"

	file="filename.cpp"
	create_file_with_input "$file"

	! cputils-run "$file" -c
}

# TODO: default to `-f` if `-e`
@test "opens *default* INPUT_FILE with editor (-e)" {
	override_config \
"
open_with_editor() {
	printf \"\$1\"
	return 0
}
export -f open_with_editor
"

	file="filename.cpp"
	create_file "$file"

	cputils-run "$file" -f -e | grep "$file"

	[ ! -f "$file.hash" ]
	[ ! -f "$file.out" ]
}

@test "opens *custom* INPUT_FILE with editor (-f INPUT_FILE -e)" {
	override_config \
"
open_with_editor() {
	printf \"\$1\"
	return 0
}
export -f open_with_editor
"

	file="filename.cpp"
	create_file "$file"

	input_file="custom_input_file"

	cputils-run "$file" -f "$input_file" -e | grep "$input_file"

	[ ! -f "$file.hash" ]
	[ ! -f "$file.out" ]
}

@test "does compile if output file (executable) does not exist yet (first run)" {
	override_config \
"
create_output_file_name() {
	printf \"\$1\"
}
export -f create_output_file_name
"

	file="filename.cpp"
	create_file "$file"

	first_time_compile_message="COMPILE"
	cputils-run "$file" | grep "^$first_time_compile_message$"
}

@test "*does* recompile if file content (hash) *did change*" {
	file="filename.cpp"
	create_file "$file"

	first_time_compile_message="COMPILE"
	recompile_message="RECOMPILE"

	with_hash "some_nice_hash"
	cputils-run "$file" | grep "^$first_time_compile_message$"

	with_hash "different_hash"
	cputils-run "$file" | grep "^$recompile_message$"
}

@test "*does not* recompile if file content (hash) *did not* change" {
	file="filename.cpp"
	create_file "$file"

	first_time_compile_message="COMPILE"
	no_recompile_message="NO_RECOMPILE"

	with_hash "some_nice_hash"

	cputils-run "$file" | grep "^$first_time_compile_message$"
	cputils-run "$file" | grep "^$no_recompile_message$"
}

@test "*does* recompile if forced to, no matter if file content (hash) changed or not (-r)" {
	file="filename.cpp"
	create_file "$file"

	first_time_compile_message="COMPILE"
	recompile_message="FORCE_RECOMPILE"

	with_hash "some_nice_hash"

	cputils-run "$file"    | grep "^$first_time_compile_message$"
	cputils-run "$file" -r | grep "^$recompile_message$"
}

