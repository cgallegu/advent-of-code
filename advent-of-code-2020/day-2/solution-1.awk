{
	split($1, ranges, "-")
	min = ranges[1]
	max = ranges[2]

	split($2, chars, ":")
	char = chars[1]

	split($3, segments, char)
	char_count = length(segments) - 1

	# print min ", " max ", " char ", " $3 ", " char_count

	if (min <= char_count && char_count <= max) valid++ 
}
END { print valid }
