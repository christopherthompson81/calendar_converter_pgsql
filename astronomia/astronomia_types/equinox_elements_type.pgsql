-------------------------------------------------------------------------------
-- Elements are the orbital elements of a solar system object which change
-- from one equinox to another.
--
-- inc  - inclination
-- node - longitude of ascending node (Ω)
-- peri - argument of perihelion (ω)
-------------------------------------------------------------------------------

DO $$ BEGIN
	CREATE TYPE astronomia.equinox_elements AS
	(
		inclination NUMERIC,
		ascending_node_longitude NUMERIC,
		perihelion_argument NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;
