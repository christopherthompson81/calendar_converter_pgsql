-------------------------------------------------------------------------------
-- Generate memoize yearly fractions per month
--
-- param - leap year boolean
-- Returns - numeric array with the fractional amount of elapsed year by the
-- first of each month.
--
-- SELECT astronomia.generate_yearly_fractions_per_month(TRUE)
-- SELECT astronomia.generate_yearly_fractions_per_month(FALSE)
--
-- These are generated in 88ms; SELECT 1 also requires 88ms, so it's the
-- probably the lower limit. No real need to memoize or cache.
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.generate_yearly_fractions_per_month(
	p_leap BOOLEAN
)
RETURNS NUMERIC[]
AS $$

DECLARE
	t_fractions NUMERIC[];
	t_fraction NUMERIC;
	t_months INTEGER[] := (SELECT ARRAY(SELECT generate_series(1, 12)));
	t_month INTEGER;
	-- 1999 is a known non-leap year; 2000 is a known leap year
	t_canonical_year INTEGER := (CASE WHEN NOT p_leap THEN 1999 ELSE 2000 END);

BEGIN
	FOREACH t_month IN ARRAY t_months
	LOOP
		t_fraction := astronomia.gregorian_to_decimal_year(make_date(t_canonical_year, t_month, 1)) - t_canonical_year::NUMERIC;
		t_fractions := ARRAY_APPEND(t_fractions, t_fraction);
	END LOOP;

	RETURN t_fractions;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
