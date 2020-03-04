def to_jd(year, month, day):
	months = year_months(year)
	jd = EPOCH + delay_1(year) + delay_2(year) + day + 1

	if month < 7:
		for mon in range(7, months + 1):
			jd += month_days(year, mon)

		for mon in range(1, month):
			jd += month_days(year, mon)
	else:
		for mon in range(7, month):
			jd += month_days(year, mon)

	return int(jd) + 0.5