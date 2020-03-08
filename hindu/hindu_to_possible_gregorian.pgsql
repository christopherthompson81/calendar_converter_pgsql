-------------------------------------------------------------------------------
-- Obtain Indian Civil Date from Calendar Array
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.hindu_to_possible_gregorian(
	p_g_year INTEGER,
	p_h_month INTEGER,
	p_h_day INTEGER
)
RETURNS DATE
AS $$

DECLARE
	t_jd1 NUMERIC := astronomia.gregorian_to_jd(make_date(p_g_year, 1, 1)::TIMESTAMP);
	t_date_parts1 calendars.date_parts%rowtype := calendars.hindu_from_jd(t_jd1);
	t_h_year INTEGER := t_date_parts1.year_value;
	t_date_parts2 calendars.date_parts%rowtype := (t_h_year, p_h_month, p_h_day);
	t_jd2 NUMERIC := calendars.hindu_to_jd(t_date_parts2);
	t_calendar NUMERIC[] := astronomia.jd_to_calendar(t_jd2);
	t_date DATE;

BEGIN
	IF t_calendar[1] != p_g_year THEN
		-- The year did not align, move the Hindu year forward 1
		t_date_parts2 := (t_h_year + 1, p_h_month, p_h_day);
		t_jd2 := calendars.hindu_to_jd(t_date_parts2);
	END IF;
	RETURN astronomia.jd_to_gregorian(t_jd2)::DATE;
END;

$$ LANGUAGE plpgsql;