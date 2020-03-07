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
	t_midnight NUMERIC;
	-- Time
	t_hour NUMERIC;
	t_minute NUMERIC;
	t_second NUMERIC;
	t_ms NUMERIC;
	-- fractional day of year
	t_day_fraction NUMERIC;

BEGIN
	t_midnight := astronomia.jd_to_jde(TRUNC(astronomia.jde_to_jd(p_jde + t_time_shift_days)) + t_time_shift_days);
	RETURN t_midnight + 0.5 + (1.0 / 86400000.0);
END;

$$ LANGUAGE plpgsql;