# Each character is a field
BEGIN {
    FS = ""
}
# We'll count the 1s in each position.
# If 2 * number of 1s > number of records, they're the most common
# epsilon is !gamma.
{
    bits = NF
    for (f = 1; f <= NF; f++) {
        ones[f] += $f
    }
}
END {
    print "Total records:" NR
    for (f = 1; f <= bits; f++) {
        if (2 * ones[f] > NR) 
            most_common = 1 
        else 
            most_common = 0
        exponent = 2 ^ (bits - f)
        print "0s: " NR - ones[f] ", 1s: " ones[f] ", most common: " most_common ", exponent: " exponent
        gamma += most_common * exponent
        epsilon += (1 - most_common) * exponent
    }
    print "gamma: " gamma ", epsilon: " epsilon
    print gamma * epsilon
}
