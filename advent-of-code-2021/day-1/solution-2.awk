{ for (i = 1; i <= NF - 3; i++)	if ($i < $(i + 3)) increased++ } END { print increased }
