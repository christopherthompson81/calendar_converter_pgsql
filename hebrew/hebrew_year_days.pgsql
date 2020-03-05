def year_days(year):
	'''How many days are in a Hebrew year ?'''
	return to_jd(year + 1, 7, 1) - to_jd(year, 7, 1)

-------------------------------------------------------------------------------
-- How many days are in a Hebrew year?
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_year_days(
	p_year INTEGER
)
RETURNS DATE AS $$

BEGIN
	return to_jd(year + 1, 7, 1) - to_jd(year, 7, 1)
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
