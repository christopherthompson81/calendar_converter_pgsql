-------------------------------------------------------------------------------
-- Returns lunar month and if it is adhika or not.
-- 1 = Chaitra, 2 = Vaisakha, ..., 12 = Phalguna"
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_lunar_month_from_jd(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	critical NUMERIC := astronomia.sunrise(p_jd);
	last_new_moon NUMERIC := calendars.prior_new_moon(critical);
	next_new_moon NUMERIC := calendars.next_new_moon(critical);
	this_solar_month NUMERIC := calendars.hindu_solar_month(last_new_moon);
	next_solar_month NUMERIC := calendars.hindu_solar_month(next_new_moon);
	is_leap_month BOOLEAN := this_solar_month = next_solar_month;
	maasa NUMERIC := this_solar_month + 1;

BEGIN
	IF maasa > 12 THEN
		maasa := maasa % 12;
	END IF;
	RETURN ARRAY[maasa::INTEGER, is_leap_month::INTEGER];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;