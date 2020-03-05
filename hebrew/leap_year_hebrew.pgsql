-------------------------------------------------------------------------------
-- Is a given Hebrew year a leap year?
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.leap_year_hebrew(
	p_year INTEGER
)
RETURNS BOOLEAN AS $$

BEGIN
	RETURN (((p_year * 7) + 1) % 19) < 7;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
