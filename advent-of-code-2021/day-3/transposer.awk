BEGIN { FS = "" }
{ for (f = 1; f <= NF; f++) col[f] = col[f] $f }
END { for (f = 1; f <= NF; f++) print col[f] }
