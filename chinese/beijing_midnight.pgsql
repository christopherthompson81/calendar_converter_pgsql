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
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.beijing_midnight(
	p_jde NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Calendar array: (y, m, d, h, m, s, ms, neg)
	t_calendar NUMERIC[] := astronomia.jde_to_calendar(p_jde);
	t_time_shift NUMERIC := calendars.get_beijing_utc_delta(t_calendar[1]::INTEGER);
	t_midnight NUMERIC;
	-- Time
	t_hour NUMERIC;
	t_minute NUMERIC;
	t_second NUMERIC;
	t_ms NUMERIC;
	-- fractional day of year
	t_day_fraction NUMERIC;

BEGIN
	t_calendar := astronomia.jde_to_calendar(p_jde + t_time_shift);
	-- Time
	t_hour := t_calendar[4];
	t_minute := t_calendar[5];
	t_second := t_calendar[6];
	t_ms := t_calendar[7];
	-- Fractional day
	t_day_fraction := (t_hour + ((t_minute + ((t_second + t_ms / 1000.0) / 60.0)) / 60.0)) / 24.0;
	-- Add one minute back to prevent flipping to the previous day
	t_day_fraction := t_day_fraction - 60 / 86400.0;
	-- Midnight
	t_midnight := p_jde + t_time_shift - t_day_fraction;
	RETURN t_midnight;
END;

$$ LANGUAGE plpgsql;