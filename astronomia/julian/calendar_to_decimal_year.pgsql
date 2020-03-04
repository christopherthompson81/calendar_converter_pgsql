-------------------------------------------------------------------------------
-- Convert a calendar array into a decimal year
-- (y,m,d,h,m,s,ms,neg)
--
-- Param - NUMERIC[] - calender array
-- Returns - NUMERIC - decimal year
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.calendar_to_decimal_year(
	p_calendar NUMERIC[]
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	DAYS_OF_YEAR INTEGER[] := ARRAY[0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
	-- Date
	t_year INTEGER := p_calendar[1]::INTEGER;
	t_is_leap BOOLEAN := astronomia.leap_year_gregorian(t_year);
	t_year_days NUMERIC := (CASE WHEN t_is_leap THEN 366 ELSE 365 END);
	t_doy NUMERIC := (
		p_calendar[3]::INTEGER +
		DAYS_OF_YEAR[p_calendar[2]] +
		(CASE WHEN t_is_leap AND p_calendar[2] > 2 THEN 1 ELSE 0 END)
	);
	-- Time
	t_hour NUMERIC := p_calendar[4];
	t_minute NUMERIC := p_calendar[5];
	t_second NUMERIC := p_calendar[6];
	t_ms NUMERIC := p_calendar[7];
	-- fractional day of year
	t_days NUMERIC := t_doy + (t_hour + ((t_minute + ((t_second + t_ms / 1000.0) / 60.0)) / 60.0)) / 24.0;
	t_d_year NUMERIC := t_year::NUMERIC + (t_days / t_year_days);

BEGIN
	RETURN t_d_year;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
