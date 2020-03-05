-------------------------------------------------------------------------------
-- How many days are in a given Hebrew month of a given year
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hebrew_month_days(
	p_year INTEGER,
	p_month INTEGER
)
RETURNS INTEGER AS $$

DECLARE
	-- Hebrew months
	NISAN INTEGER := 1;
	IYYAR INTEGER := 2;
	SIVAN INTEGER := 3;
	TAMMUZ INTEGER := 4;
	AV INTEGER := 5;
	ELUL INTEGER := 6;
	TISHRI INTEGER := 7;
	HESHVAN INTEGER := 8;
	KISLEV INTEGER := 9;
	TEVETH INTEGER := 10;
	SHEVAT INTEGER := 11;
	ADAR INTEGER := 12;
	VEADAR INTEGER := 13;

BEGIN
	IF p_month > 13 THEN
		RAISE EXCEPTION 'Incorrect month index: %', p_month;
	END IF;

	-- First of all, dispose of fixed-length 29 day months
	IF p_month in (IYYAR, TAMMUZ, ELUL, TEVETH, VEADAR) THEN
		RETURN 29;
	END IF;

	-- If it's not a leap year, Adar has 29 days
	IF p_month = ADAR AND NOT calendars.leap_year_hebrew(p_year) THEN
		RETURN 29;
	END IF;

	-- If it's Heshvan, days depend on length of year
	IF p_month = HESHVAN AND (calendars.hebrew_year_days(p_year) % 10) != 5 THEN
		RETURN 29;
	END IF;

	-- Similarly, Kislev varies with the length of year
	IF p_month = KISLEV AND (calendars.hebrew_year_days(p_year) % 10) = 3 THEN
		RETURN 29;
	END IF;

	-- Nope, it's a 30 day month
	RETURN 30;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
