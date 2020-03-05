-------------------------------------------------------------------------------
-- Get a Hebrew date from a Gregorian date
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_from_gregorian(
	p_date DATE
)
RETURNS calendars.date_parts AS $$

BEGIN
	RETURN calendars.hebrew_from_jd(astronomia.gregorian_to_jd(p_date));
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
