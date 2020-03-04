-------------------------------------------------------------------------------
-- Obtain Indian Civil Date from Calendar Array
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.hindu_to_gregorian(
	p_date_parts calendars.date_parts
)
RETURNS DATE
AS $$

BEGIN
	RETURN astronomia.jd_to_gregorian(calendars.hindu_to_jd(p_date_parts))::DATE;
END;

$$ LANGUAGE plpgsql;