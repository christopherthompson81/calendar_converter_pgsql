-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- jde_to_julian_year returns a Julian year for a Julian ephemeris day.
--
-- PARAM p_jde - Julian ephemeris day
-- RETURNS t_jy - Julian year
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.jde_to_julian_year(
	p_jde NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	J2000 CONSTANT NUMERIC := astronomia.get_constant('julian_date_epoch_2000');
	JULIAN_YEAR_DAYS CONSTANT NUMERIC := astronomia.get_constant('julian_year_days');

BEGIN
	RETURN 2000 + (p_jde - J2000) / JULIAN_YEAR_DAYS;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
