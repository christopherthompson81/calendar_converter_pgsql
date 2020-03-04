-------------------------------------------------------------------------------
-- planet_position_sum
--
-- Param TEXT - p_planet_name
-- Param NUMERIC - p_t
-- Param TEXT - p_series - VSOP87 series name
-- Returns NUMERIC
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.planet_position_sum(
	p_planet_name TEXT,
	p_t NUMERIC,
	p_series TEXT
)
RETURNS NUMERIC
AS $$

DECLARE
	t_coefficients NUMERIC[] := (
		SELECT ARRAY(
			SELECT
				SUM(data[1] * COS(data[2] + data[3] * p_t))::NUMERIC AS coefficients
			FROM
				astronomia.planet_data
			WHERE
				planet_name = p_planet_name
			AND
				param1 = p_series
			GROUP BY
				param1_id
			ORDER BY
				param1_id
		)
	);
	t_result NUMERIC := astronomia.horner(p_t, t_coefficients);

BEGIN
	-- May be worthwhile to check if the planet is in the DB
	--RAISE EXCEPTION 'planet_position_sum: t_coefficients: %; p_t: %;', t_coefficients, p_t;
	RETURN t_result;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
