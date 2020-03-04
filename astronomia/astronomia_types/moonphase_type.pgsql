-------------------------------------------------------------------------------
-- Moonphase: Chapter 49, Phases of the Moon
-------------------------------------------------------------------------------

DO $$ BEGIN
	CREATE TYPE astronomia.moonphase AS
	(
		A NUMERIC[14],
		k NUMERIC,
		T NUMERIC,
		E NUMERIC,
		M NUMERIC,
		M_ NUMERIC,
		F NUMERIC,
		Ω NUMERIC
	);
EXCEPTION
	WHEN duplicate_object THEN null;
END $$;
