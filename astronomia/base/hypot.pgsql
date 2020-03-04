-------------------------------------------------------------------------------
-- Hypotenuse Function
--
-- Based on the C implementation
-------------------------------------------------------------------------------
--double hypot(double x, double y)
--{
--    double yx;
--
--    x = fabs(x);
--    y = fabs(y);
--    if (x < y) {
--        double temp = x;
--        x = y;
--        y = temp;
--    }
--    if (x == 0.)
--        return 0.;
--    else {
--        yx = y/x;
--        return x*sqrt(1.+yx*yx);
--    }
--}
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.hypot(
	p_x NUMERIC,
	p_y NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	t_yx NUMERIC;
	t_temp NUMERIC;
	t_x NUMERIC := ABS(p_x);
	t_y NUMERIC := ABS(p_y);

BEGIN
	IF t_x < t_y THEN
		t_temp := t_x;
		t_x := t_y;
		t_y := t_temp;
	END IF;
	IF t_x = 0 THEN
		RETURN 0;
	END IF;
	t_yx := t_y / t_x;
	RETURN t_x * SQRT(1 + t_yx * t_yx);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
