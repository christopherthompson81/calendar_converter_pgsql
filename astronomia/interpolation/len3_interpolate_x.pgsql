-------------------------------------------------------------------------------
-- len3_interpolate_x interpolates for a given x value.
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.len3_interpolate_x(
	p_len3 astronomia.len3,
	p_x NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	t_n NUMERIC := (2 * p_x - p_len3.x_sum) / p_len3.x_diff;
	t_y NUMERIC := astronomia.len3_interpolate_n(p_len3, t_n);

BEGIN
	RETURN t_y;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
