-------------------------------------------------------------------------------
-- interpolation of dataset
--
-- param - decimal year (julian)
-- Returns - ΔT in seconds.
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.interpolate(
	p_decimal_year NUMERIC,
	p_data astronomia.delta_t_data
)
RETURNS NUMERIC
AS $$

DECLARE
	t_d3 astronomia.len3%rowtype := astronomia.len3_for_interpolate_x(
		p_decimal_year,
		p_data.first,
		p_data.last,
		p_data.value
	);

BEGIN
	RETURN astronomia.len3_interpolate_x(t_d3, p_decimal_year);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
