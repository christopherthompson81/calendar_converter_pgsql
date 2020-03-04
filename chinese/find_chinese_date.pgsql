-------------------------------------------------------------------------------
-- Function to find a DATE associated with a mix of Gregorian and Chinese inputs
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
CREATE OR REPLACE FUNCTION calendars.find_chinese_date(
	g_year INTEGER = NULL,
	c_cycle INTEGER = NULL,
	c_year INTEGER = NULL,
	c_lunar_month INTEGER = NULL,
	c_solarterm INTEGER = NULL,
	c_leap_month BOOLEAN = NULL,
	c_day INTEGER = NULL,
	solarterm BOOLEAN = NULL
)
RETURNS DATE
AS $$

DECLARE
	t_jde NUMERIC;
	t_date DATE;

BEGIN
	t_jde := calendars.find_chinese_jde(
		g_year => g_year,
		c_cycle => c_cycle,
		c_year => c_year,
		c_lunar_month => c_lunar_month,
		c_solarterm => c_solarterm,
		c_leap_month => c_leap_month,
		c_day => c_day,
		solarterm => solarterm
	);
	RETURN astronomia.jde_to_gregorian(t_jde)::DATE;
END;

$$ LANGUAGE plpgsql;