-------------------------------------------------------------------------------
-- Test if date `jde` is inside a leap month
-- `jde` and prior new moon need to have the same major solar term
--
-- jde - date of new moon
-- Returns BOOLEAN TRUE if previous new moon falls into same solar term
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.jde_is_chinese_leap_month(
	p_jde NUMERIC
)
RETURNS BOOLEAN
AS $$

DECLARE
	-- Constants
	MEAN_LUNAR_MONTH NUMERIC := astronomia.get_constant('mean_lunar_month');
	LUNAR_OFFSET NUMERIC := MEAN_LUNAR_MONTH / 2.0;

	t_t1 calendars.chinese_solar_term%rowtype := calendars.find_chinese_major_solar_term(p_jde);
	t_prior NUMERIC := calendars.get_previous_new_moon(calendars.beijing_midnight(p_jde + LUNAR_OFFSET));
	t_t2 calendars.chinese_solar_term%rowtype := calendars.find_chinese_major_solar_term(t_prior);
	t_is_leap BOOLEAN := t_t1.term = t_t2.term;

BEGIN
	--RAISE EXCEPTION 't_t1: %; t_t2: %; t_is_leap: %', t_t1, t_t2, t_is_leap;
	RETURN t_is_leap;
END;

$$ LANGUAGE plpgsql;
