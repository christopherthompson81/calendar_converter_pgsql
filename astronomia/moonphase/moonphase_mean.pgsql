-------------------------------------------------------------------------------
-- Find a mean moon phase from a JDE value
--
-- (49.1) p. 349
--
-- param - dynamical time value T (JDE)
-- Returns - JDE NUMERIC (nearest new moon?)
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_mean(
	p_t NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	ck CONSTANT NUMERIC := 1 / 1236.85;
	--ck NUMERIC CONSTANT := astronomia.get_constant('mean_lunar_month_centuries');

BEGIN
	RETURN astronomia.horner(
		p_t,
		ARRAY[
			2451550.09766,
			29.530588861 / ck,
			0.00015437,
			-0.00000015,
			0.00000000073
		]
	);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
