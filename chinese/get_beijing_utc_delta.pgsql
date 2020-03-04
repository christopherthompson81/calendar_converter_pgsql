-------------------------------------------------------------------------------
-- Timeshift from Beijing to UTC in a fraction of day (year sensitive)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_beijing_utc_delta(
	p_year INTEGER
)
RETURNS NUMERIC
AS $$

DECLARE
	t_day_fraction NUMERIC;

BEGIN
	IF p_year >= 1929 THEN
		-- +8:00:00h Standard China time zone (120° East)
		t_day_fraction := 8.0 / 24.0;
	ELSE
		-- +7:45:40h Beijing (116°25´ East)
		t_day_fraction := 1397.0 / 180.0 / 24.0;
	END IF;
	RETURN t_day_fraction;
END;

$$ LANGUAGE plpgsql;