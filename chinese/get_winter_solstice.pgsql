-------------------------------------------------------------------------------
-- Find the JDE of the winter solstice for a given Gregorian year
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_winter_solstice(
	p_g_year INTEGER
)
RETURNS NUMERIC
AS $$

DECLARE
	-- JDE of the winter solstace for a specified gregorian year.
	t_winter_solstice NUMERIC;

BEGIN
	-- If we've already done this, return the stored value
	SELECT
		jde
	INTO
		t_winter_solstice
	FROM
		calendars.winter_solstice_cache
	WHERE
		gregorian_year = p_g_year;

	IF t_winter_solstice IS NOT NULL THEN
		RETURN t_winter_solstice;
	END IF;
	
	-- Otherwise, derive the date
	t_winter_solstice := astronomia.solstice_december2(p_g_year);
	
	-- ... and cache it
	INSERT INTO
		calendars.winter_solstice_cache(
			gregorian_year,
			jde
		)
	VALUES(
		p_g_year,
		t_winter_solstice
	)
	ON CONFLICT DO NOTHING;

    RETURN t_winter_solstice;
END;

$$ LANGUAGE plpgsql;