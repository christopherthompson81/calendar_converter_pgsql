-------------------------------------------------------------------------------
-- is_calendar_gregorian tests if date falls into the Gregorian calendar
-- @param {number} year - julian/gregorian year
-- @param {number} [month] - month of julian/gregorian year
-- @param {number} [day] - day of julian/gregorian year
-- @returns {boolean} true for Gregorian, false for Julian calendar
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.is_calendar_gregorian(
	p_year INTEGER,
	p_month INTEGER DEFAULT 1,
	p_day INTEGER DEFAULT 1
)
RETURNS BOOLEAN
AS $$

BEGIN
	RETURN (
		p_year > 1582
		OR (p_year = 1582 AND p_month > 10)
		OR (p_year = 1582 AND p_month = 10 AND p_day >= 15)
	);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
