-------------------------------------------------------------------------------
-- Find lunar longitude at a given JD
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_lunar_longitude(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	t_jde := astronomia.jd_to_jde(p_jd);
	t_ecl astronomia.ecliptic_coordinates%rowtype := astronomia.moon_position(t_jde);

BEGIN
	RETURN degrees(t_ecl.longitude) % 360;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;