-------------------------------------------------------------------------------
-- moon phase - new or full corrections
--
-- param - p_moonphase (moonphase type)
-- param - p_c (coefficient array)
-- Returns - NUMERIC correction for JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_nfc(
	p_moonphase astronomia.moonphase,
	p_c NUMERIC[]
)
RETURNS NUMERIC
AS $$

DECLARE
	M NUMERIC := p_moonphase.M;
	M_ NUMERIC := p_moonphase.M_;
	E NUMERIC := p_moonphase.E;
	F NUMERIC := p_moonphase.F;
	Ω NUMERIC := p_moonphase.Ω;
	t_nfc NUMERIC := (
		p_c[1] * sin(M_) +
		p_c[2] * sin(M) * E +
		p_c[3] * sin(2 * M_) +
		p_c[4] * sin(2 * F) +
		p_c[5] * sin(M_ - M) * E +
		p_c[6] * sin(M_ + M) * E +
		p_c[7] * sin(2 * M) * E * E +
		p_c[8] * sin(M_ - 2 * F) +
		p_c[9] * sin(M_ + 2 * F) +
		p_c[10] * sin(2 * M_ + M) * E +
		p_c[11] * sin(3 * M_) +
		p_c[12] * sin(M + 2 * F) * E +
		p_c[13] * sin(M - 2 * F) * E +
		p_c[14] * sin(2 * M_ - M) * E +
		p_c[15] * sin(Ω) +
		p_c[16] * sin(M_ + 2 * M) +
		p_c[17] * sin(2 * (M_ - F)) +
		p_c[18] * sin(3 * M) +
		p_c[19] * sin(M_ + M - 2 * F) +
		p_c[20] * sin(2 * (M_ + F)) +
		p_c[21] * sin(M_ + M + 2 * F) +
		p_c[22] * sin(M_ - M + 2 * F) +
		p_c[23] * sin(M_ - M - 2 * F) +
		p_c[24] * sin(3 * M_ + M) +
		p_c[25] * sin(4 * M_)
	);

BEGIN
	RETURN t_nfc;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
