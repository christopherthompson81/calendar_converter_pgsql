-------------------------------------------------------------------------------
-- solar_true_vsop87 returns the true geometric position of the sun as ecliptic coordinates.
--
-- Result computed by full VSOP87 theory.  Result is at equator and equinox
-- of date in the FK5 frame.  It does not include nutation or aberration.
--
-- Param astronomia.planet_position_ p_planet
-- Param NUMERIC jde - Julian ephemeris day
-- Returns astronomia.ecliptic_coordinates
--   NUMERIC lon - ecliptic longitude in radians
--   NUMERIC lat - ecliptic latitude in radians
--   NUMERIC range - range in AU
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.solar_true_vsop87(
	p_planet_name TEXT,
	p_jde NUMERIC
)
RETURNS astronomia.ecliptic_coordinates
AS $$

DECLARE
	t_ecl astronomia.ecliptic_coordinates%rowtype := astronomia.planet_position(p_planet_name, p_jde);
	s NUMERIC := t_ecl.longitude + PI();
	-- FK5 correction.
	λp NUMERIC := astronomia.horner(
		astronomia.j2000_century(p_jde),
		ARRAY[
			s,
			-1.397 * PI() / 180.0,
			-0.00031 * PI() / 180.0
		]::NUMERIC[]
	);
	sλp NUMERIC := SIN(λp);
	cλp NUMERIC := COS(λp);
	Δβ NUMERIC := 0.03916 / 3600.0 * PI() / 180.0 * (cλp - sλp);

BEGIN
	-- (25.9) p. 166
	--RAISE EXCEPTION 'solar_true_vsop87: t_ecl: %;', t_ecl;
	t_ecl.longitude := astronomia.pmod((s - 0.09033 / 3600 * PI() / 180)::NUMERIC, (2 * PI())::NUMERIC);
	t_ecl.latitude := Δβ - t_ecl.latitude;
	RETURN t_ecl;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
