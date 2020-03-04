-------------------------------------------------------------------------------
-- Convert gregorian date to chinese calendar date
--
-- year - year in Gregorian or Julian Calendar
-- month
-- day - needs to be in correct (chinese) timezone
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.chinese_date_from_jde_and_year(
	p_jde NUMERIC,
	p_g_year INTEGER
)
RETURNS calendars.chinese_date
AS $$

DECLARE
	-- Constants
	CHINESE_EPOCH NUMERIC := calendars.get_constant('chinese', 'chinese_calendar_jd_epoch');
	BESSELIAN_YEAR_DAYS NUMERIC := astronomia.get_constant('besselian_year_days');
	MEAN_LUNAR_MONTH NUMERIC := astronomia.get_constant('mean_lunar_month');
	LUNAR_OFFSET NUMERIC := MEAN_LUNAR_MONTH / 2.0;

	-- Date Parameters
	t_new_year NUMERIC := calendars.get_chinese_new_year(p_g_year);
	t_new_moon NUMERIC := calendars.get_previous_new_moon(p_jde);
	t_years NUMERIC;
	t_cycle INTEGER;
	t_year INTEGER;
	t_month INTEGER; 
	t_new_year_new_moon_month_delta INTEGER;
	t_leap BOOLEAN := FALSE;
	t_day INTEGER;

	-- Chinese Date
	t_c_date calendars.chinese_date%rowtype;

BEGIN
	IF TRUNC(t_new_year, 3) > TRUNC(p_jde, 3) THEN
		t_new_year := calendars.get_chinese_new_year(p_g_year - 1);
	END IF;
	IF t_new_moon < t_new_year THEN
		t_new_moon := t_new_year;
	END IF;
	t_years := 1.5 + (t_new_year - CHINESE_EPOCH) / BESSELIAN_YEAR_DAYS;
	-- +1 removed during porting
	t_cycle := 1 + TRUNC((t_years - 1) / 60);
	-- +1 removed during porting
	t_year := 1 + TRUNC((t_years - 1) % 60);
	t_month := (SELECT term FROM calendars.find_chinese_major_solar_term(t_new_moon));
	t_new_year_new_moon_month_delta := ROUND((t_new_moon - t_new_year) / MEAN_LUNAR_MONTH, 0);
	IF t_new_year_new_moon_month_delta = 0 THEN
		t_month := 1;
	ELSE
		t_leap := calendars.jde_is_chinese_leap_month(t_new_moon);
	END IF;

	IF t_new_year_new_moon_month_delta > t_month THEN
		t_month := t_new_year_new_moon_month_delta;
	ELSIF t_leap THEN
		t_month := t_month - 1;
	END IF;

	t_day := (1 + TRUNC(p_jde, 3) - TRUNC(t_new_moon, 3))::INTEGER;

	-- Chinese Date
	t_c_date := (
		t_cycle,
		t_year,
		t_month,
		t_leap,
		t_day
	);

	RETURN t_c_date;
END;

$$ LANGUAGE plpgsql;
