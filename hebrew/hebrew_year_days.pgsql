def year_days(year):
	'''How many days are in a Hebrew year ?'''
	return to_jd(year + 1, 7, 1) - to_jd(year, 7, 1)