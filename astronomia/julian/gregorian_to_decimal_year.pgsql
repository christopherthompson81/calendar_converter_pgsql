-------------------------------------------------------------------------------
-- Convert a timestamp (without timezone) into a decimal year
--
-- Note: Take care for dates < GREGORIAN0JD as `date` is always within the
-- proleptic Gregorian Calender (javascript)
--
-- param - proleptic Gregorian date
-- Returns - decimal year
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.gregorian_to_decimal_year(
	p_date TIMESTAMP
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Date
	t_year INTEGER := DATE_PART('year', p_date)::INTEGER;
	t_year_days NUMERIC := (SELECT (make_date(t_year + 1, 1, 1) - make_date(t_year, 1, 1))::NUMERIC);
	t_doy NUMERIC := DATE_PART('doy', p_date)::NUMERIC;
	-- Time
	t_hour NUMERIC := DATE_PART('hour', p_date)::NUMERIC;
	t_minute NUMERIC := DATE_PART('minute', p_date)::NUMERIC;
	t_second NUMERIC := DATE_PART('seconds', p_date)::NUMERIC;
	t_ms NUMERIC := DATE_PART('milliseconds', p_date)::NUMERIC;
	-- fractional day of year
	t_days NUMERIC := t_doy + (t_hour + ((t_minute + ((t_second + t_ms / 1000.0) / 60.0)) / 60.0)) / 24.0;
	t_d_year NUMERIC := t_year::NUMERIC + (t_days / t_year_days);

BEGIN
	RETURN t_d_year;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
