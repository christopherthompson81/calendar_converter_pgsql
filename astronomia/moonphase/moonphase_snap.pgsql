-------------------------------------------------------------------------------
-- snap returns k at specified quarter q nearest year y.
--
-- (49.2) p. 350
--
-- param - y (year)
-- param - q (quarter)
-- Returns - k NUMERIC
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_snap(
	p_y NUMERIC,
	p_q NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	t_k NUMERIC := (p_y - 2000) * 12.3685;
	
BEGIN
	RETURN FLOOR(t_k - p_q + 0.5) + p_q;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
