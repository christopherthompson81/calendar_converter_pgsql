-------------------------------------------------------------------------------
-- How many days are in a Hebrew year?
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_year_days(
	p_year INTEGER
)
RETURNS INTEGER AS $$

BEGIN
	RETURN (
		calendars.hebrew_to_jd((p_year + 1, 7, 1)) -
		calendars.hebrew_to_jd((p_year, 7, 1))
	);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
