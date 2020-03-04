-------------------------------------------------------------------------------
-- Chinese new year for a given gregorian year
--
-- Returns JDE value
--
-- FROM: https://en.wikipedia.org/wiki/Chinese_calendar
--
-- The calendar solar year, known as the suì, (歲; 岁) begins at the December
-- solstice and proceeds through the 24 solar terms. Due to the fact that
-- the speed of the Sun's apparent motion in the elliptical is variable, the
-- time between major solar terms is not fixed. This variation in time between
-- major solar terms results in different solar year lengths. There are
-- generally 11 or 12 complete months, plus two incomplete months around the
-- winter solstice, in a solar year. The complete months are numbered from 0 to
-- 10, and the incomplete months are considered the 11th month. If there are 12
-- complete months in the solar year, it is known as a leap solar year, or leap
-- suì.
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_chinese_new_year(
	p_g_year INTEGER
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	MEAN_LUNAR_MONTH NUMERIC := astronomia.get_constant('mean_lunar_month');
	LUNAR_OFFSET NUMERIC := MEAN_LUNAR_MONTH / 2.0;

	-- JDE at midnight
	t_new_year NUMERIC;
	-- JDE at instant
	winter_solstice1 NUMERIC;
	winter_solstice2 NUMERIC;
	-- Month Starts in JDE
	month11n NUMERIC;
	month12 NUMERIC;
	month13 NUMERIC;
	-- Leap sui
	t_leap_sui BOOLEAN;

BEGIN
	-- If we've already done this, return the stored value
	SELECT
		jde
	INTO
		t_new_year
	FROM
		calendars.chinese_new_year_cache
	WHERE
		gregorian_year = p_g_year;

	IF t_new_year IS NOT NULL THEN
		RETURN t_new_year;
	END IF;
	
	-- Otherwise, derive the date
	winter_solstice1 := calendars.get_winter_solstice(p_g_year - 1);
	winter_solstice2 := calendars.get_winter_solstice(p_g_year);

	month11n := calendars.get_previous_new_moon(
		calendars.beijing_midnight(
			winter_solstice2 + 1
		)
	);
	
	month12 := calendars.get_next_new_moon(
		calendars.beijing_midnight(
			winter_solstice1 + 1
		)
	);

	month13 := calendars.get_next_new_moon(
		calendars.beijing_midnight(
			month12 + LUNAR_OFFSET
		)
	);

	t_leap_sui := ROUND((month11n - month12) / MEAN_LUNAR_MONTH, 0) = 12;
	t_new_year := month13;

	IF t_leap_sui
	AND
	(
		calendars.jde_is_chinese_leap_month2(month12)
	OR
		calendars.jde_is_chinese_leap_month2(month13)
	)
	THEN
		t_new_year := calendars.get_next_new_moon(
			calendars.beijing_midnight(
				month13 + LUNAR_OFFSET
			)
		);
	END IF;

	-- ... and cache it
	INSERT INTO
		calendars.chinese_new_year_cache(
			gregorian_year,
			jde
		)
	VALUES(
		p_g_year,
		t_new_year
	)
	ON CONFLICT DO NOTHING;

	RETURN t_new_year;
END;

$$ LANGUAGE plpgsql;