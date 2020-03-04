-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- leap_year_gregorian returns true if year y in the Gregorian calendar is a leap year.
--
-- PARAM p_y - year (int)
-- RETURNS BOOLEAN - true if leap year in Gregorian Calendar
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.leap_year_gregorian(
	p_y INTEGER
)
RETURNS BOOLEAN AS $$

BEGIN
	RETURN (p_y % 4 = 0 AND p_y % 100 != 0) OR p_y % 400 = 0;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
