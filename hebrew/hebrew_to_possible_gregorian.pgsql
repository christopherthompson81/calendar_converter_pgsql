-------------------------------------------------------------------------------
-- Get a Gregorian date using a Gregorian year, a Hebrew month and a Hebrew day
--
-- gregorian year is either 3760 or 3761 years less than hebrew year
-- we'll first try 3760 if conversion to gregorian isn't the same
-- year that was passed to this method, then it must be 3761.
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_to_possible_gregorian(
	gregorian_year INTEGER,
	hebrew_month INTEGER,
	hebrew_day INTEGER
)
RETURNS DATE AS $$

DECLARE
	HEBREW_YEAR_OFFSET INTEGER := 3760;
	t_jd NUMERIC := calendars.hebrew_to_jd((gregorian_year + HEBREW_YEAR_OFFSET, hebrew_month, hebrew_day));
	t_date DATE := astronomia.jd_to_gregorian(t_jd)::DATE;

BEGIN
	IF DATE_PART('year', t_date) != gregorian_year THEN
		t_jd := calendars.hebrew_to_jd((gregorian_year + HEBREW_YEAR_OFFSET + 1, hebrew_month, hebrew_day));
		t_date := astronomia.jd_to_gregorian(t_jd)::DATE;
	END IF;
	IF DATE_PART('year', t_date) != gregorian_year THEN
		RAISE EXCEPTION 'Could not determine Hebrew date from gregorian year: %', gregorian_year;
	END IF;
	RETURN t_date;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
