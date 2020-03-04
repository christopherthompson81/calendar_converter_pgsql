-------------------------------------------------------------------------------
-- converts equatorial coordinates to ecliptic coordinates.
--
-- ε - Obliquity
-- Returns - ecliptic_coordinates
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.equatorial_to_ecliptic(
	p_equatorial_coordinates astronomia.equatorial_coordinates,
	p_obliquity NUMERIC
)
RETURNS astronomia.ecliptic_coordinates AS $$

DECLARE
	-- Convert to mathematical shorthand / math
	ε NUMERIC := p_obliquity;
	α NUMERIC := p_equatorial_coordinates.right_ascension;
	δ NUMERIC := p_equatorial_coordinates.declination;
	εsin NUMERIC := SIN(ε);
	εcos NUMERIC := COS(ε);
	sα NUMERIC := SIN(α);
	cα NUMERIC := COS(α);
	sδ NUMERIC := SIN(δ);
	cδ NUMERIC := COS(δ);
	-- (13.1) p. 93;
	β NUMERIC := ATAN2(sα * εcos + (sδ / cδ) * εsin, cα);
	-- (13.2) p. 93
	λ NUMERIC := ASIN(sδ * εcos - cδ * εsin * sα);

	-- Return Coordinates / Long-form names
	t_latitude NUMERIC := β;
	t_longitude NUMERIC := λ;
	t_ecliptic_coordinates astronomia.ecliptic_coordinates%rowtype := (t_latitude, t_longitude, NULL);

BEGIN
	RETURN t_ecliptic_coordinates;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
