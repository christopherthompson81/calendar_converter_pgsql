-------------------------------------------------------------------------------
-- Get a Hebrew date from Julian Days
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_from_jd(
	p_jd NUMERIC
)
RETURNS calendars.date_parts AS $$

DECLARE
	-- Constants
	EPOCH NUMERIC := 347995.5;
	-- Vars
	t_jd NUMERIC := TRUNC(p_jd) + 0.5;
	t_count NUMERIC := TRUNC(((t_jd - EPOCH) * 98496.0) / 35975351.0);
	i INTEGER := t_count;
	t_first INTEGER;
	t_year INTEGER := t_count - 1;
	t_month INTEGER;
	t_day INTEGER;
	t_date_parts calendars.date_parts%rowtype;

BEGIN
	LOOP
		EXIT WHEN t_jd < calendars.hebrew_to_jd(i, 7, 1);
		i := i + 1;
		t_year := t_year + 1;
	END LOOP;

	IF t_jd < calendars.hebrew_to_jd(t_year, 1, 1) THEN
		t_first := 7;
	ELSE
		t_first := 1;
	END IF;

	i := t_first;
	t_month := t_first;
	LOOP
		EXIT WHEN t_jd <= calendars.hebrew_to_jd(t_year, i, calendars.hebrew_month_days(t_year, i));
		i := i + 1;
		t_month := t_month + 1;
	END LOOP;

	t_day := (t_jd - calendars.hebrew_to_jd(t_year, t_month, 1))::INTEGER + 1;

	t_date_parts.year_value := t_year;
	t_date_parts.month_value := t_month;
	t_date_parts.day_value := t_day;
	return t_date_parts;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
