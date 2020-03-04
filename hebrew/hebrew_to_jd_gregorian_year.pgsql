def to_jd_gregorianyear(gregorianyear, hebrew_month, hebrew_day):
	# gregorian year is either 3760 or 3761 years less than hebrew year
	# we'll first try 3760 if conversion to gregorian isn't the same
	# year that was passed to this method, then it must be 3761.

	for y in (gregorianyear + HEBREW_YEAR_OFFSET, gregorianyear + HEBREW_YEAR_OFFSET + 1):
		jd = to_jd(y, hebrew_month, hebrew_day)
		gd = gregorian.from_jd(jd)
		if gd[0] == gregorianyear:
			break
		else:
			gd = None

	if not gd:  # should never occur, but just incase...
		raise ValueError("Could not determine gregorian year")

	# tuple: (y, m, d)
	return (gd[0], gd[1], gd[2])
