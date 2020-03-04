-------------------------------------------------------------------------------
-- Position2000 returns ecliptic position of planets by full VSOP87 theory.
--
-- Param NUMERIC - jde - the date for which positions are desired.
-- Returns
--	coordinates - Results are for the dynamical equinox and ecliptic J2000.
-- 		lon - heliocentric longitude in radians.
-- 		lat - heliocentric latitude in radians.
-- 		range - heliocentric range in AU.
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.planet_position2000(
	p_planet_name TEXT,
	p_jde NUMERIC
)
RETURNS astronomia.ecliptic_coordinates
AS $$

DECLARE
	t_t NUMERIC := astronomia.j2000_century(p_jde);
	t_τ NUMERIC := t_t * 0.1;
	t_planet_l NUMERIC := astronomia.planet_position_sum('earth', t_τ, 'L');
	t_longitude NUMERIC := astronomia.pmod(t_planet_l, (2 * PI())::NUMERIC);
	t_latitude NUMERIC := astronomia.planet_position_sum('earth', t_τ, 'B');
	t_range NUMERIC := astronomia.planet_position_sum('earth', t_τ, 'R');
	t_coordinates astronomia.ecliptic_coordinates%rowtype := (t_longitude, t_latitude, t_range);

BEGIN
	--RAISE EXCEPTION 'planet_position_sum: t_planet_l: %; t_τ: %; p_jde: %', t_planet_l, t_τ, p_jde;
	RETURN t_coordinates;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
