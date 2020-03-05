-------------------------------------------------------------------------------
-- How many months are there in a Hebrew year (12 = normal, 13 = leap)
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_year_months(
	p_year INTEGER
)
RETURNS INTEGER AS $$

DECLARE
	t_months INTEGER := (CASE WHEN calendars.leap_year_hebrew(p_year) THEN 13 ELSE 12 END);

BEGIN
	RETURN t_months;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
