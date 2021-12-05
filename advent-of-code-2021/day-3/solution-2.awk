# Transposing should make things easier.
# Use main body to transpose input in an array,
# use END block to calculate the result

function binstr_to_dec(str,  acc)
{
    for (i = length(str); i >= 1; i--) {
        if (substr(str, i, 1) == "1") {
            acc += 2^(length(str) - i) 
        }
    }
    return acc
}

BEGIN { FS = "" }
{
    o2["ones"] = 0
    o2["zeroes"] = 0
    co2["ones"] = 0
    co2["zeroes"] = 0
    
    # Count ones
    for (f = 1; f <= NF; f++) {
        if (f in o2_mask == 0) {
            o2["ones"] += $f
            o2["zeroes"] += (1 - $f)
        }
        if (f in co2_mask == 0) {
            co2["ones"] += $f
            co2["zeroes"] += (1 - $f)
        }
    }
    
    # Determine most common for oxygen generator
    (o2["ones"] >= o2["zeroes"]) ? most_common = 1 : most_common = 0

    # Determine least common for CO2 generator
    (co2["ones"] >= co2["zeroes"]) ? least_common = 0 : least_common = 1

    # print curent mask
    #for (f = 1; f <= NF; f++) {
    #    (f in o2_mask) ? mask_val = " " : mask_val = "x" 
    #   printf mask_val
    #}
    #print ""
    #print $0 " o2 : 0s: " o2["zeroes"] ", 1s: "  o2["ones"] " mc: " most_common
    # print curent mask
    #for (f = 1; f <= NF; f++) {
    #    (f in co2_mask) ? mask_val = " " : mask_val = "x" 
    #    printf mask_val
    #}
    #print ""
    #print $0 " co2: 0s: " co2["zeroes"] ", 1s: "  co2["ones"] " lc: " least_common
    #print ""
    # Calculate mask
    for (f = 1; f <= NF; f++) {
        if ($f != most_common) o2_mask[f] = "x"
        if ($f != least_common) co2_mask[f] = "x"
    }

    # Calculate partial numbers
    for (f = 1; f <= NF; f++) {
        o2[f] = o2[f] $f
        co2[f] = co2[f] $f
    }

    # Check if mask is full
    if (length(o2_mask) == NF - 1) {
        # find unmasked field
        for (f = 1; f <= NF; f++) {
            if (f in o2_mask == 0) o2_field = f
        }
    }
    # Check if mask is full
    if (length(co2_mask) == NF - 1) {
        # find unmasked field
        for (f = 1; f <= NF; f++) {
            if (f in co2_mask == 0) co2_field = f
        }
    }
}
END {
    print o2[o2_field]
    print co2[co2_field]
    print binstr_to_dec(o2[o2_field]) 
    print binstr_to_dec(co2[co2_field]) 
    print binstr_to_dec(o2[o2_field]) * binstr_to_dec(co2[co2_field])
}
