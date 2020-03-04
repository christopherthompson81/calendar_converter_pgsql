-------------------------------------------------------------------------------
-- Extremum returns the x and y values at the extremum.
--
-- Results are restricted to the range of the table given to the constructor
-- new Len3.
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.len3_extremum(p_len3 astronomia.len3)
RETURNS NUMERIC[]
AS $$

DECLARE
	t_n NUMERIC; 
	t_x NUMERIC;
	t_y NUMERIC; 

BEGIN
	IF p_len3.c = 0 THEN
		RAISE EXCEPTION 'No extremum in table';
	END IF;
	IF t_n < -1 OR t_n > 1 THEN
		RAISE EXCEPTION 'Extremum falls outside of table';
	END IF;
	-- (3.5), p. 25
	t_n := p_len3.ab_sum / (-2 * p_len3.c);
	t_x := 0.5 * (p_len3.x_sum + p_len3.x_diff * t_n);
	-- (3.4), p. 25
	t_y := p_len3.y[2] - (p_len3.ab_sum * p_len3.ab_sum) / (8 * p_len3.c);
	RETURN ARRAY[t_x, t_y];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
