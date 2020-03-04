-------------------------------------------------------------------------------
-- position returns ecliptic position of planets at equinox and ecliptic of date.
--
-- Param NUMERIC - jde - the date for which positions are desired.
-- Returns
--     coordinates - Results are positions consistent with those from Meeus's
--                   Apendix III, that is, at equinox and ecliptic of date.
--         lon - heliocentric longitude in radians.
--         lat - heliocentric latitude in radians.
--         range - heliocentric range in AU.
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.planet_position(
	p_planet_name TEXT,
	p_jde NUMERIC
)
RETURNS astronomia.ecliptic_coordinates
AS $$

DECLARE
	t_ecl_from astronomia.ecliptic_coordinates%rowtype := astronomia.planet_position2000(p_planet_name, p_jde);
	t_epoch_from NUMERIC := 2000.0;
	t_epoch_to NUMERIC := astronomia.jde_to_julian_year(p_jde);
	t_ecl_to astronomia.ecliptic_coordinates%rowtype := astronomia.precess_ecliptic_position(t_ecl_from, t_epoch_from, t_epoch_to, 0, 0);
	t_coordinates astronomia.ecliptic_coordinates%rowtype := (
		t_ecl_to.longitude,
		t_ecl_to.latitude,
		t_ecl_from.range_value
	);

BEGIN
	--RAISE EXCEPTION 'planet_position: p_planet_name: %; p_jde: %; t_ecl_from: %; t_ecl_to: %;', p_planet_name, p_jde, t_ecl_from, t_ecl_to;
	RETURN t_coordinates;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
