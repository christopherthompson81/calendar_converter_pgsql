-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- ecliptic coordinates in longitude and latitude
--
-- π = orbital_ratio?
-- this.π = base.horner(t, πCoeff)

-- p = precession
-- this.p = base.horner(t, pCoeff) * t

-- The quantity 𝜼 is the angle between the ecliptic at the starting epoch and the ecliptic at the final epoch.
-- 𝜼 = angular_range?
-- this.sη = Math.sin(η)
-- this.cη = Math.cos(η)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DO $$ BEGIN
	CREATE TYPE astronomia.ecliptic_precessor AS
	(
		π NUMERIC,
		p NUMERIC,
		sη NUMERIC,
		cη NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;