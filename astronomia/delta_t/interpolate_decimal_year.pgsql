-------------------------------------------------------------------------------
-- Interpolate Decimal Year
--
-- Get month of year from fraction. Fraction differs at leap years.
--
-- param - decimal year (julian)
-- Returns - ΔT in seconds.
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.interpolate_decimal_year(
	p_decimal_year NUMERIC,
	p_data astronomia.delta_t_data
)
RETURNS NUMERIC[]
AS $$

DECLARE
	t_modf NUMERIC[] := astronomia.modf(p_decimal_year);
	t_year NUMERIC := t_modf[1];
	t_f NUMERIC := t_modf[2];
	t_leap BOOLEAN := astronomia.leap_year_gregorian(p_decimal_year::INTEGER);
	t_yearly_fractions_per_month NUMERIC[] := (SELECT astronomia.generate_yearly_fractions_per_month(t_leap));
	t_month INTEGER;
	t_first NUMERIC;
	t_last NUMERIC;

BEGIN
	t_month := astronomia.bisect_right(t_yearly_fractions_per_month, t_f) - 1;
	t_first := t_yearly_fractions_per_month[t_month + 1];
	t_last := (
		CASE
			WHEN t_month < 11 THEN
				t_year + t_yearly_fractions_per_month[t_month + 1]
			ELSE
				t_year + 1 + t_yearly_fractions_per_month[(t_month + 2) % 12]
		END
	);
	--RAISE EXCEPTION 'interpolate_decimal_year: t_year: %; t_month: %; t_last: %; t_ymf: %', t_year, t_month, t_last, (t_month + 1) % 12;
	RETURN ARRAY[t_year, t_month, t_first, t_last];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
