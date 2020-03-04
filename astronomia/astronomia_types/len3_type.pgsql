-------------------------------------------------------------------------------
-- NewLen3 prepares a Len3 object from a table of three rows of x and y values.
--
-- X values must be equally spaced, so only the first and last are supplied.
-- X1 must not equal to x3.  Y must be a slice of three y values.
--
-- @throws Error
-- @param {Number} x1 - is the x value corresponding to the first y value of the table.
-- @param {Number} x3 - is the x value corresponding to the last y value of the table.
-- @param {Number[]} y - is all y values in the table. y.length should be >= 3.0
-------------------------------------------------------------------------------

DO $$ BEGIN
	CREATE TYPE astronomia.len3 AS
	(
		x1 NUMERIC,
		x3 NUMERIC,
		y NUMERIC[],
		a NUMERIC,
		b NUMERIC,
		c NUMERIC,
		ab_sum NUMERIC,
		x_sum NUMERIC,
		x_diff NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;
