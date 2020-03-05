-------------------------------------------------------------------------------
-- Base conversion from julian date to julian day
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.julian_to_jd(
	p_date DATE
)
RETURNS NUMERIC
AS $$

DECLARE
	t_y INTEGER := DATE_PART('year', p_date);
	t_m INTEGER := DATE_PART('month', p_date);
	t_d INTEGER := DATE_PART('day', p_date);
	t_a INTEGER;
	t_b INTEGER := 0;
	t_jd NUMERIC;

BEGIN
	IF t_m < 3 THEN
		t_y := t_y - 1;
		t_m := t_m + 12;
	END IF;
	t_a := t_y / 100;
	t_b := 2 - t_a + (t_a / 4);
	-- (7.1) p. 61
	t_jd := ((36525 * (t_y + 4716)) / 100) +
		((306 * (t_m + 1)) / 10) +
		t_b +
		t_d -
		1524.5;
	RETURN t_jd;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
