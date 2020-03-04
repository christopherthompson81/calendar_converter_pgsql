-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- julian_year_to_jde returns the Julian ephemeris day for a Julian year.
--
-- PARAM p_jy - Julian year
-- RETURNS t_jde - Julian ephemeris day
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.julian_year_to_jde(
	p_jy NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	J2000 CONSTANT NUMERIC := astronomia.get_constant('julian_date_epoch_2000');
	JULIAN_YEAR_DAYS CONSTANT NUMERIC := astronomia.get_constant('julian_year_days');

BEGIN
	RETURN J2000 + JULIAN_YEAR_DAYS * (p_jy - 2000);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
