-------------------------------------------------------------------------------
-- moon phase - first or last corrections
--
-- param - p_moonphase (moonphase type)
-- param - p_t (?)
-- Returns - NUMERIC correction for JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_flc(
	p_moonphase astronomia.moonphase,
	p_t NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	M NUMERIC := p_moonphase.M;
	M_ NUMERIC := p_moonphase.M_;
	E NUMERIC := p_moonphase.E;
	F NUMERIC := p_moonphase.F;
	Ω NUMERIC := p_moonphase.Ω;
	t_flc NUMERIC := (
		-0.62801 * SIN(M_) +
		0.17172 * SIN(M) * E +
		-0.01183 * SIN(M_ + M) * E +
		0.00862 * SIN(2 * M_) +
		0.00804 * SIN(2 * F) +
		0.00454 * SIN(M_ - M) * E +
		0.00204 * SIN(2 * M) * E * E +
		-0.0018 * SIN(M_ - 2 * F) +
		-0.0007 * SIN(M_ + 2 * F) +
		-0.0004 * SIN(3 * M_) +
		-0.00034 * SIN(2 * M_ - M) * E +
		0.00032 * SIN(M + 2 * F) * E +
		0.00032 * SIN(M - 2 * F) * E +
		-0.00028 * SIN(M_ + 2 * M) * E * E +
		0.00027 * SIN(2 * M_ + M) * E +
		-0.00017 * SIN(Ω) +
		-0.00005 * SIN(M_ - M - 2 * F) +
		0.00004 * SIN(2 * M_ + 2 * F) +
		-0.00004 * SIN(M_ + M + 2 * F) +
		0.00004 * SIN(M_ - 2 * M) +
		0.00003 * SIN(M_ + M - 2 * F) +
		0.00003 * SIN(3 * M) +
		0.00002 * SIN(2 * M_ - 2 * F) +
		0.00002 * SIN(M_ - M + 2 * F) +
		-0.00002 * SIN(3 * M_ + M)
	);


BEGIN
	RETURN t_flc;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
