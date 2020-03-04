-------------------------------------------------------------------------------
-- Low precision formula.  The high precision formula is not implemented
-- because the low precision formula already gives position results to the
-- accuracy given on p. 165.  The high precision formula represents lots
-- of typing with associated chance of typos, and no way to test the result.
--
-- Param NUMERIC range
-- Returns NUMERIC aberation
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.solar_aberration(
	p_range NUMERIC
)
RETURNS NUMERIC
AS $$

BEGIN
	-- (25.10) p. 167
	RETURN -20.4898 / 3600.0 * PI() / 180.0 / p_range;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
