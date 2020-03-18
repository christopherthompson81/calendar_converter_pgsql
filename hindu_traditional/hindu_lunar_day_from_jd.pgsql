-------------------------------------------------------------------------------
-- Hindu lunar day (tithi) at sunrise for given date and place. Also returns
-- tithi's end time.
--
-- Tithi doesn't depend on Ayanamsa
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_lunar_day_from_jd(
	p_jd NUMERIC
)
RETURNS SETOF calendars.hindi_lunar_day AS $$

DECLARE
	--tz NUMERIC := place.timezone;
	-- 1. Find time of sunrise; [0] - tz / 24
	t_sunrise NUMERIC := astronomia.sunrise(p_jd);
	-- 2. Find tithi at this JDN
	t_moon_phase NUMERIC := calendars.hindu_lunar_phase(t_sunrise);
	today NUMERIC := CEILING(moon_phase / 12);
	degrees_left NUMERIC := today * 12 - moon_phase;
	-- 3. Compute longitudinal differences at intervals of 0.25 days from sunrise
	offsets NUMERIC[] := ARRAY[0.25, 0.5, 0.75, 1.0];
	relative_motion NUMERIC[] := (
		SELECT ARRAY(
			((calendars.hindu_lunar_longitude(t_sunrise + t) - calendars.hindu_lunar_longitude(t_sunrise)) % 360) -
			((calendars.hindu_solar_longitude(t_sunrise + t) - calendars.hindu_solar_longitude(t_sunrise)) % 360)
		)
		FROM (SELECT unnest(offsets) AS t)
	);
	-- 4. Find end time by 4-point inverse Lagrange interpolation
	y NUMERIC[] := relative_motion;
	x NUMERIC[] := offsets;
	-- compute fraction of day (after sunrise) needed to traverse 'degrees_left'
	approx_end NUMERIC := astronomia.inverse_lagrange(x, y, degrees_left);
	-- + tz
	ends NUMERIC := (t_sunrise + approx_end - p_jd) * 24;
	answer calendars.hindi_lunar_day := (today::INTEGER, astronomia.deg_to_dms(ends));
	-- 5. Check for skipped tithi
	moon_phase_tmrw NUMERIC := calendars.hindu_lunar_phase(t_sunrise + 1);
	tomorrow NUMERIC := CEILING(moon_phase_tmrw / 12);
	is_skipped BOOLEAN := (tomorrow - today) % 30 > 1;
	leap_tithi NUMERIC := today + 1;

BEGIN
	RETURN NEXT answer;
	IF is_skipped THEN
		-- interpolate again with same (x,y)
		degrees_left := leap_tithi * 12 - moon_phase;
		approx_end := inverse_lagrange(x, y, degrees_left)
		-- + place.timezone;
		ends := (t_sunrise + approx_end - p_jd) * 24;
		leap_tithi := (CASE WHEN today = 30 THEN 1 ELSE today + 1 END);
		answer := (leap_tithi::INTEGER, deg_to_dms(ends));
		RETURN NEXT answer;
	END IF;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;