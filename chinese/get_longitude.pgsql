-------------------------------------------------------------------------------
-- Find the ecliptic longitude of earth for a given JDE
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_longitude(
	p_jde NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- JDE of the winter solstace for a specified gregorian year.
	t_ecliptic_longitude NUMERIC;

BEGIN
	-- If we've already done this, return the stored value
	SELECT
		ecliptic_longitude
	INTO
		t_ecliptic_longitude
	FROM
		calendars.longitude_cache
	WHERE
		jde = p_jde;

	IF t_ecliptic_longitude IS NOT NULL THEN
		RETURN t_ecliptic_longitude;
	END IF;
	
	-- Otherwise, derive the date
	t_ecliptic_longitude := (SELECT longitude FROM astronomia.solar_apparent_vsop87('earth', p_jde));
	
	-- ... and cache it
	INSERT INTO
		calendars.longitude_cache(
			jde,
			ecliptic_longitude
		)
	VALUES(
		p_jde,
		t_ecliptic_longitude
	)
	ON CONFLICT DO NOTHING;

    RETURN t_ecliptic_longitude;
END;

$$ LANGUAGE plpgsql;