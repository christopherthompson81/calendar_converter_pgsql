-------------------------------------------------------------------------------
-- get major solar term `Z1...Z12` for a given date in JDE
--
-- p_jde - date of new moon
-- Returns t_chinese_solar_term - major solar term part of that month
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.find_chinese_major_solar_term(
	p_jde NUMERIC
)
RETURNS calendars.chinese_solar_term
AS $$

DECLARE
	-- Coefficient to convert radians to degrees
	R2D CONSTANT NUMERIC := 180 / PI();

	-- longitudinal parameters
	t_longitude NUMERIC := calendars.get_longitude(p_jde + 1);
	t_longitude_degrees NUMERIC := t_longitude * R2D - (1 * (10 ^ -13));
	t_term INTEGER := (2 + FLOOR(t_longitude_degrees / 30)) % 12 + 1;
	t_chinese_solar_term calendars.chinese_solar_term%rowtype := (t_term, t_longitude);

BEGIN
	RETURN t_chinese_solar_term;
END;

$$ LANGUAGE plpgsql;