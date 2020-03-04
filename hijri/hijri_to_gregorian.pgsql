-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Convert Hijri date to Gregorian date.
-- 
-- Earliest possible return is from 1343-01-01, which will return 1924-08-01
--
-- Latest possible return is from the first month of 1501.
-- 1501-01-01 will return 2077-11-17
--
-- It would be nicer if this could go back to 1-01-01 and work perpetually
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hijri_to_gregorian(p_year INTEGER, p_month INTEGER, p_day INTEGER)
RETURNS DATE AS $$

DECLARE
	-- Constants
	month_starts INTEGER[] := calendars.ummalqura_month_starts();
	ummalqura_hijri_offset INTEGER := 1342 * 12; -- 16104

	t_index INTEGER := ((p_year - 1) * 12) + p_month - ummalqura_hijri_offset;
	t_rjd INTEGER := month_starts[t_index] + p_day - 1;
	t_jd INTEGER := t_rjd + 2400000;
	
	t_ord INTEGER := calendars.julian_to_ordinal(t_jd);
	t_date DATE := calendars.ordinal_to_gregorian(t_ord);

BEGIN
	RETURN t_date;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
