-------------------------------------------------------------------------------
-- Accurate calculation of solstices / equinoxes
-- Result is accurate to one second of time.
--
-- Param INTEGER p_year
-- Param TEXT p_planet_name
-- Param NUMERIC p_longitude - longitude in radians
-- Param NUMERIC[] c - term from table 27.a / 27.b
-- Returns NUMERIC JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.equinox2(
	p_year INTEGER,
	p_planet_name TEXT,
	p_longitude NUMERIC,
	p_c NUMERIC[]
)
RETURNS NUMERIC
AS $$

DECLARE
	J0 NUMERIC := astronomia.horner(p_year * 0.001, p_c);
	t_c NUMERIC;
	t_ecl astronomia.ecliptic_coordinates%rowtype;
	t_i INTEGER := 1;

BEGIN
	LOOP
		t_ecl := astronomia.solar_apparent_vsop87(p_planet_name, J0);
		-- (27.1) p. 180
		t_c := 58.0 * SIN(p_longitude - t_ecl.longitude);
		J0 := J0 + t_c;
		EXIT WHEN ABS(t_c) < 0.000005;
	END LOOP;
	--RAISE EXCEPTION 'equinox2: p_year: %; p_c: %; t_ecl: %; J0: %', p_year, p_c, t_ecl, J0;
	RETURN J0;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
