-------------------------------------------------------------------------------
-- jd_to_calendar returns the calendar date for the given jd.
--
-- Note that this function returns a date in either the Julian or Gregorian
-- Calendar, as appropriate.
-- @param {number} jd - Julian day (float)
-- @param {boolean} isJulian - set true for Julian Calendar, otherwise Gregorian is used
-- @returns {object} `{ (int) year, (int) month, (float) day }`
--
--export function JDToCalendar (jd, isJulian) {
--	const [z, f] = base.modf(jd + 0.5)
--	let a = z
--	if (!isJulian) {
--		const α = base.floorDiv(z * 100 - 186721625, 3652425)
--		a = z + 1 + α - base.floorDiv(α, 4)
--	}
--	const b = a + 1524
--	const c = base.floorDiv(b * 100 - 12210, 36525)
--	const d = base.floorDiv(36525 * c, 100)
--	const e = int(base.floorDiv((b - d) * 1e4, 306001))
--	// compute return values
--	let year
--	let month
--	const day = (int(b - d) - base.floorDiv(306001 * e, 1e4)) + f
--	if (e === 14 || e === 15) {
--		month = e - 13
--	} else {
--		month = e - 1
--	}
--	if (month < 3) {
--		year = int(c) - 4715
--	} else {
--		year = int(c) - 4716
--	}
--	return { year, month, day }
--}

-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION astronomia.jd_to_calendar(
	p_jd NUMERIC
)
RETURNS NUMERIC[]
AS $$

DECLARE
	-- Constants
	GREGORIAN0JD NUMERIC := 2299160.5;
	-- Vars
	t_is_julian BOOLEAN := p_jd < GREGORIAN0JD;
	t_modf NUMERIC[] := astronomia.modf(p_jd + 0.5);
	t_z NUMERIC := t_modf[1];
	t_f NUMERIC := t_modf[2];
	α NUMERIC := FLOOR((t_z * 100.0 - 186721625.0) / 3652425.0);
	t_a NUMERIC := (
		CASE
		WHEN t_is_julian THEN
			t_z
		ELSE
			t_z + 1 + α - FLOOR(α / 4.0)
		END
	);
	t_b NUMERIC := t_a + 1524;
	t_c NUMERIC := FLOOR((t_b * 100 - 12210) / 36525);
	t_d NUMERIC := FLOOR((36525 * t_c) / 100);
	t_e NUMERIC := FLOOR(((t_b - t_d) * 10000) / 306001);
	-- compute return values
	t_day NUMERIC := ((t_b - t_d) - FLOOR((306001.0 * t_e) / 10000.0))::NUMERIC;
	t_month NUMERIC := (
		CASE
		WHEN t_e = 14 OR t_e = 15 THEN
			(t_e - 13)::NUMERIC
		ELSE
			(t_e - 1)::NUMERIC
		END
	);
	t_year NUMERIC := (
		CASE
		WHEN t_month < 3 THEN
			(t_c - 4715)::NUMERIC
		ELSE
			(t_c - 4716)::NUMERIC
		END
	);

BEGIN
	--RAISE EXCEPTION 'jd_to_calendar: p_jd: %; t_a: %; t_b: %; t_c: %; t_d: %; t_e: %;', p_jd, t_a, t_b, t_c, t_d, t_e;
	RETURN ARRAY[t_year, t_month, t_day] || astronomia.day_to_hms(t_f);
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
