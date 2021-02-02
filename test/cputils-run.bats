#!/usr/bin/env bats

load test_helper

@test "does not run file if filename not provided (!)" {
	! cputils-run
}

@test "does not run file if filename does not exist (!)" {
	! cputils-run "non-existant-filename.cpp"
}

@test "runs file" {
	file="filename.cpp"

	create_file "$file"

	cputils-run "$file"
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
}

@test "does not run file with input from *non-existant* *default* file (! -f)" {
	file="filename.cpp"

	! cputils-run "$file" -f
}

@test "runs file with input from *custom* *file* (-f FILENAME)" {
	file="filename.cpp"
	input_file="in"

	create_file_with_input "$file"

	printf "content" > "$input_file"

	cputils-run "$file" -f "$input_file"
}

@test "does not run file with input from *non-existant* *custom* *file* (! -f FILENAME)" {
	file="filename.cpp"
	input_file="non-existant-input-file"

	create_file_with_input "$file"

	! cputils-run "$file" -f "$input_file"
}

#@test "runs file with input from *clipboard* (-c)" {
#	!
#}
#
## not sure about this functionality though
#@test "still runs file with input from *empty* *clipboard* (-c)" {
#	!
#}

