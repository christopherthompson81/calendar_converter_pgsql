-------------------------------------------------------------------------------
-- Len3Zero finds a zero of the quadratic function represented by the table.
--
-- That is, it returns an x value that yields y=0.
--
-- Argument strong switches between two strategies for the estimation step.
-- when iterating to converge on the zero.
--
-- Strong=false specifies a quick and dirty estimate that works well
-- for gentle curves, but can work poorly or fail on more dramatic curves.
--
-- Strong=true specifies a more sophisticated and thus somewhat more
-- expensive estimate.  However, if the curve has quick changes, This estimate
-- will converge more reliably and in fewer steps, making it a better choice.
--
-- Results are restricted to the range of the table given to the constructor
-- NewLen3.
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.len3_zero(
	p_len3 astronomia.len3,
	p_strong BOOLEAN
)
RETURNS NUMERIC
AS $$

DECLARE
	t_f NUMERIC;
	t_iterate NUMERIC[] := astronomia.len3_iterate(p_len3, 0, p_strong);
	t_n0 NUMERIC := t_iterate[1];
	t_ok BOOLEAN := t_iterate[2]::BOOLEAN;

BEGIN
	IF NOT t_ok THEN
		RAISE EXCEPTION 'Failure to converge';
	END IF;
	IF t_n0 > 1 OR t_n0 < -1 THEN
		RAISE EXCEPTION 'Zero falls outside of table';
	END IF;
	-- success
	RETURN 0.5 * (p_len3.x_sum + p_len3.x_diff * t_n0);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
