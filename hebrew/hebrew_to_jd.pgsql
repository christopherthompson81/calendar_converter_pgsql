-------------------------------------------------------------------------------
-- Get a Julian day count from a Hebrew date
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_to_jd(
	p_hebrew calendars.date_parts
)
RETURNS NUMERIC AS $$

DECLARE
	-- Constants
	EPOCH NUMERIC := 347995.5;
	-- Vars
	t_months INTEGER := calendars.hebrew_year_months(p_hebrew.year_value);
	t_jd NUMERIC := (
		EPOCH +
		calendars.hebrew_delay_new_year1(p_hebrew.year_value) +
		calendars.hebrew_delay_new_year2(p_hebrew.year_value) +
		p_hebrew.day_value +
		1
	);
	t_month INTEGER;

BEGIN
	IF p_hebrew.month_value < 7 THEN
		FOR t_month IN 7..(t_months) LOOP
			t_jd := t_jd + calendars.hebrew_month_days(p_hebrew.year_value, t_month);
		END LOOP;
		FOR t_month IN 1..(p_hebrew.month_value - 1) LOOP
			t_jd := t_jd + calendars.hebrew_month_days(p_hebrew.year_value, t_month);
		END LOOP;
	ELSE
		FOR t_month IN 7..(p_hebrew.month_value - 1) LOOP
			t_jd := t_jd + calendars.hebrew_month_days(p_hebrew.year_value, t_month);
		END LOOP;
	END IF;

	RETURN TRUNC(t_jd) + 0.5;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
