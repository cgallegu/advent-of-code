{
	for (i = 1; i <= NF - 2; i++)
		for (j = 2; j <= NF - 1; j++)
			for (k = 3; k <= NF; k++)
				if ($i + $j + $k  == 2020)
					print $i ", " $j ", " $k ", solution: " $i * $j * $k
}
