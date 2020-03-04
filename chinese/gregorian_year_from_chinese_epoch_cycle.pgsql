-------------------------------------------------------------------------------
-- Get Gregorian year from Epoch / Cycle
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.gregorian_year_from_chinese_epoch_cycle(
	p_c_cycle INTEGER,
	p_c_year INTEGER
)
RETURNS INTEGER
AS $$

DECLARE
	CHINESE_EPOCH_YEAR CONSTANT INTEGER := calendars.get_constant('chinese', 'chinese_calendar_epoch_year')::INTEGER;

BEGIN
	RETURN CHINESE_EPOCH_YEAR + (p_c_cycle - 1) * 60 + (p_c_year - 1);
END;

$$ LANGUAGE plpgsql;