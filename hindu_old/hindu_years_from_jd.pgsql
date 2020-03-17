-------------------------------------------------------------------------------
-- Find the Hindu year values for Saka era, Vikrama Samvat, and Kali Yuga
-- epochs
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_years_from_jd(
	p_jd NUMERIC
)
RETURNS INTEGER[] AS $$

DECLARE
	sidereal_year NUMERIC := 365.256360417;
	ahargana NUMERIC := calendars.jd_to_kyd(p_jd);
	maasa_num INTEGER := calendars.hindu_lunar_month_from_jd(p_jd);
	kali INTEGER := (ahargana + (4 - maasa_num) * 30) / sidereal_year;
	saka INTEGER := kali - 3179;
	vikrama INTEGER := saka + 135;

BEGIN
	RETURN ARRAY[saka, vikrama, kali];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;