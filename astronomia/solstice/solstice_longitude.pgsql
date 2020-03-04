-------------------------------------------------------------------------------
-- Longitude returns the JDE for a given `year`, VSOP87 Planet `planet` at a
-- given geocentric solar longitude `lon`
--
-- Param INTEGER p_year
-- Param TEXT p_planet_name
-- Param NUMERIC p_longitude - geocentric solar longitude in radians
-- Returns NUMERIC p_jde
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.solstice_longitude(
	p_year INTEGER,
	p_planet_name TEXT,
	p_longitude NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	-- table 27.a - for years from -1000 to +1000
	mc0 NUMERIC[] := ARRAY[1721139.29189, 365242.13740, 0.06134, 0.00111, -0.00071];
	jc0 NUMERIC[] := ARRAY[1721233.25401, 365241.72562, -0.05323, 0.00907, 0.00025];
	sc0 NUMERIC[] := ARRAY[1721325.70455, 365242.49558, -0.11677, -0.00297, 0.00074];
	dc0 NUMERIC[] := ARRAY[1721414.39987, 365242.88257, -0.00769, -0.00933, -0.00006];
	-- table 27.b - for years from +1000 to +3000
	mc2 NUMERIC[] := ARRAY[2451623.80984, 365242.37404, 0.05169, -0.00411, -0.00057];
	jc2 NUMERIC[] := ARRAY[2451716.56767, 365241.62603, 0.00325, 0.00888, -0.00030];
	sc2 NUMERIC[] := ARRAY[2451810.21715, 365242.01767, -0.11575, 0.00337, 0.00078];
	dc2 NUMERIC[] := ARRAY[2451900.05952, 365242.74049, -0.06223, -0.00823, 0.00032];
	
	-- Vars
	c NUMERIC[];
	t_year INTEGER := p_year;
	t_longitude NUMERIC := p_longitude;
	t_j0 NUMERIC;

BEGIN
	IF t_year < 1000 THEN
		IF t_longitude < (PI() / 2) THEN
			c := mc0;
		ELSIF t_longitude < PI() THEN
			c := jc0;
		ELSIF t_longitude < (PI() * 3 / 2) THEN
			c := sc0;
		ELSE
			c := dc0;
		END IF;
	ELSE
		IF t_longitude < (PI() / 2) THEN
			c := mc2;
		ELSIF t_longitude < PI() THEN
			c := jc2;
		ELSIF t_longitude < (PI() * 3 / 2) THEN
			c := sc2;
		ELSE
			c := dc2;
		END IF;
		t_year := t_year - 2000;
	END IF;
	t_longitude := t_longitude % (PI() * 2)::NUMERIC;
	t_j0 := astronomia.equinox2(t_year, p_planet_name, t_longitude, c);
	--RAISE EXCEPTION 'solstice_longitude: t_j0: %', t_j0;
	RETURN t_j0;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
