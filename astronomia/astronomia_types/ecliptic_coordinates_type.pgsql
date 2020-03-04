-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- ecliptic coordinates in longitude and latitude
--
-- IMPORTANT: Longitudes are measured *positively* westwards
-- e.g. Washington D.C. +77°04; Vienna -16°23'
--
-- latitude - Latitude (β) in radians
-- longitude - Longitude (λ) in radians
-- range - distance
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Table-based alternative
--
--DROP TABLE IF EXISTS astronomia.ecliptic_coordinates CASCADE;
--CREATE TABLE coordinates (
--	ecliptic_coordinate_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--	latitude NUMERIC NOT NULL DEFAULT 0,
--	longitude NUMERIC NOT NULL DEFAULT 0
--	range_value NUMERIC
--);
-------------------------------------------------------------------------------
--
DO $$ BEGIN
	CREATE TYPE astronomia.ecliptic_coordinates AS
	(
		longitude NUMERIC,
		latitude NUMERIC,
		range_value NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;
