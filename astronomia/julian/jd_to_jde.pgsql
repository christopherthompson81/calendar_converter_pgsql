-------------------------------------------------------------------------------
-- Convert JD into JDE
--
-- JD vs. JDE is the difference beteween using Dynamical Time (TD) and Univeral Time (UT)
-- This is important as it relates to VSOP87 data and computational convention.
--
-- PARAM - NUMERIC JD
-- RETURNS - NUMERIC JDE
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.jd_to_jde(
	p_jd NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	t_calendar NUMERIC[] := astronomia.jd_to_calendar(p_jd);
	t_d_year NUMERIC := astronomia.calendar_to_decimal_year(t_calendar);
	ΔT NUMERIC := astronomia.delta_t(t_d_year);
	t_jde NUMERIC := p_jd + (ΔT / 86400.0);

BEGIN
	RETURN t_jde;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
