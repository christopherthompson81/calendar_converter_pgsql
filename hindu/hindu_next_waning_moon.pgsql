-------------------------------------------------------------------------------
-- Find the next waning (quarter) moon after a given JDE (stored in seconds)
-- 
-- INACCURATE: Hindu calendars use some sort of sunrise / sunset rule instead
-- of using midnight local time. This can return a result that's a day late.
--
-- Returns the JDE of the instant of the closest waning moon forward (at
-- midnight UTC, shifted by beijing timezone)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.hindu_next_waning_moon(
	p_hindu calendars.date_parts
)
RETURNS DATE
AS $$

DECLARE
	-- Constants
	SAKA_EPOCH INTEGER := 78;
	LUNAR_OFFSET NUMERIC := astronomia.get_constant('mean_lunar_month') / 2;
	-- +5:30 hours (India time zone)
	HINDU_TIME_SHIFT NUMERIC := 5.5;

	-- Vars
	t_hindu calendars.date_parts;
	t_calendar NUMERIC[];
	t_jde NUMERIC;
	t_next_waning_moon NUMERIC;
	t_count INTEGER := 0;

BEGIN
	-- Make sure the target year aligns
	t_hindu := (p_hindu.year_value - SAKA_EPOCH, p_hindu.month_value, p_hindu.day_value);
	t_calendar := astronomia.jd_to_calendar(calendars.hindu_to_jd(t_hindu));
	IF t_calendar[1] != p_hindu.year_value THEN
		t_hindu.year_value := p_hindu.year_value - SAKA_EPOCH - 1;
	END IF;
	t_jde := astronomia.jd_to_jde(calendars.hindu_to_jd(t_hindu));
	-- JDE at midnight
	t_next_waning_moon := calendars.midnight_offset(
		astronomia.moonphase_last_quarter_moon(
			astronomia.jde_to_julian_year(
				t_jde
			)
		),
		HINDU_TIME_SHIFT
	);
	LOOP
		t_count := t_count + 1;
		EXIT WHEN t_next_waning_moon >= t_jde OR t_count >= 4;
		t_next_waning_moon := calendars.midnight_offset(
			astronomia.moonphase_last_quarter_moon(
				astronomia.jde_to_julian_year(
					t_jde + t_count * LUNAR_OFFSET
				)
			),
			HINDU_TIME_SHIFT
		);
	END LOOP;
    RETURN astronomia.jde_to_gregorian(t_next_waning_moon)::DATE;
END;

$$ LANGUAGE plpgsql;