-------------------------------------------------------------------------------
-- The solar day can be found by finding the difference in days between the YTD
-- days and the days to the first of the solar month.
--
-- The year-to-date count of days is the sidereal solar year day length
-- (365.256360417) multiplied by the longitudinal ratio (180 = 0.5).
--
-- The first of each solar month is 30 degrees times the zero-indexed solar
-- month scalar, divided by 360 (for the longitudinal ratio) multiplied by the
-- sidereal year day length.
--     i.e. (30 * (raasi - 1) / 360) * 365.256360417
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_solar_day_from_jd(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	SIDEREAL_YEAR NUMERIC := 365.256360417;
	t_solar_longitude := astronomia.solar_longitude(p_jd);
	ytd_days INTEGER := CEILING(t_solar_longitude / 360 * SIDEREAL_YEAR);
	solar_month INTEGER := CEILING(t_solar_longitude / 30);
	first_of_solar_month_days INTEGER := CEILING((30 * (solar_month - 1) / 360) * SIDEREAL_YEAR);

BEGIN
	RETURN FLOOR(ytd_days - first_of_solar_month_days) + 1;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
