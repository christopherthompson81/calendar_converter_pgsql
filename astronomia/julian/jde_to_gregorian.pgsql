-------------------------------------------------------------------------------
-- Convert JDE to a timestamp
--
-- JD vs. JDE is the difference beteween using Dynamical Time (TD) and Univeral Time (UT)
-- This is important as it relates to VSOP87 data and computational convention.
--
-- PARAM - NUMERIC JDE
-- RETURNS - TIMESTAMP Gregorian date (proleptic agnostic) without timezone
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.jde_to_gregorian(
	p_jde NUMERIC
)
RETURNS TIMESTAMP
AS $$

DECLARE
	-- Constants
	SECS_OF_DAY NUMERIC := 24 * 60 * 60;
	-- Vars
	t_date_parts NUMERIC[] := astronomia.jd_to_calendar(p_jde);
	t_d_year NUMERIC := astronomia.calendar_to_decimal_year(t_date_parts);
	-- Get the ΔT value related to that decimal year (in seconds)
	ΔT NUMERIC := astronomia.delta_t(t_d_year);
	t_jde NUMERIC := p_jde - (ΔT / SECS_OF_DAY);
	t_timestamp TIMESTAMP;

BEGIN
	--RAISE EXCEPTION 'jde_to_gregorian: t_date_parts: %; t_timestamp: %', t_date_parts, t_timestamp;
	t_date_parts := astronomia.jd_to_calendar(t_jde);
	t_timestamp := astronomia.calendar_to_timestamp(t_date_parts);
	RETURN t_timestamp;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
