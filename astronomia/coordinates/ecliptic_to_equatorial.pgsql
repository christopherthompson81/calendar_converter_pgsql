-------------------------------------------------------------------------------
-- converts ecliptic coordinates to equatorial coordinates.
--
-- ε - Obliquity
-- Returns - equatorial_coordinates
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.ecliptic_to_equatorial(
	p_ecliptic_coordinates astronomia.ecliptic_coordinates,
	p_obliquity NUMERIC
)
RETURNS astronomia.equatorial_coordinates AS $$

DECLARE
	-- Convert to mathematical shorthand / math
	ε NUMERIC := p_obliquity;
	β NUMERIC := p_ecliptic_coordinates.latitude;
	λ NUMERIC := p_ecliptic_coordinates.longitude;
	εsin NUMERIC := SIN(ε);
	εcos NUMERIC := COS(ε);
	sβ NUMERIC := SIN(β);
	cβ NUMERIC := COS(β);
	sλ NUMERIC := SIN(λ);
	cλ NUMERIC := COS(λ);
	-- (13.3) p. 93
	α NUMERIC := ATAN2(sλ * εcos - (sβ / cβ) * εsin, cλ);
	-- (13.4) p. 93
	δ NUMERIC := ASIN(sβ * εcos + cβ * εsin * sλ);
	
	-- Return Coordinates / Long-form names
	t_right_ascension NUMERIC;
	t_declination NUMERIC;
	t_equatorial_coordinates astronomia.equatorial_coordinates%rowtype;

BEGIN
	IF (α < 0) THEN
		α := α + 2 * PI();
	END IF;
	t_right_ascension := α;
	t_declination := δ;
	t_equatorial_coordinates := (t_right_ascension, t_declination);
	RETURN t_equatorial_coordinates;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
