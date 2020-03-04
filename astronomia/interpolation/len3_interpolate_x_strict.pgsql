-------------------------------------------------------------------------------
-- interpolate_x_strict interpolates for a given x value,
-- restricting x to the range x1 to x3 given to the constructor new_len3.
-------------------------------------------------------------------------------
--interpolate_x_strict (x) {
--	const n = (2 * x - this.xSum) / this.xDiff
--	// Porting note: the target function does not accept a second parameter of BOOLEAN
--	const y = this.interpolateNStrict(n, true)
--	return y
--}
CREATE OR REPLACE FUNCTION astronomia.len3_interpolate_x_strict(
	p_len3 astronomia.len3,
	p_x NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	t_n NUMERIC := (2 * p_x - p_len3.x_sum) / p_len3.x_diff;
	t_y NUMERIC := astronomia.len3_interpolate_n_strict(p_len3, t_n);

BEGIN
	RETURN t_y;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
