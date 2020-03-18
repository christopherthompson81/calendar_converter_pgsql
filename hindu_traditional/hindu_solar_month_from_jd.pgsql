-------------------------------------------------------------------------------
-- Find the Hindu solar month (raasi) for a JD
--
-- Zodiac of given jd. 1 = Mesha, ... 12 = Meena
-- 12 rasis occupy 360 degrees, so each one is 30 degrees
-- solar_nirayana = solar_longitude
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_solar_month_from_jd(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	t_solar_longitude := astronomia.solar_longitude(p_jd);
	solar_month INTEGER := CEILING(t_solar_longitude / 30);

BEGIN
	RETURN solar_month;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
