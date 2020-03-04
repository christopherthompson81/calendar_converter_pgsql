-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- celestial coordinates in right ascension and declination
-- or ecliptic coordinates in longitude and latitude
--
-- @param {number} ra - right ascension (or longitude)
-- @param {number} dec - declination (or latitude)
-- @param {number} [range] - distance
-- @param {number} [elongation] - elongation
--
-- I don't use this type
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DO $$ BEGIN
	CREATE TYPE astronomia.coordinates AS
	(
		right_ascension NUMERIC,
		declination NUMERIC,
		range_value NUMERIC,
		elongation NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;
