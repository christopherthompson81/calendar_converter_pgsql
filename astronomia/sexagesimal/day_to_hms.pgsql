-------------------------------------------------------------------------------
-- Convert a decimal day to hours, minutes, seconds, and milliseconds
--
-- param - NUMERIC - p_day
-- Returns - NUMERIC[] - array of time
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.day_to_hms(
	p_day NUMERIC
)
RETURNS NUMERIC[]
AS $$

DECLARE
	-- Constants
	SECS_OF_DAY NUMERIC := 24 * 60 * 60;
	-- Variables
	t_neg NUMERIC := (CASE WHEN p_day < 0 THEN 1 ELSE 0 END);
	t_day_seconds NUMERIC := ABS(p_day * SECS_OF_DAY);
	t_hours NUMERIC = TRUNC(t_day_seconds / 3600, 0);
	t_minutes NUMERIC;
	t_seconds NUMERIC;
	t_milliseconds NUMERIC;
	t_modf NUMERIC[];

BEGIN
	t_day_seconds := t_day_seconds - (t_hours * 3600);
	t_minutes := TRUNC(t_day_seconds / 60, 0);
	t_seconds := t_day_seconds - (t_minutes * 60);
	t_modf := astronomia.modf(t_seconds);
	t_seconds := t_modf[1];
	t_milliseconds := TRUNC(t_modf[2] * 1000);
	RETURN ARRAY[t_hours % 24, t_minutes, t_seconds, t_milliseconds, t_neg];
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
