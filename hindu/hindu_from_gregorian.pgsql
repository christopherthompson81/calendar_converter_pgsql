def from_gregorian(year, month, day):
	return from_jd(gregorian.to_jd(year, month, day))