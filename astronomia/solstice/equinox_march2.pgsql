-------------------------------------------------------------------------------
-- equinox_march2 returns a more accurate JDE of the March equinox.
--
-- Result is accurate to one second of time.
--
-- Param INTEGER - year
-- Returns NUMERIC - JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.solstice_march2(
	p_year INTEGER
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN astronomia.solstice_longitude(p_year, 'earth', 0::NUMERIC);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
