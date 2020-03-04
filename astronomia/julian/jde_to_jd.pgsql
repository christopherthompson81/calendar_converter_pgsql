-------------------------------------------------------------------------------
-- Convert JDE into JD
--
-- JD vs. JDE is the difference beteween using Dynamical Time (TD) and Univeral Time (UT)
-- This is important as it relates to VSOP87 data and computational convention.
--
-- PARAM - NUMERIC JDE
-- RETURNS - NUMERIC JD
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.jde_to_jd(
	p_jde NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	t_calendar NUMERIC[] := astronomia.jd_to_calendar(p_jde);
	t_d_year NUMERIC := astronomia.calendar_to_decimal_year(t_calendar);
	ΔT NUMERIC := astronomia.delta_t(t_d_year);
	t_jd NUMERIC := p_jde - (ΔT / 86400.0);

BEGIN
	RETURN t_jd;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
