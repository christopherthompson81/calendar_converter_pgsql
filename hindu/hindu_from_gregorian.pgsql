-------------------------------------------------------------------------------
-- Obtain Indian Civil Date from Calendar Array
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.hindu_from_gregorian(
	p_date DATE
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN calendars.hindu_from_jd(astronomia.gregorian_to_jd(p_date::TIMESTAMP));
END;

$$ LANGUAGE plpgsql;