-------------------------------------------------------------------------------
-- len3_interpolate_n_strict interpolates for (a given interpolating factor n.
--
-- N is restricted to the range [-1..1] corresponding to the range x1 to x3
-- given to the constructor of Len3.
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.len3_interpolate_n_strict(
	p_len3 astronomia.len3,
	p_n NUMERIC
)
RETURNS NUMERIC
AS $$

BEGIN
	IF p_n < -1 OR p_n > 1 THEN
		RAISE EXCEPTION 'Interpolating factor n must be in range -1 to 1';
	END IF;
	RETURN astronomia.len3_interpolate_n(p_len3, p_n);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
