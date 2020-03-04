-------------------------------------------------------------------------------
-- convert chinese calendar date to JDE
--
-- input chinese date
-- input (optional) gregorian year
-- Return JDE
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.chinese_to_jde(
	p_c_date calendars.chinese_date,
	p_g_year INTEGER DEFAULT NULL
)
RETURNS NUMERIC
AS $$

DECLARE
	t_years INTEGER := (
		CASE
			WHEN p_g_year IS NOT NULL THEN
				p_g_year
			ELSE
				calendars.gregorian_year_from_chinese_epoch_cycle(p_c_date.cycle, p_c_date.year)
		END
	);
	t_new_year NUMERIC := calendars.get_chinese_new_year(t_years);
	t_new_moon NUMERIC := t_new_year;
	t_solar_term INTEGER;
	t_leap_month BOOLEAN := FALSE;
	t_jde NUMERIC;

BEGIN
	IF p_c_date.month > 1 THEN
		t_new_moon := calendars.get_previous_new_moon(t_new_year + p_c_date.month * 29);
		t_solar_term := (SELECT term FROM calendars.find_chinese_major_solar_term(t_new_moon));
		t_leap_month := calendars.jde_is_chinese_leap_month(t_new_moon);
		IF t_solar_term > p_c_date.month THEN
			t_new_moon := calendars.get_previous_new_moon(t_new_moon - 1);
		ELSIF t_solar_term < p_c_date.month OR (t_leap_month AND NOT p_c_date.leap) THEN
			t_new_moon := calendars.get_next_new_moon(t_new_moon + 1);
		END IF;
	END IF;
	--IF t_leap_month THEN
	--	t_new_moon := calendars.get_next_new_moon(t_new_moon + 1);
	--END IF;
	t_jde := t_new_moon + p_c_date.day - 1;
	RETURN t_jde;
END;

$$ LANGUAGE plpgsql;