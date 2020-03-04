-------------------------------------------------------------------------------
-- get major solar term
--
-- term - zhōngqì solar term Z1 .. Z12
-- [gyear] - (int) gregorian year
-- Returns jde at midnight
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_chinese_major_solar_term(
	p_term INTEGER,
	p_g_year INTEGER DEFAULT NULL
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN calendars.get_chinese_solar_term(p_term * 2, p_g_year);
END;

$$ LANGUAGE plpgsql;