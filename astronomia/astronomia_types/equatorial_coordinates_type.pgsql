-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Equatorial coordinates are referenced to the Earth's rotational axis.
--
-- ra - Right ascension (α) in radians
-- dec - Declination (δ) in radians
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Table-based alternative
--
--DROP TABLE IF EXISTS astronomia.equatorial_coordinates CASCADE;
--CREATE TABLE coordinates (
--	equatorial_coordinate_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--	right_ascension NUMERIC NOT NULL DEFAULT 0,
--	declination NUMERIC NOT NULL DEFAULT 0
--);
-------------------------------------------------------------------------------

DO $$ BEGIN
	CREATE TYPE astronomia.equatorial_coordinates AS
	(
		right_ascension NUMERIC,
		declination NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;