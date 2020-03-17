-------------------------------------------------------------------------------
-- Find if a JD is in a Hindu leap month
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_jd_is_in_lunar_leap_month(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	sunrise NUMERIC := astronomia.sunrise(p_jd);
	last_new_moon NUMERIC := calendars.previous_new_moon(sunrise);
	next_new_moon NUMERIC := calendars.next_new_moon(sunrise)
	this_solar_month INTEGER := calendars.hindu_solar_month_from_jd(last_new_moon);
	next_solar_month INTEGER := calendars.hindu_solar_month_from_jd(next_new_moon);
	is_leap_month BOOLEAN := this_solar_month = next_solar_month;

BEGIN
	RETURN is_leap_month;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;