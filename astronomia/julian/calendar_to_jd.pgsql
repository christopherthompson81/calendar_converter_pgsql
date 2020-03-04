-------------------------------------------------------------------------------
-- Convert a calendar array into julian days
-- (y,m,d,h,m,s,ms,neg)
--
-- Param - NUMERIC[] - calender array
-- Returns - NUMERIC - JD
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.calendar_to_jd(
	p_calendar NUMERIC[]
)
RETURNS NUMERIC
AS $$

DECLARE
	t_a INTEGER;
	t_b INTEGER := 0;
	-- Date
	t_year INTEGER := p_calendar[1]::INTEGER;
	t_month INTEGER := p_calendar[2]::INTEGER;
	t_day INTEGER := p_calendar[3]::INTEGER;
	-- Time
	t_hour NUMERIC := p_calendar[4];
	t_minute NUMERIC := p_calendar[5];
	t_second NUMERIC := p_calendar[6];
	t_ms NUMERIC := p_calendar[7];
	-- fractional day
	t_day_fraction NUMERIC := (t_hour + ((t_minute + ((t_second + t_ms / 1000.0) / 60.0)) / 60.0)) / 24.0;
	-- Julian Days
	t_jd NUMERIC;

BEGIN
	IF t_month < 3 THEN
		t_year := t_year - 1;
		t_month := t_month + 12;
	END IF;
	IF astronomia.is_calendar_gregorian(t_year, t_month, t_day) THEN
		t_a := FLOOR(t_year / 100.0);
		t_b := 2 - t_a + FLOOR(t_a / 4);
	END IF;
	t_jd := (
		FLOOR((36525 * (t_year + 4716)) / 100) +
		FLOOR((306 * (t_month + 1)) / 10) + t_b +
		t_day -
		1524.5 +
		t_day_fraction
	);
	RETURN t_jd;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
