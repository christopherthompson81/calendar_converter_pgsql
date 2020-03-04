-------------------------------------------------------------------------------
-- nutation returns nutation in longitude (Δψ) and nutation in obliquity (Δε)
-- for a given JDE.
--
-- JDE = UT + ΔT, see package.
--
-- Computation is by 1980 IAU theory, with terms < .0003″ neglected.
--
-- Result units are radians.
--
-- Param NUMERIC jde - Julian ephemeris day
-- Return NUMERIC[] [Δψ, Δε] - [longitude, obliquity] in radians
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.nutation(
	p_jde NUMERIC
)
RETURNS NUMERIC[]
AS $$

DECLARE
	-- Constants
	D2R NUMERIC := PI() / 180.0;
	-- Math
	t_t NUMERIC := astronomia.j2000_century(p_jde);
	-- Mean elongation of the Moon from the sun
	t_d NUMERIC := astronomia.horner(
		t_t,
		ARRAY[
			297.85036,
			445267.11148,
			-0.0019142,
			1.0 / 189474
		]
	) * D2R;
	-- Mean anomaly of the Sun (Earth)
	t_m NUMERIC := astronomia.horner(
		t_t,
		ARRAY[
			357.52772,
			35999.050340,
			-0.0001603,
			-1.0 / 300000
		]
	) * D2R;
	-- Mean anomaly of the Moon
	t_n NUMERIC := astronomia.horner(
		t_t,
		ARRAY[
			134.96298,
			477198.867398,
			0.0086972,
			1.0 / 56250
		]
	) * D2R;
	-- Moon's argument of latitude
	t_f NUMERIC := astronomia.horner(
		t_t,
		ARRAY[
			93.27191,
			483202.017538,
			-0.0036825,
			1.0 / 327270
		]
	) * D2R;
	-- Longitude of the ascending node of the Moon's mean orbit on the ecliptic, measured from mean equinox of date
	Ω NUMERIC := astronomia.horner(
		t_t,
		ARRAY[
			125.04452,
			-1934.136261,
			0.0020708,
			1.0 / 450000
		]
	) * D2R;
	Δψ NUMERIC := 0;
	Δε NUMERIC := 0;
	t_row astronomia.nutation_periods%rowtype;
	t_arg NUMERIC;
	t_s NUMERIC;
	t_c NUMERIC;

BEGIN
	FOR t_row IN
		-- sum in reverse order to accumulate smaller terms first
		SELECT *
		FROM astronomia.nutation_periods
		ORDER BY nutation_period_id DESC
	LOOP 
		t_arg := (
			t_row.d * t_d +
			t_row.m * t_m +
			t_row.n * t_n +
			t_row.f * t_f +
			t_row.ω * Ω
		);
		t_s := SIN(t_arg);
		t_c := COS(t_arg);
		Δψ := Δψ + t_s * (t_row.s0 + t_row.s1 * t_t);
		Δε := Δε + t_c * (t_row.c0 + t_row.c1 * t_t);
	END LOOP;
	Δψ := Δψ * 0.0001 / 3600 * D2R;
	Δε := Δε * 0.0001 / 3600 * D2R;

	RETURN ARRAY[Δψ, Δε];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
