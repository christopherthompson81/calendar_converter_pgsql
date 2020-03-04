-- Winter solstice date in JDE NUMERIC indexed by gregorian_year
-- remember to use ON CONFLICT DO NOTHING
DROP TABLE IF EXISTS calendars.winter_solstice_cache CASCADE;
CREATE TABLE calendars.winter_solstice_cache (
	winter_solstice_cache_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	gregorian_year INTEGER UNIQUE,
	jde NUMERIC
);
