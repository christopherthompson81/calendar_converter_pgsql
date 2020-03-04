def year_months(year):
	'''How many months are there in a Hebrew year (12 = normal, 13 = leap)'''
	if leap(year):
		return 13
	else:
		return 12