------------------------------------------
------------------------------------------
-- date_parts type
------------------------------------------
------------------------------------------
--
DO $$ BEGIN
	CREATE TYPE calendars.date_parts AS
	(
		year_value INTEGER,
		month_value INTEGER,
		day_value INTEGER
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;
