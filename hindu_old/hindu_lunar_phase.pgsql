-------------------------------------------------------------------------------
-- Find the lunar phase for a given JD
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_lunar_phase(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	solar_long NUMERIC := calendars.hindu_solar_longitude(p_jd);
	lunar_long NUMERIC := calendars.hindu_lunar_longitude(p_jd);
	moon_phase NUMERIC := (lunar_long - solar_long) % 360;

BEGIN
	RETURN moon_phase;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;