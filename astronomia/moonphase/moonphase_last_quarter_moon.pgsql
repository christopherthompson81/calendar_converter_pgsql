-------------------------------------------------------------------------------
-- Last returns the jde of Last Quarter Moon nearest the given decimal year.
--
-- Param NUMERIC p_year - decimal year
-- Returns NUMERIC t_jde - JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_last_quarter_moon(
	p_year NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Vars
	t_moonphase astronomia.moonphase%rowtype := astronomia.new_moonphase(p_year, 0.75);
	t_jde NUMERIC := (
		astronomia.moonphase_mean(t_moonphase.T) +
		astronomia.moonphase_flc(t_moonphase) +
		astronomia.moonphase_w(t_moonphase) +
		astronomia.moonphase_a(t_moonphase)
	);

BEGIN
	RETURN t_jde;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;