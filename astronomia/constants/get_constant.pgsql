-------------------------------------------------------------------------------
-- Get a stored astronomia constant
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.get_constant(p_identifier TEXT)
RETURNS NUMERIC
AS $$

DECLARE
	t_constant NUMERIC = (
		SELECT
			constant_value
		FROM
			astronomia.constants
		WHERE
			identifier = p_identifier
	);

BEGIN
	RETURN t_constant;
END;

$$ LANGUAGE plpgsql;