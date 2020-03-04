-------------------------------------------------------------------------------
-- SetDMS sets the value of an FAngle from sign, degree, minute, and second
-- components.
--
-- Param BOOLEAN - neg - sign, true if negative
-- Param INTEGER - d - degree
-- Param INTEGER - m - minute
-- Param NUMERIC - s - second
-- Returns NUMERIC
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.angle_dms_to_radians(
	p_negative BOOLEAN DEFAULT FALSE,
	p_degree INTEGER DEFAULT 0,
	p_minute INTEGER DEFAULT 0,
	p_second NUMERIC DEFAULT 0.0
)
RETURNS NUMERIC
AS $$

DECLARE
	t_degrees NUMERIC := (((p_degree * 60 + p_minute) * 60) + p_second) / 3600.0;
	t_radians NUMERIC := RADIANS(t_degrees);

BEGIN
	IF p_negative THEN
		RETURN -1 * t_radians;
	END IF;
	RETURN t_radians;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
