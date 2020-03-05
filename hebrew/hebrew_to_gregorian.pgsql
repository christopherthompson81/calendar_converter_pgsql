-------------------------------------------------------------------------------
-- Get a Gregorian date from a Hebrew date
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_to_gregorian(
	p_hebrew calendars.date_parts
)
RETURNS DATE AS $$

BEGIN
	RETURN astronomia.jd_to_gregorian(calendars.hebrew_to_jd(p_hebrew))::DATE;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
