-------------------------------------------------------------------------------
-- Len3 convergence algorithm
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.len3_iterate(
	p_len3 astronomia.len3,
	p_n0 NUMERIC,
	p_strong BOOLEAN
)
RETURNS NUMERIC[]
AS $$

DECLARE
	t_n0 NUMERIC := p_n0;
	t_n1 NUMERIC;
	t_limit INTEGER := 0;

BEGIN
	LOOP
		EXIT WHEN t_limit >= 50;
		IF p_strong THEN
			-- (3.7), p. 27
			t_n1 := t_n0 - (2 * p_len3.y[2] + t_n0 * (p_len3.ab_sum + p_len3.c * t_n0)) / (p_len3.ab_sum + 2 * p_len3.c * t_n0);
		ELSE
			-- (3.6), p. 26
			t_n1 := -2 * p_len3.y[2] / (p_len3.ab_sum + p_len3.c * t_n0);
		END IF;
		-- failure to converge
		EXIT WHEN t_n1 IN ('Infinity', '-Infinity', 'NaN');
		IF ABS((t_n1 - t_n0) / t_n0) < (1^-15) THEN
			-- success
			RETURN ARRAY[t_n1, 1];
		END IF;
		t_n0 := t_n1;
		t_limit := t_limit + 1;
	END LOOP;
	-- failure to converge
	RETURN ARRAY[0, 0];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
