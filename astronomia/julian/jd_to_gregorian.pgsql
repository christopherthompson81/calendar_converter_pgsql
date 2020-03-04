-------------------------------------------------------------------------------
-- Convert JD to a timestamp
--
-- PARAM - NUMERIC JD
-- RETURNS - TIMESTAMP Gregorian date (proleptic agnostic) without timezone
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.jd_to_gregorian(
	p_jd NUMERIC
)
RETURNS TIMESTAMP
AS $$

DECLARE
	t_calendar NUMERIC[] := astronomia.jd_to_calendar(p_jd);
	t_timestamp TIMESTAMP := astronomia.calendar_to_timestamp(t_calendar);

BEGIN
	RETURN t_timestamp;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
