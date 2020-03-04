-------------------------------------------------------------------------------
-- len3_for_interpolate_x is a special purpose Len3 constructor.
--
-- Like NewLen3, it takes a table of x and y values, but it is not limited
-- to tables of 3 rows.  An X value is also passed that represents the
-- interpolation target x value.  Len3ForInterpolateX will locate the
-- appropriate three rows of the table for interpolating for x, and initialize
-- the Len3 object for those rows.
--
-- @param {Number} x - is the target for interpolation
-- @param {Number} x1 - is the x value corresponding to the first y value of the table.
-- @param {Number} xn - is the x value corresponding to the last y value of the table.
-- @param {Number[]} y - is all y values in the table.  y.length should be >= 3.0
-- @returns a len3 type
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.len3_for_interpolate_x(
	p_x NUMERIC,
	p_x1 NUMERIC,
	p_x_n NUMERIC,
	p_y NUMERIC[]
)
RETURNS astronomia.len3
AS $$

DECLARE
	t_x NUMERIC := p_x;
	t_x1 NUMERIC := p_x1;
	t_x_n NUMERIC := p_x_n;
	t_y3 NUMERIC[] := p_y;
	t_interval NUMERIC;
	t_nearest_x INTEGER;

BEGIN
	IF ARRAY_LENGTH(p_y, 1) > 3 THEN
		t_interval := (p_x_n - p_x1) / (ARRAY_LENGTH(p_y, 1) - 1);
		IF t_interval = 0 THEN
			RAISE EXCEPTION 'Argument x_n cannot equal x1';
		END IF;
		t_nearest_x := ((t_x - t_x1) / t_interval + 0.5)::INTEGER;
		IF t_nearest_x < 2 THEN
			t_nearest_x := 2;
		ELSIF t_nearest_x > ARRAY_LENGTH(p_y, 1) - 1 THEN
			t_nearest_x := ARRAY_LENGTH(p_y, 1) - 1;
		END IF;
		t_y3 := p_y[(t_nearest_x):(t_nearest_x + 2)];
		t_x_n := t_x1 + (t_nearest_x + 1) * t_interval;
		t_x1 := t_x1 + (t_nearest_x - 1) * t_interval;
	END IF;
	RETURN astronomia.new_len3(t_x1, t_x_n, t_y3);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
