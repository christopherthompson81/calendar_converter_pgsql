-------------------------------------------------------------------------------
-- Obtain Julian day for Indian Civil date
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.hindu_to_jd(
	p_date_parts calendars.date_parts
)
RETURNS NUMERIC
AS $$

DECLARE
	g_year INTEGER := p_date_parts.year_value + 78;
	t_leap BOOLEAN := astronomia.leap_year_gregorian(g_year);
	t_start_day INTEGER := (CASE WHEN t_leap THEN 21 ELSE 22 END);
	t_start_jd NUMERIC := astronomia.gregorian_to_jd(make_date(g_year, 3, t_start_day));
	t_caitra INTEGER := (CASE WHEN t_leap THEN 31 ELSE 30 END);
	t_month INTEGER := MIN(p_date_parts.month_value - 2, 5);
	t_jd NUMERIC := t_start_jd + t_caitra;

BEGIN
	IF p_month = 1 THEN 
		t_jd := t_start_jd + (p_date_parts.day_value - 1);
	ELSE
		t_jd := t_start_jd + t_caitra;
		t_jd := t_jd + t_month * 31;
		IF p_date_parts.month_value >= 8 THEN
			t_month := p_date_parts.month_value - 7;
			t_jd := t_jd + t_month * 30;
		END IF;
		t_jd := t_jd + p_date_parts.day_value - 1;
	END IF;
	RETURN t_jd;
END;

$$ LANGUAGE plpgsql;