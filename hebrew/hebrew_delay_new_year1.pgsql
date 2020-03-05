-------------------------------------------------------------------------------
-- Test for delay of start of Hebrew new year and to avoid Sunday, Wednesday,
-- and Friday as start of the new year.
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_delay_new_year1(
	p_year INTEGER
)
RETURNS INTEGER AS $$

DECLARE
	t_months NUMERIC := TRUNC(((235 * p_year) - 234) / 19);
	t_parts NUMERIC := 12084 + (13753 * t_months);
	t_day NUMERIC := TRUNC((t_months * 29) + t_parts / 25920);

BEGIN
	IF ((3 * (t_day + 1)) % 7) < 3 THEN
		t_day := t_day + 1;
	END IF;
	RETURN t_day::INTEGER;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
