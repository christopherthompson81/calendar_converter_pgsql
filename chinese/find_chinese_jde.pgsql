-------------------------------------------------------------------------------
-- Function to find a JDE associated with a mix of Gregorian and Chinese inputs
--
-- For example, finding the first day of first lunar month in a given gregorian year.
--{
--	p_g_year: 2020,
--	p_c_day: 1,
--	p_c_leap_month: false,
--	p_c_month: 1
--}
--
-- p_c_day INTEGER, -- Mandatory
-- p_c_leap_month BOOLEAN, -- Mandatory for lunar dates
-- p_c_month INTEGER, -- Exclusive Binary Mandatory with p_c_solarterm
-- p_c_solarterm INTEGER, -- Exclusive Binary Mandatory with p_c_month
-- p_g_year INTEGER = NULL, -- Exclusive Binary Mandatory with p_c_year & p_c_cycle
-- p_c_year INTEGER = NULL, -- Exclusive Binary Mandatory with p_g_year; Forces p_c_cycle to be mandatory
-- p_c_cycle INTEGER = NULL, -- Exclusive Binary Mandatory with p_g_year; Forces p_c_year to be mandatory
-- p_solarterm BOOLEAN = FALSE -- Optional (but must be coherent)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.find_chinese_jde(
	g_year INTEGER = NULL,
	c_cycle INTEGER = NULL,
	c_year INTEGER = NULL,
	c_lunar_month INTEGER = NULL,
	c_solarterm INTEGER = NULL,
	c_leap_month BOOLEAN = NULL,
	c_day INTEGER = NULL,
	solarterm BOOLEAN = NULL
)
RETURNS NUMERIC
AS $$

DECLARE
	t_solarterm BOOLEAN := (
		CASE
		WHEN solarterm IS NOT NULL THEN
			solarterm
		ELSE
			FALSE
		END
	);
	t_c_cycle INTEGER := c_cycle;
	t_c_year INTEGER := c_year;
	t_c_new_year calendars.chinese_date%rowtype;
	t_c_date calendars.chinese_date%rowtype;

BEGIN
	IF c_day IS NULL THEN
		RAISE EXCEPTION 'Input JSON object is missing required field: c_day'
		USING HINT = 'The Chinese day of a Chinese month (or solar term) is required.';
	END IF;
	IF NOT t_solarterm AND c_leap_month IS NULL THEN
		RAISE EXCEPTION 'Chinese date parsing conflict: c_leap_month'
		USING HINT = 'A lunar month request must include a leap month boolean.';
	END IF;
	IF NOT t_solarterm AND c_lunar_month IS NULL THEN
		RAISE EXCEPTION 'Chinese date parsing conflict: c_month'
		USING HINT = 'A lunar month request must include a lunar month value.';
	END IF;
	IF t_solarterm AND c_solarterm IS NULL THEN
		RAISE EXCEPTION 'Chinese date parsing conflict: p_solarterm: %, c_solarterm: %', t_solarterm, c_solarterm
		USING HINT = 'A solar term request must include a solar term value.';
	END IF;
	IF g_year IS NOT NULL AND (c_year IS NOT NULL OR c_cycle IS NOT NULL) THEN
		RAISE EXCEPTION 'Chinese date parsing conflict: colliding year references'
		USING HINT = 'A request with a Gregorian year cannot also include a chinese year or chinese cycle.';
	END IF;
	IF g_year IS NULL AND (c_year IS NULL OR c_cycle IS NULL) THEN
		RAISE EXCEPTION 'Chinese date parsing conflict: missing year referece'
		USING HINT = 'A request must have either a Gregorian year or both a chinese year and chinese cycle.';
	END IF;
	
	-- Find the Chinese cycle and year for a Gregorian year request
	IF g_year IS NOT NULL THEN
		-- Find Chinese New Year (plus a day to be absolutely sure)
		t_c_new_year := calendars.chinese_from_jde(calendars.get_chinese_new_year(g_year) + 1);
		t_c_cycle := t_c_new_year.cycle;
		t_c_year := t_c_new_year.year;
	END IF;
	
	IF NOT t_solarterm THEN
		-- Lunar Month Request
		t_c_date := (t_c_cycle, t_c_year, c_lunar_month, c_leap_month, c_day);
		RETURN calendars.chinese_to_jde(t_c_date);
	ELSE
		-- Solar Term Request
		t_c_date := (t_c_cycle, t_c_year, 1, FALSE, 1);
		RETURN calendars.get_chinese_solar_term(c_solarterm, p_c_date => t_c_date);
	END IF;
END;

$$ LANGUAGE plpgsql;