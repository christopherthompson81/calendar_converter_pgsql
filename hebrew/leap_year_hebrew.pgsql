def leap(year):
	# Is a given Hebrew year a leap year ?
	return (((year * 7) + 1) % 19) < 7