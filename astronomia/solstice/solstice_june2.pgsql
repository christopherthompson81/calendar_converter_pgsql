-------------------------------------------------------------------------------
-- solstice_june2 returns a more accurate JDE of the June Solstice.
--
-- Result is accurate to one second of time.
--
-- Param INTEGER - year
-- Returns NUMERIC - JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.solstice_june2(
	p_year INTEGER
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN astronomia.solstice_longitude(p_year, 'earth', (PI() / 2.0)::NUMERIC);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
