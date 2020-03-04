-------------------------------------------------------------------------------
-- Convert a timestamp into JDE
--
-- JD vs. JDE is the difference beteween using Dynamical Time (TD) and Univeral Time (UT)
-- This is important as it relates to VSOP87 data and computational convention.
--
-- PARAM - DATE Gregorian date (proleptic agnostic) without timezone
-- RETURNS - NUMERIC JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.gregorian_to_jde(
	p_date TIMESTAMP
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Get the decimal year from a date
	t_d_year NUMERIC := astronomia.gregorian_to_decimal_year(p_date);
	-- Get the ΔT value related to that decimal year (in seconds)
	ΔT NUMERIC := astronomia.delta_t(t_d_year);
	t_date TIMESTAMP := p_date + (ΔT::TEXT || ' seconds')::INTERVAL;

BEGIN
	RETURN astronomia.gregorian_to_jd(t_date);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
