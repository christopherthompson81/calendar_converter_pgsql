-------------------------------------------------------------------------------
-- Horner's method
--
-- A method for approximating the roots of polynomials 
--
-- horner evaluates a polynomal with coefficients c at x. The constant
-- term is c[0].
-- @param {Number} x
-- @param {Number|Number[]} c - coefficients
-- @returns {Number}
-------------------------------------------------------------------------------
--export function horner (x, ...c) {
--	if (Array.isArray(c[0])) {
--		c = c[0]
--	}
--	let i = c.length - 1
--	let y = c[i]
--	while (i > 0) {
--		i--
--		y = y * x + c[i]
--	}
--	return y
--}
-------------------------------------------------------------------------------
-- Porting Note: PL/pgSQL arrays are 1 indexed, not 0 indexed
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.horner(p_x NUMERIC, p_c NUMERIC[]) RETURNS NUMERIC AS $$

DECLARE
	t_i INTEGER := ARRAY_LENGTH(p_c, 1);
	t_y NUMERIC := p_c[t_i];

BEGIN
	LOOP
		EXIT WHEN t_i <= 1;
		t_i := t_i - 1;
		t_y := t_y * p_x + p_c[t_i];
	END LOOP;
	RETURN t_y;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;