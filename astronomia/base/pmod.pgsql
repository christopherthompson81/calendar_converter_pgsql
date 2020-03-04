-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- pmod returns a positive floating-point x mod y.
--
-- For a positive argument y, it returns a value in the range [0,y).
--
-- p_x - input numerator
-- p_y - input denominator
-- Returns - p_x % p_y - The result may not be useful if y is negative.
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.pmod(
	p_x NUMERIC,
	p_y NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	t_r NUMERIC := p_x % p_y;

BEGIN
	IF t_r < 0 THEN
		t_r := t_r + p_y;
	END IF;
	RETURN t_r;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
