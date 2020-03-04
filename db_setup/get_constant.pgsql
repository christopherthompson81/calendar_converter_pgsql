-------------------------------------------------------------------------------
-- Get a stored calendar constant
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.get_constant(p_calendar_type TEXT, p_identifier TEXT)
RETURNS NUMERIC
AS $$

DECLARE
	t_constant NUMERIC = (
		SELECT
			constant_value
		FROM
			calendars.constants
		WHERE
			calendar_type = p_calendar_type
		AND
			identifier = p_identifier
	);

BEGIN
	RETURN t_constant;
END;

$$ LANGUAGE plpgsql;