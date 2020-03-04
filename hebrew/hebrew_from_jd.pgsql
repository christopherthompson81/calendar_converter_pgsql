def from_jd(jd):
	jd = trunc(jd) + 0.5
	count = trunc(((jd - EPOCH) * 98496.0) / 35975351.0)
	year = count - 1
	i = count
	while jd >= to_jd(i, 7, 1):
		i += 1
		year += 1

	if jd < to_jd(year, 1, 1):
		first = 7
	else:
		first = 1

	month = i = first
	while jd > to_jd(year, i, month_days(year, i)):
		i += 1
		month += 1

	day = int(jd - to_jd(year, month, 1)) + 1
	return (year, month, day)