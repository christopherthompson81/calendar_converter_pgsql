-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- separate fix `i` from fraction `f`
--
-- p_x - input numeric
-- Returns - NUMERIC array of integer part and fractional part
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.modf(p_x NUMERIC) RETURNS NUMERIC[] AS $$

DECLARE
	t_i NUMERIC := TRUNC(p_x);
	t_f NUMERIC := ABS(p_x - t_i);

BEGIN
	RETURN ARRAY[t_i, t_f];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
