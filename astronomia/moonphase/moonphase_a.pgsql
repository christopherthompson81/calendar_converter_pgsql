-------------------------------------------------------------------------------
-- moon phase - additional corrections
--
-- param - p_moonphase (moonphase type)
-- Returns - NUMERIC correction for JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_a(
	p_moonphase astronomia.moonphase
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	ac NUMERIC[] := ARRAY[
		0.000325, 0.000165, 0.000164, 0.000126, 0.00011,
		0.000062, 0.00006, 0.000056, 0.000047, 0.000042,
		0.000040, 0.000037, 0.000035, 0.000023
	];
	-- Holding Vars
	t_i INTEGER;
	t_a NUMERIC := 0;

BEGIN
	FOR t_i IN 1..ARRAY_LENGTH(ac, 1)
	LOOP
		t_a = t_a + ac[t_i] * SIN(p_moonphase.A[t_i]);
	END LOOP;
	RETURN t_a;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
