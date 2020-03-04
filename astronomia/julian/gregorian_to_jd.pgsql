-------------------------------------------------------------------------------
-- Base conversion from gregorian date to julian day
--
-- The to_char(TIMESTAMP, 'J') method might work instead
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.gregorian_to_jd(
	p_date TIMESTAMP
)
RETURNS NUMERIC
AS $$

DECLARE
	t_y INTEGER := DATE_PART('year', p_date);
	t_m INTEGER := DATE_PART('month', p_date);
	t_d INTEGER := DATE_PART('day', p_date);
	t_h INTEGER := DATE_PART('hours', p_date);
	t_min INTEGER := DATE_PART('minutes', p_date);
	t_s INTEGER := DATE_PART('seconds', p_date);
	t_ms INTEGER := DATE_PART('milliseconds', p_date);
	t_jd NUMERIC;

BEGIN
	t_jd := astronomia.calendar_to_jd(ARRAY[t_y, t_m, t_d, t_h, t_min, t_s, t_ms, 0]);
	RETURN t_jd;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
