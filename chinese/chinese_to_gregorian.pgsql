-------------------------------------------------------------------------------
-- convert chinese date to gregorian date
--
-- p_g_year - (int) gregorian year
-- Return date in gregorian (preleptic) calendar;
-- Timezone is irrelevant (original indicated Standard Chinese / Bejing Time)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.chinese_to_gregorian(
	p_c_date calendars.chinese_date,
	p_g_year INTEGER = NULL
)
RETURNS DATE
AS $$

DECLARE
	t_jde NUMERIC := calendars.chinese_to_jde(p_c_date, p_g_year);
	-- add 0.5 as day get truncated
	t_date DATE := astronomia.jde_to_gregorian(t_jde + 0.5)::DATE;

BEGIN
	RETURN t_date;
END;

$$ LANGUAGE plpgsql;
