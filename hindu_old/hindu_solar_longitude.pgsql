-------------------------------------------------------------------------------
-- Find solar longitude at a given JD
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_solar_longitude(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	t_jde := astronomia.jd_to_jde(p_jd);
	t_ecl astronomia.ecliptic_coordinates%rowtype := astronomia.solar_true_vsop87('earth', t_jde);

BEGIN
	RETURN degrees(t_ecl.longitude) % 360;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;