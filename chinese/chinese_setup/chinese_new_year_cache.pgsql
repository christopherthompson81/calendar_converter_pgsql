-- Chinese New Year's Day in JDE NUMERIC indexed by gregorian_year
-- remember to use ON CONFLICT DO NOTHING
DROP TABLE IF EXISTS calendars.chinese_new_year_cache CASCADE;
CREATE TABLE calendars.chinese_new_year_cache (
	chinese_new_year_cache_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	gregorian_year INTEGER UNIQUE,
	jde NUMERIC
);
