-------------------------------------------------------------------------------
-- Find the next full moon after a given JDE (stored in seconds)
--
-- Returns the JDE of the instant of the closest full moon forward (at
-- midnight UTC)
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.date_to_next_full_moon(
	p_year INTEGER,
	p_month INTEGER,
	p_day INTEGER
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Constants
	LUNAR_OFFSET NUMERIC := astronomia.get_constant('mean_lunar_month') / 2;
	-- Vars
	t_date DATE := make_date(p_year, p_month, p_day);
	t_jde NUMERIC := astronomia.jd_to_jde(astronomia.gregorian_to_jde(t_date));
	t_next_full_moon NUMERIC;
	t_count INTEGER := 0;

BEGIN
	-- JDE at midnight
	t_next_full_moon := astronomia.moonphase_full_moon(
		astronomia.jde_to_julian_year(
			t_jde
		)
	);
	LOOP
		t_count := t_count + 1;
		EXIT WHEN t_next_full_moon >= t_jde OR t_count >= 4;
		t_next_full_moon := astronomia.moonphase_full_moon(
			astronomia.jde_to_julian_year(
				t_jde + t_count * LUNAR_OFFSET
			)
		);
	END LOOP;
    RETURN t_next_full_moon;
END;

$$ LANGUAGE plpgsql;