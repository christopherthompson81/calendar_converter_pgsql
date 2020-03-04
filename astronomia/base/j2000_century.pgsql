-------------------------------------------------------------------------------
-- J2000Century returns the number of Julian centuries since J2000.
--
-- The quantity appears as T in a number of time series.
--
-- The formula is given in a number of places in the book, for example
-- (12.1) p. 87.
-- (22.1) p. 143.
-- (25.1) p. 163.
--
-- jde - Julian ephemeris day
-- Returns - number of Julian centuries since J2000
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.j2000_century(p_jde NUMERIC)
RETURNS NUMERIC AS $$

DECLARE
	J2000 NUMERIC := astronomia.get_constant('julian_date_epoch_2000');
	JULIAN_CENTURY_DAYS NUMERIC := astronomia.get_constant('julian_century_days');

BEGIN
	RETURN (p_jde - J2000) / JULIAN_CENTURY_DAYS;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
