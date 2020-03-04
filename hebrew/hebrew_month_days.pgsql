def month_days(year, month):
	'''How many days are in a given month of a given year'''
	if month > 13:
		raise ValueError("Incorrect month index")

	# First of all, dispose of fixed-length 29 day months
	if month in (IYYAR, TAMMUZ, ELUL, TEVETH, VEADAR):
		return 29

	# If it's not a leap year, Adar has 29 days
	if month == ADAR and not leap(year):
		return 29

	# If it's Heshvan, days depend on length of year
	if month == HESHVAN and (year_days(year) % 10) != 5:
		return 29

	# Similarly, Kislev varies with the length of year
	if month == KISLEV and (year_days(year) % 10) == 3:
		return 29

	# Nope, it's a 30 day month
	return 30