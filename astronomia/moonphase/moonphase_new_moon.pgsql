-------------------------------------------------------------------------------
-- new_moon returns the JDE of New Moon nearest the given date.
--
-- @param {Number} year - decimal year
-- @returns {Number} JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_new_moon(
	p_year NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	nc CONSTANT NUMERIC[] := ARRAY[
		-0.4072, 0.17241, 0.01608, 0.01039, 0.00739,
		-0.00514, 0.00208, -0.00111, -0.00057, 0.00056,
		-0.00042, 0.00042, 0.00038, -0.00024, -0.00017,
		-0.00007, 0.00004, 0.00004, 0.00003, 0.00003,
		-0.00003, 0.00003, -0.00002, -0.00002, 0.00002
	];
	-- Vars
	t_moonphase astronomia.moonphase%rowtype := astronomia.new_moonphase(p_year, 0);
	t_jde NUMERIC := (
		astronomia.moonphase_mean(t_moonphase.T) +
		astronomia.moonphase_nfc(t_moonphase, nc) +
		astronomia.moonphase_a(t_moonphase)
	);

BEGIN
	RETURN t_jde;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
