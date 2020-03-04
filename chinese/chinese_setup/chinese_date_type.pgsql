------------------------------------------
------------------------------------------
-- Chinese Calendar Date type
--
-- cycle - chinese 60 year cicle
-- year - chinese year of cycle
-- month - chinese month
-- leap - `true` if leap month
-- day - chinese day
------------------------------------------
------------------------------------------
--
DO $$ BEGIN
	CREATE TYPE calendars.chinese_date AS
	(
		cycle INTEGER,
		year INTEGER,
		month INTEGER,
		leap BOOLEAN,
		day INTEGER
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;

