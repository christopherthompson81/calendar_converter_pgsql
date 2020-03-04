-------------------------------------------------------------------------------
-- moonphase_new prepares a moonphase object from y and q
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.new_moonphase(
	p_y NUMERIC,
	p_q NUMERIC
)
RETURNS astronomia.moonphase
AS $$

DECLARE
	-- Constants
	ck CONSTANT NUMERIC := 1 / 1236.85;
	D2R CONSTANT NUMERIC := PI() / 180;
	-- Vars
	t_k NUMERIC := astronomia.moonphase_snap(p_y, p_q);
	-- (49.3) p. 350
	t_t NUMERIC := t_k * ck;
	t_moonphase astronomia.moonphase%rowtype;

BEGIN
	t_moonphase.k := t_k;
	t_moonphase.T := t_t;
	t_moonphase.E := astronomia.horner(
		t_t,
		ARRAY[
			1,
			-0.002516,
			-0.0000074
		]
	);
	t_moonphase.M := astronomia.horner(
		t_t,
		ARRAY[
			2.5534 * D2R,
			29.1053567 * D2R / ck,
			-0.0000014 * D2R,
			-0.00000011 * D2R
		]
	);
	t_moonphase.M_ := astronomia.horner(
		t_t,
		ARRAY[
			201.5643 * D2R,
			385.81693528 * D2R / ck,
			0.0107582 * D2R,
			0.00001238 * D2R,
			-0.000000058 * D2R
		]
	);
	t_moonphase.F := astronomia.horner(
		t_t,
		ARRAY[
			160.7108 * D2R,
			390.67050284 * D2R / ck,
			-0.0016118 * D2R,
			-0.00000227 * D2R,
			0.000000011 * D2R
		]
	);
	t_moonphase.Ω := astronomia.horner(
		t_t,
		ARRAY[
			124.7746 * D2R,
			-1.56375588 * D2R / ck,
			0.0020672 * D2R,
			0.00000215 * D2R
		]
	);
	t_moonphase.A[1] := 299.7 * D2R + 0.107408 * D2R * t_k - 0.009173 * t_t * t_t;
	t_moonphase.A[2] := 251.88 * D2R + 0.016321 * D2R * t_k;
	t_moonphase.A[3] := 251.83 * D2R + 26.651886 * D2R * t_k;
	t_moonphase.A[4] := 349.42 * D2R + 36.412478 * D2R * t_k;
	t_moonphase.A[5] := 84.66 * D2R + 18.206239 * D2R * t_k;
	t_moonphase.A[6] := 141.74 * D2R + 53.303771 * D2R * t_k;
	t_moonphase.A[7] := 207.17 * D2R + 2.453732 * D2R * t_k;
	t_moonphase.A[8] := 154.84 * D2R + 7.30686 * D2R * t_k;
	t_moonphase.A[9] := 34.52 * D2R + 27.261239 * D2R * t_k;
	t_moonphase.A[10] := 207.19 * D2R + 0.121824 * D2R * t_k;
	t_moonphase.A[11] := 291.34 * D2R + 1.844379 * D2R * t_k;
	t_moonphase.A[12] := 161.72 * D2R + 24.198154 * D2R * t_k;
	t_moonphase.A[13] := 239.56 * D2R + 25.513099 * D2R * t_k;
	t_moonphase.A[14] := 331.55 * D2R + 3.592518 * D2R * t_k;

	RETURN t_moonphase;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
