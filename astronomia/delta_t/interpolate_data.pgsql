-------------------------------------------------------------------------------
-- interpolation of dataset from finals2000A with is one entry per month
-- linear interpolation over whole dataset is inaccurate as points per month
-- are not equidistant. Therefore points are approximated using 2nd diff. interpolation
-- from current month using the following two points
--
-- param - decimal year
-- Returns - ΔT in seconds.
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.interpolate_data(
	p_decimal_year NUMERIC,
	p_data astronomia.delta_t_data
)
RETURNS NUMERIC
AS $$

DECLARE
	t_f_year INTEGER := p_data.first_ym[1];
	t_f_month INTEGER := p_data.first_ym[2];
	t_moy NUMERIC[] := astronomia.interpolate_decimal_year(p_decimal_year, p_data);
	t_year NUMERIC := t_moy[1];
	t_month NUMERIC := t_moy[2];
	t_first NUMERIC := t_moy[3];
	t_last NUMERIC := t_moy[4];
	t_pos NUMERIC := 12 * (t_year - t_f_year) + (t_month - t_f_month);
	t_table NUMERIC[] := p_data.value[t_pos:t_pos + 2];
	t_d3 astronomia.len3%rowtype := astronomia.new_len3(t_first, t_last, t_table);

BEGIN
	--RAISE EXCEPTION 'interpolate_data: t_f_year: %; t_moy: %; t_pos: %; p_data.value: %', t_f_year, t_moy, t_pos, p_data.value[t_pos:t_pos + 2];
	--RAISE EXCEPTION 'interpolate_data: t_d3: %; p_decimal_year: %', t_d3, p_decimal_year;
	RETURN astronomia.len3_interpolate_x(t_d3, p_decimal_year);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
