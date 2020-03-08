-------------------------------------------------------------------------------
-- time/date at UTC midnight - truncate `jde` to actual day
--
--  midnight (jde) {
--    const gcal = new julian.CalendarGregorian().fromJDE(jde)
--    const ts = 0.5 - this.timeshiftUTC(gcal)
--    let mn = Math.trunc(gcal.toJD() - ts) + ts
--    mn = gcal.fromJD(mn).toJDE()
--    if (toFixed(jde, 5) === toFixed(mn, 5) + 1) {
--      return jde
--    }
--    return mn
--  }
--
-- Param NUMERIC jde
-- Param NUMERIC p_time_shift - decimal hours delta from UTC (works like timezones)
-- Returns NUMERIC jde - shifted to midnight plus whatever offset was provided
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.midnight_offset(
	p_jde NUMERIC,
	p_time_shift NUMERIC DEFAULT 0
)
RETURNS NUMERIC
AS $$

DECLARE
	t_time_shift_days NUMERIC := p_time_shift / 24;
	t_jde NUMERIC := p_jde + t_time_shift_days;
	t_calendar NUMERIC[] := astronomia.jde_to_calendar(t_jde);
	t_midnight NUMERIC := astronomia.gregorian_to_jde(make_date(
		t_calendar[1]::INTEGER,
		t_calendar[2]::INTEGER,
		t_calendar[3]::INTEGER
		)::TIMESTAMP
	);

BEGIN
	RETURN t_midnight;
END;

$$ LANGUAGE plpgsql;