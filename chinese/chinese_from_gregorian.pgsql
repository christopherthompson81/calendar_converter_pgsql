-------------------------------------------------------------------------------
-- Convert gregorian date to chinese calendar date
--
-- year - year in Gregorian or Julian Calendar
-- month
-- day - needs to be in correct (chinese) timezone
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.chinese_from_gregorian(
	p_date DATE
)
RETURNS calendars.chinese_date
AS $$

DECLARE
	t_jde NUMERIC := calendars.beijing_midnight(astronomia.gregorian_to_jde(p_date));
	t_year INTEGER := DATE_PART('year', p_date)::INTEGER;
	t_c_date calendars.chinese_date%rowtype;

BEGIN
	-- Chinese new year never starts before 20/01
	IF DATE_PART('month', p_date)::INTEGER = 1 AND DATE_PART('day', p_date)::INTEGER <= 20 THEN
		t_year := t_year - 1;
	END IF;
	t_c_date := calendars.chinese_date_from_jde_and_year(t_jde, t_year);
	RETURN t_c_date;
END;

$$ LANGUAGE plpgsql;
