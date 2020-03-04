-------------------------------------------------------------------------------
-- precess_reduce_elements reduces orbital elements of a solar system body from one
-- equinox to another.
--
-- This function is described in chapter 24, but is located in this
-- package so it can be a method of ecliptic_precessor.
--
-- Param astronomia.equinox_elements p_e_from
-- Returns astronomia.equinox_elements t_e_to
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.precess_reduce_elements(
	p_eclptic_precessor astronomia.ecliptic_precessor,
	p_e_from astronomia.equinox_elements
)
RETURNS astronomia.ecliptic_coordinates
AS $$

DECLARE
	-- Shorthand out p_eclptic_precessor
	π NUMERIC := p_eclptic_precessor.π;
	p NUMERIC := p_eclptic_precessor.p;
	sη NUMERIC := p_eclptic_precessor.sη;
	cη NUMERIC := p_eclptic_precessor.cη;
	-- Build parameters
	ψ NUMERIC := π + p;
	si NUMERIC := SIN(p_e_from.inclination);
	ci NUMERIC := COS(p_e_from.inclination);
	snp NUMERIC := SIN(p_e_from.ascending_node - π);
	cnp NUMERIC := COS(p_e_from.ascending_node - π);
	t_e_to astronomia.equinox_elements%rowtype;

BEGIN
	-- (24.1) p. 159
	t_e_to.inclination := ACOS(ci * cη + si * sη * cnp);
	-- (24.2) p. 159
	t_e_to.ascending_node := ATAN2(si * snp, cη * si * cnp - sη * ci) + ψ;
	-- (24.3) p. 159
	t_e_to.perihelion_argument := ATAN2(-1 * sη * snp, si * cη - ci * sη * cnp) + p_e_from.perihelion_argument;
	RETURN t_e_to;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
