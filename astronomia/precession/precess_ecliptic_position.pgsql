-------------------------------------------------------------------------------
-- precess_ecliptic_position precesses ecliptic coordinates from one epoch to another,
-- including proper motions.
--
-- While p_ecl_from is given as ecliptic coordinates, proper motions mα, mδ are
-- still expected to be equatorial.  If proper motions are not to be considered
-- or are not applicable, pass 0, 0.
--
-- Both p_ecl_from and p_ecl_to must be non-nil, although they may point to the same
-- struct.  p_ecl_to is returned for convenience.
--
-- Param astronomia.ecliptic_coordinates p_ecl_from,
-- Param NUMERIC epochFrom
-- Param NUMERIC epochTo
-- Param sexagesimal_hour_angle mα (communicated with base type NUMERIC)
-- Param sexagesimal_angle mδ (communicated with base type NUMERIC)
-- Returns astronomia.ecliptic_coordinates t_ecl_to
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.precess_ecliptic_position(
	p_ecl_from astronomia.ecliptic_coordinates,
	p_epoch_from NUMERIC,
	p_epoch_to NUMERIC,
	mα NUMERIC,
	mδ NUMERIC
)
RETURNS astronomia.ecliptic_coordinates
AS $$

DECLARE
	t_ep astronomia.ecliptic_precessor%rowtype;
	t_coordinates astronomia.ecliptic_coordinates%rowtype := p_ecl_from;
	t_t NUMERIC := p_epoch_to - p_epoch_from;

BEGIN
	t_ep := astronomia.new_ecliptic_precessor(p_epoch_from, p_epoch_to);
	IF mα != 0 OR mδ != 0 THEN
		t_coordinates := astronomia.proper_precession_motion(mα, mδ, p_epoch_from, p_ecl_from);
		--RAISE EXCEPTION 'precess_ecliptic_position: t_coordinates: %;', t_coordinates;
		t_coordinates.longitude := p_ecl_from.longitude + t_coordinates.longitude * t_t;
		t_coordinates.latitude := p_ecl_from.latitude + t_coordinates.latitude * t_t;
	END IF;
	RETURN astronomia.ecliptic_precess(t_ep, t_coordinates);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
