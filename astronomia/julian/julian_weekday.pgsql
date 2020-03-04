-------------------------------------------------------------------------------
-- Calculate day of week from Julian day
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.julian_weekday(
	p_jd NUMERIC
)
RETURNS NUMERIC
AS $$

BEGIN
	RETURN TRUNC(p_jd + 0.5) % 7;
END;

$$ LANGUAGE plpgsql;