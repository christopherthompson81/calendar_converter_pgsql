-------------------------------------------------------------------------------
-- Obtain Indian Civil Date - Month Length
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.hindu_month_length(
	p_year INTEGER,
	p_month INTEGER
)
RETURNS INTEGER
AS $$

DECLARE
	HAVE_31_DAYS INTEGER[] := ARRAY[2, 3, 4, 5, 6];
	HAVE_30_DAYS INTEGER[] := ARRAY[7, 8, 9, 10, 11, 12];
	SAKA_EPOCH INTEGER := 78;

BEGIN
	IF p_month = ANY(HAVE_31_DAYS) OR (p_month = 1 AND astronomia.leap_year_gregorian(p_year - SAKA_EPOCH)) THEN
		RETURN 31;
	END IF;
	RETURN 30;
END;

$$ LANGUAGE plpgsql;