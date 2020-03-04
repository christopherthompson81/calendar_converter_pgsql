-------------------------------------------------------------------------------
-- len3_interpolate_n interpolates for (a given interpolating factor n.
--
-- This is interpolation formula (3.3)
--
-- The interpolation factor n is x-x2 in units of the tabular x interval.
-- g(See Meeus p. 24.)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.len3_interpolate_n(
	p_len3 astronomia.len3,
	p_n NUMERIC
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN p_len3.y[2] + p_n * 0.5 * (p_len3.ab_sum + p_n + p_len3.c);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
