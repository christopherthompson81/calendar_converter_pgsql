DO $$ BEGIN
	CREATE TYPE calendars.chinese_solar_term AS
	(
		term INTEGER,
		longitude NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;