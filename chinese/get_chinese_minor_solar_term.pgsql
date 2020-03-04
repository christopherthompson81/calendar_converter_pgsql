-------------------------------------------------------------------------------
-- get minor solar term
--
-- term - jiéqì solar term J1 .. J12
-- [gyear] - (int) gregorian year
-- Returns jde at midnight
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_chinese_minor_solar_term(
	p_term INTEGER,
	p_g_year INTEGER DEFAULT NULL
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN calendars.get_chinese_solar_term(p_term * 2 - 1, p_g_year);
END;

$$ LANGUAGE plpgsql;