-------------------------------------------------------------------------------
-- Full returns the jde of Full Moon nearest the given decimal year.
--
-- Param NUMERIC p_year - decimal year
-- Returns NUMERIC t_jde - JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_full_moon(
	p_year NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	-- full coefficients
	fc CONSTANT NUMERIC[] := ARRAY[
		-0.40614, 0.17302, 0.01614, 0.01043, 0.00734,
		-0.00515, 0.00209, -0.00111, -0.00057, 0.00056,
		-0.00042, 0.00042, 0.00038, -0.00024, -0.00017,
		-0.00007, 0.00004, 0.00004, 0.00003, 0.00003,
		-0.00003, 0.00003, -0.00002, -0.00002, 0.00002
	];
	-- Vars
	t_moonphase astronomia.moonphase%rowtype := astronomia.new_moonphase(p_year, 0.5);
	t_jde NUMERIC := (
		astronomia.moonphase_mean(t_moonphase.T) +
		astronomia.moonphase_nfc(t_moonphase, fc) +
		astronomia.moonphase_a(t_moonphase)
	);

BEGIN
	RETURN t_jde;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
