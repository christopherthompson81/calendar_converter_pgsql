-------------------------------------------------------------------------------
-- convert JDE to chinese calendar date
--
-- jde - date in JDE
-- Return chinese_date object
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.chinese_from_jde(
	p_jde NUMERIC
)
RETURNS calendars.chinese_date
AS $$

DECLARE
	t_jde NUMERIC := calendars.beijing_midnight(p_jde);
	t_calendar NUMERIC[] := astronomia.jde_to_calendar(p_jde);
	t_year INTEGER := t_calendar[1]::INTEGER;
	t_c_date calendars.chinese_date%rowtype;

BEGIN
	-- Chinese new year never starts before 20/01
	IF t_calendar[2]::INTEGER = 1 AND t_calendar[3]::INTEGER <= 20 THEN
		t_year := t_year - 1;
	END IF;
	t_c_date := calendars.chinese_date_from_jde_and_year(t_jde, t_year);
	RETURN t_c_date;
END;

$$ LANGUAGE plpgsql;
