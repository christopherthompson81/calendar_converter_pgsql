-------------------------------------------------------------------------------
-- new_len3 prepares a len3 object from a table of three rows of x and y values.
--
-- X values must be equally spaced, so only the first and last are supplied.
-- X1 must not equal to x3.  Y must be a slice of three y values.
--
-- @throws Error
-- @param {Number} x1 - is the x value corresponding to the first y value of the table.
-- @param {Number} x3 - is the x value corresponding to the last y value of the table.
-- @param {Number[]} y - is all y values in the table. y.length should be >= 3.0
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.new_len3(
	p_x1 NUMERIC,
	p_x3 NUMERIC,
	p_y NUMERIC[]
)
RETURNS astronomia.len3
AS $$

DECLARE
	t_len3 astronomia.len3%rowtype;

BEGIN
	IF ARRAY_LENGTH(p_y, 1) != 3 THEN
		RAISE EXCEPTION 'Argument y must be length 3. Is currently --> %', ARRAY_LENGTH(p_y, 1);
	END IF;
	IF p_x3 = p_x1 THEN
		RAISE EXCEPTION 'Argument x3 cannot equal x1';
	END IF;
	t_len3.x1 := p_x1;
	t_len3.x3 := p_x3;
	t_len3.y := p_y;
	-- differences. (3.1) p. 23
	t_len3.a = p_y[2] - p_y[1];
	t_len3.b = p_y[3] - p_y[2];
	t_len3.c = t_len3.b - t_len3.a;
	-- other intermediate values
	t_len3.ab_sum := t_len3.a + t_len3.b;
	t_len3.x_sum := p_x3 + p_x1;
	t_len3.x_diff := p_x3 - p_x1;

	RETURN t_len3;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
