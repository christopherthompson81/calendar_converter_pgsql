-------------------------------------------------------------------------------
-- EclipticPrecessor represents precession from one epoch to another.
--
-- Construct with new_ecliptic_precessor, then call method Precess.
-- After construction, Precess may be called multiple times to precess
-- different coordinates with the same initial and final epochs.
--
-- constructs an ecliptic_precessor object and initializes
-- it to precess coordinates from epochFrom to epochTo.
-- @param {Number} epoch_from
-- @param {Number} epoch_to
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.new_ecliptic_precessor(
	p_epoch_from NUMERIC,
	p_epoch_to NUMERIC
)
RETURNS astronomia.ecliptic_precessor
AS $$

DECLARE
	-- Constants
	D2R CONSTANT NUMERIC := PI() / 180;
	s CONSTANT NUMERIC := D2R / 3600.0;
	-- coefficients from (21.5) p. 136
	ηT CONSTANT NUMERIC[] := ARRAY[47.0029 * s, -0.06603 * s, 0.000598 * s];
	πT CONSTANT NUMERIC[] := ARRAY[174.876384 * D2R, 3289.4789 * s, 0.60622 * s];
	pT CONSTANT NUMERIC[] := ARRAY[5029.0966 * s, 2.22226 * s, -0.000042 * s];
	-- Variables
	T NUMERIC := (p_epoch_from - 2000) * 0.01;
	-- (21.5) p. 136
	ηCoeff NUMERIC[] := (
		CASE
		WHEN p_epoch_from != 2000 THEN
			ARRAY[
				astronomia.horner(T, ηT),
				-0.03302 * s + 0.000598 * s * T,
				0.000060 * s
			]
		ELSE ηt
		END
	);
	πCoeff NUMERIC[] := (
		CASE
		WHEN p_epoch_from != 2000 THEN
			ARRAY[
				astronomia.horner(T, πT),
				-869.8089 * s - 0.50491 * s * T,
				0.03536 * s
			]
		ELSE πt
		END
	);
	pCoeff NUMERIC[] := (
		CASE
		WHEN p_epoch_from != 2000 THEN
			ARRAY[
				astronomia.horner(T, pT),
				1.11113 * s - 0.000042 * s * T,
				-0.000006 * s
			]
		ELSE pt
		END
	);
	t_t NUMERIC := (p_epoch_to - p_epoch_from) * 0.01;
	η NUMERIC := astronomia.horner(t_t, ηCoeff) * t_t;
	t_ecliptic_precessor astronomia.ecliptic_precessor%rowtype;
	
BEGIN
	t_ecliptic_precessor.π = astronomia.horner(t_t, πCoeff);
	t_ecliptic_precessor.p = astronomia.horner(t_t, pCoeff) * t_t;
	t_ecliptic_precessor.sη = SIN(η);
	t_ecliptic_precessor.cη = COS(η);

	RETURN t_ecliptic_precessor;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
