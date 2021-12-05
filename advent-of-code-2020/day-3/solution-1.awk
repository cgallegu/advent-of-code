# Lines are just dots and pounds, so no field separator
BEGIN { FS = "" }
# Let's translate "slope right 3, down 1" to awk
# Looking at the example:
# record: 2 -> field: 4
# record: 3 -> field: 7
# ...
# record: NR -> field: 3 * (NR - 1) + 1
# It wraps around. Wrapping means calculating the modulus.
# That's the `%` operator in awk.
# Looking at the example:
# unwrapped field 11 == wrapped field 11
# unwrapped field 12 == wrapped field 1
# unwrapped field 13 == wrapped field 2
# Have to add/substract 1 to account for fields being 1-based
{
    unwrapped_field = 3 * (NR - 1) + 1
    wrapped_field = ((unwrapped_field - 1) % NF) + 1
	if ($wrapped_field == "#") trees++
}
END { print trees }
