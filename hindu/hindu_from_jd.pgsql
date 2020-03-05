-------------------------------------------------------------------------------
-- Calculate Indian Civil date from Julian day
-- Offset in years from Saka era to Gregorian epoch
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.hindu_from_jd(
	p_jd NUMERIC
)
RETURNS calendars.date_parts
AS $$

DECLARE
	-- Constants
	SAKA_EPOCH INTEGER := 78;
	-- Day offset between Saka and Gregorian
	SAKA_DAY_DELTA INTEGER := 80;
	-- Vars
	t_jd NUMERIC := trunc(p_jd) + 0.5;
	-- Gregorian date for Julian day
	t_calendar NUMERIC[] := astronomia.jd_to_calendar(t_jd);
	-- Is this a leap year?
	t_leap BOOLEAN := astronomia.leap_year_gregorian(t_calendar[1]);
	-- JD at start of Gregorian year
	t_calendar0 NUMERIC[] := astronomia.calendar_to_jd(ARRAY[t_calendar[1], 1, 1, 0, 0, 0, 0]::NUMERIC[]);
	-- Day number (0 based) in Gregorian year
	t_year_day NUMERIC := t_jd - t_calendar0;
	-- Days in Caitra this year
	t_caitra INTEGER := (CASE WHEN t_leap THEN 31 ELSE 30 END);
	-- Month Day (tentative)
	t_month_day INTEGER := t_year_day - t_caitra;
	-- Tentative year in Saka era
	t_year INTEGER := t_calendar[1] - SAKA_EPOCH;
	t_month INTEGER;
	t_day NUMERIC;
	t_date_parts calendars.date_parts%rowtype;

BEGIN
	IF t_year_day < SAKA_DAY_DELTA THEN
		-- Day is at the end of the preceding Saka year
		t_year := t_year - 1;
		t_year_day := t_year_day + t_caitra + (31 * 5) + (30 * 3) + 10 + SAKA_DAY_DELTA;
	END IF;
	t_year_day := t_year_day - SAKA_DAY_DELTA;
	IF t_year_day < t_caitra THEN
		t_month := 1;
		t_day := t_year_day + 1;
	ELSE
		IF t_month_day < (31 * 5) THEN
			t_month := TRUNC(t_month_day / 31) + 2;
			t_day := (t_month_day % 31) + 1;
		ELSE
			t_month_day := t_month_day - 31 * 5;
			t_month := TRUNC(t_month_day / 30) + 7;
			t_day := (t_month_day % 30) + 1;
		END IF;
	END IF;
	t_date_parts.year_value := t_year;
	t_date_parts.month_value := t_month;
	t_date_parts.day_value := t_day::INTEGER;
	RETURN t_date_parts;
END;

$$ LANGUAGE plpgsql;