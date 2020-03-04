-------------------------------------------------------------------------------
-- Find the previous new moon before a given JDE (stored in seconds)
-- 
-- Returns the JDE of the instant of the closest new moon prior (at midnight
-- UTC, shifted by beijing timezone)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_previous_new_moon(
	p_jde NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	LUNAR_OFFSET NUMERIC := astronomia.get_constant('mean_lunar_month') / 2;
	
	-- JDE at midnight
	t_previous_new_moon NUMERIC := calendars.beijing_midnight(
		astronomia.moonphase_new_moon(
			astronomia.jde_to_julian_year(
				p_jde
			)
		)
	);
	t_count INTEGER := 0;

BEGIN
	LOOP
		t_count := t_count + 1;
		EXIT WHEN t_previous_new_moon <= p_jde OR t_count >= 4;
		t_previous_new_moon := calendars.beijing_midnight(
			astronomia.moonphase_new_moon(
				astronomia.jde_to_julian_year(
					p_jde - t_count * LUNAR_OFFSET
				)
			)
		);
	END LOOP;
    RETURN t_previous_new_moon;
END;

$$ LANGUAGE plpgsql;
