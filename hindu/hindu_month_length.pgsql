def month_length(year, month):
	if month in HAVE_31_DAYS or (month == 1 and isleap(year - SAKA_EPOCH)):
		return 31
	return 30