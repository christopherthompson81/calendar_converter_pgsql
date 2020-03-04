-------------------------------------------------------------------------------
-- solar_apparent_vsop87 returns the apparent position of the sun as ecliptic coordinates.
--
-- Result computed by VSOP87, at equator and equinox of date in the FK5 frame,
-- and includes effects of nutation and aberration.
--
-- note: see duplicated code in apparent_equatorial_vsop87.
--
-- Param TEXT p_planet_name
-- Param NUMERIC jde - Julian ephemeris day
-- Returns astronomia.ecliptic_coordinates
--   NUMERIC longitude - ecliptic longitude in radians
--   NUMERIC latitude - ecliptic latitude in radians
--   NUMERIC range - range in AU
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.solar_apparent_vsop87(
	p_planet_name TEXT,
	p_jde NUMERIC
)
RETURNS astronomia.ecliptic_coordinates
AS $$

DECLARE
	t_ecl astronomia.ecliptic_coordinates%rowtype := astronomia.solar_true_vsop87(p_planet_name, p_jde);
	t_nutation NUMERIC[] := astronomia.nutation(p_jde);
	Δψ NUMERIC := t_nutation[1];
	a NUMERIC := astronomia.solar_aberration(t_ecl.range_value);

BEGIN
	t_ecl.longitude := t_ecl.longitude + Δψ + a;
	RETURN t_ecl;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
