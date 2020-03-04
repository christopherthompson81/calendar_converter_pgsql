-------------------------------------------------------------------------------
-- ecliptic_precess precesses coordinates ecl_from, leaving result in ecl_to.
--
-- The same struct may be used for ecl_from and ecl_to.
--
-- ecl_to is returned for convenience.
--
-- Param astronomia.ecliptic_coordinates p_ecl_from
-- Param astronomia.ecliptic_coordinates p_ecl_to
-- Returns astronomia.ecliptic_coordinates t_ecl_to
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.ecliptic_precess(
	p_eclptic_precessor astronomia.ecliptic_precessor,
	p_ecl_from astronomia.ecliptic_coordinates
)
RETURNS astronomia.ecliptic_coordinates
AS $$

DECLARE
	cos_small_angle NUMERIC := astronomia.get_constant('cos_small_angle');
	-- Shorthand out p_eclptic_precessor
	π NUMERIC := p_eclptic_precessor.π;
	p NUMERIC := p_eclptic_precessor.p;
	sη NUMERIC := p_eclptic_precessor.sη;
	cη NUMERIC := p_eclptic_precessor.cη;
	-- (21.7) p. 137
	sβ NUMERIC := SIN(p_ecl_from.latitude);
	cβ NUMERIC := COS(p_ecl_from.latitude);
	sd NUMERIC := SIN(π - p_ecl_from.longitude);
	cd NUMERIC := COS(π - p_ecl_from.longitude);
	A NUMERIC := cη * cβ * sd - sη * sβ;
	B NUMERIC := cβ * cd;
	C NUMERIC := cη * sβ + sη * cβ * sd;
	t_ecl_to astronomia.ecliptic_coordinates%rowtype;

BEGIN
	t_ecl_to.longitude = p + π - ATAN2(A, B);
	IF C < cos_small_angle THEN
		t_ecl_to.latitude = ASIN(C);
	ELSE
		-- near pole
		t_ecl_to.latitude := ACOS(astronomia.hypot(A, B));
	END IF;
	RETURN t_ecl_to;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
