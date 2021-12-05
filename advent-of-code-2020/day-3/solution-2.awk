# Lines are just dots and pounds, so no field separator
# Generalizing from solution 1.
# Paraterizing "right 3"
# record: NR -> field: 3 * (NR - 1) + 1
# turns into
# record: NR -> field: delta_right * (NR - 1) + 1
# wrapping stays the same.
# now for the down delta, only check for collission if
# (NR - 1) % delta_down == 0
#
# To do this in a single pass, we need to store the state for each
# of the slopes.
# Let's try nested arrays

BEGIN { 
    FS = ""
    state[1, "right"] = 1; state[1, "down"] = 1
    state[2, "right"] = 3; state[2, "down"] = 1
    state[3, "right"] = 5; state[3, "down"] = 1
    state[4, "right"] = 7; state[4, "down"] = 1
    state[5, "right"] = 1; state[5, "down"] = 2
}

{
    for (i = 1; i <= 5; i++) {
        unwrapped_field = state[i, "right"] * (NR - 1) + 1
        wrapped_field = ((unwrapped_field - 1) % NF) + 1
        if ((NR - 1) % state[1, "down"] == 0)
	        if ($wrapped_field == "#") {
                state[i, "trees"]++
                print i ", " NR ", " wrapped_field ": " $0
            }
    }
}
END {
    result = 1
    for (i = 1; i <= 5; i++) {
        trees = state[i, "trees"]
        print "slope:" i ", trees: " trees
        result *= trees    
    }
    print result
}
