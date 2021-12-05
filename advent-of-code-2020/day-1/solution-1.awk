{
	for (i = 1; i <= NF - 1; i++)
		for (j = 2; j <= NF; j++)
			if ($i + $j == 2020)
				print $i ", " $j ", solution: " $i * $j
}
