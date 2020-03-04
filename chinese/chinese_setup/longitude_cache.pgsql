-- ecliptic longitude in radians NUMERIC indexed by JDE
-- remember to use ON CONFLICT DO NOTHING
DROP TABLE IF EXISTS calendars.longitude_cache CASCADE;
CREATE TABLE calendars.longitude_cache (
	longitude_cache_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	jde NUMERIC UNIQUE,
	ecliptic_longitude NUMERIC
);