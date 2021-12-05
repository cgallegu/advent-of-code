{ if (NR > 1 && $0 > previous) increased++; previous = $0 } END { print increased }
