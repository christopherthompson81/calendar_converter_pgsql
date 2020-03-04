-------------------------------------------------------------------------------
-- moon phase - w corrections
--
-- Returns - NUMERIC correction for JDE
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.moonphase_w(
	p_moonphase astronomia.moonphase
)
RETURNS NUMERIC
AS $$

DECLARE
	M NUMERIC := p_moonphase.M;
	M_ NUMERIC := p_moonphase.M_;
	E NUMERIC := p_moonphase.E;
	F NUMERIC := p_moonphase.F;
	--Ω NUMERIC := p_moonphase.Ω;
	t_w NUMERIC := (
		0.00306 -
		0.00038 * E * COS(M) +
		0.00026 * COS(M_) -
		0.00002 * (
			COS(M_ - M) -
			COS(M_ + M) -
			COS(2 * F)
		)
	);


BEGIN
	RETURN t_w;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
