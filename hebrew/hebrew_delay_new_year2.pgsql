-------------------------------------------------------------------------------
-- Check for delay in start of new year due to length of adjacent years
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_delay_new_year2(
	p_year INTEGER
)
RETURNS INTEGER AS $$

DECLARE
	last_year INTEGER := calendars.hebrew_delay_new_year1(p_year - 1);
	present_year INTEGER := calendars.hebrew_delay_new_year1(p_year);
	next_year INTEGER := calendars.hebrew_delay_new_year1(p_year + 1)

BEGIN
	IF next_year - present_year = 356 THEN
		RETURN 2;
	ELSIF present_year - last_year = 382 THEN
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
