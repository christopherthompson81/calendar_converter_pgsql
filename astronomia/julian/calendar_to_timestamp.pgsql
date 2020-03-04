-------------------------------------------------------------------------------
-- Convert Calendar to a timestamp
--
-- PARAM - NUMERIC[y, m, d, h, m, s. ms, neg]
-- RETURNS - TIMESTAMP - Gregorian date (proleptic agnostic) without timezone
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.calendar_to_timestamp(
	p_calendar NUMERIC[]
)
RETURNS TIMESTAMP
AS $$

DECLARE
	t_timestamp TIMESTAMP := make_timestamp(
		p_calendar[1]::INTEGER, -- Year
		p_calendar[2]::INTEGER, -- Month
		p_calendar[3]::INTEGER, -- Day
		p_calendar[4]::INTEGER, -- Hours
		p_calendar[5]::INTEGER, -- Minutes
		(p_calendar[6]::DOUBLE PRECISION + (p_calendar[7] / 1000)::DOUBLE PRECISION) -- Seconds & Milliseconds
	);

BEGIN
	RETURN t_timestamp;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
