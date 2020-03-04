-------------------------------------------------------------------------------
-- December2 returns a more accurate JDE of the December solstice.
--
-- Result is accurate to one second of time.
--
-- Param INTEGER p_year
-- Param TEXT planet_name - must be a V87Planet object representing Earth
-- Returns NUMERIC JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.solstice_december2(
	p_year INTEGER
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN astronomia.solstice_longitude(p_year, 'earth', (PI() * 3 / 2)::NUMERIC);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
