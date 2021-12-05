{
	split($1, ranges, "-")
	pos_1 = ranges[1]
	pos_2 = ranges[2]

	split($2, chars, ":")
	char = chars[1]

	# print min ", " max ", " char ", " $3 ", " char_count
	char_1 = substr($3, pos_1, 1)
	char_2 = substr($3, pos_2, 1)
	if ((char_1 == char && char_2 != char) || (char_1 != char && char_2 == char)) valid++
}
END { print valid }
