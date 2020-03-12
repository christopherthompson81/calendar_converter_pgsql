-------------------------------------------------------------------------------
-- MeanObliquity returns mean obliquity (ε₀) following the IAU 1980
-- polynomial.
--
-- Accuracy is 1″ over the range 1000 to 3000 years and 10″ over the range
-- 0 to 4000 years.
--
-- Result unit is radians.
--
-- @param {number} jde - Julian ephemeris day
-- @return {number} mean obliquity (ε₀)
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.nutation_mean_obliquity(
	p_jde NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	D2R NUMERIC := PI() / 180.0;

BEGIN
	-- (22.2) p. 147
	RETURN astronomia.horner(
		astronomia.j2000_century(p_jde),
		ARRAY[
			astronomia.angle_dms_to_radians(false, 23, 26, 21.448),
			-46.815 / 3600 * D2R,
			-0.00059 / 3600 * D2R,
			0.001813 / 3600 * D2R
		]
	);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
