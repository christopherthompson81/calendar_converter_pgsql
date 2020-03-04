-------------------------------------------------------------------------------
-- Get solar term from solar longitude
--
-- term - jiéqì solar term 1 .. 24
-- [gyear] - (int) gregorian year (optional)
-- Returns JDE at midnight
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_chinese_solar_term(
	p_term INTEGER,
	p_g_year INTEGER = NULL,
	p_c_date calendars.chinese_date = NULL
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Coefficient to convert radians to degrees
	R2D CONSTANT NUMERIC := 180 / PI();

	-- Holding variables
	t_g_year INTEGER := p_g_year;
	t_years INTEGER;
	t_longitude NUMERIC;
	t_solar_term NUMERIC;

BEGIN
	IF p_g_year IS NULL AND p_c_date IS NULL THEN
		RAISE EXCEPTION 'Either a Gregorian year or a Chinese date must be provided';
	END IF;
	IF t_g_year IS NOT NULL AND p_term <= 3 THEN
		t_g_year := t_g_year - 1;
	END IF;
	IF t_g_year IS NOT NULL THEN
		t_years := t_g_year;
	ELSE
		t_years := calendars.gregorian_year_from_chinese_epoch_cycle(p_c_date.cycle, p_c_date.year);
	END IF;
	t_longitude := (((p_term + 20) % 24) * 15) % 360;
	t_solar_term := astronomia.solstice_longitude(t_years, 'earth', t_longitude / R2D);
	t_solar_term := calendars.beijing_midnight(t_solar_term);
	RETURN t_solar_term;
END;

$$ LANGUAGE plpgsql;