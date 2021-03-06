-------------------------------------------------------------------------------
-- Convert Jalali date to Julian date.
--
-- Ported From:
-- https://github.com/pylover/khayyam/tree/master/khayyam
--
-------------------------------------------------------------------------------
--def get_julian_day_from_jalali_date(year, month, day):
--    base = year - ([473, 474][year >= 0])
--    julian_year = 474 + (base % 2820)
--    return day + ([((month - 1) * 30) + 6, (month - 1) * 31][month <= 7]) + floor(
--        ((julian_year * 682) - 110) / 2816) + (julian_year - 1) * 365 + floor(base / 2820) * 1029983 + (1948320.5 - 1)
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.jalali_to_julian(p_year INTEGER, p_month INTEGER, p_day INTEGER)
RETURNS INTEGER AS $$

DECLARE	
	-- to Julian Day Conversion Variables
	t_base INTEGER;
	t_julian_year INTEGER;
	t_jd INTEGER;

BEGIN
	-- Convert Jalali to Julian Day
	IF p_year >= 0 THEN	
		t_base := p_year - 474;
	ELSE
		t_base := p_year - 473;
	END IF;
	t_julian_year := 474 + (t_base % 2820);
	t_jd := p_day;
	IF p_month <= 7 THEN
		t_jd := t_jd + (p_month - 1) * 31;
	ELSE
		t_jd := t_jd + ((p_month - 1) * 30) + 6;
	END IF;
	t_jd := t_jd + FLOOR(((t_julian_year * 682) - 110) / 2816);
	t_jd := t_jd + (t_julian_year - 1) * 365;
	t_jd := t_jd + FLOOR(t_base / 2820) * 1029983;
	t_jd := t_jd + 1948320.5 - 1;

	RETURN t_jd;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
