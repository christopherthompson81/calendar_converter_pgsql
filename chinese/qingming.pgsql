-------------------------------------------------------------------------------
-- Qı̄ngmíng - Pure brightness Festival
--
-- Param calendars.chinese_date - p_c_date - Chinese Date Object
-- Param INTEGER - p_g_year - gregorian year
-- Returns NUMERIC - p_jde - JDE at midnight
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.qingming(
  p_g_year INTEGER
)
RETURNS NUMERIC
AS $$

BEGIN
    RETURN calendars.get_chinese_solar_term(5, p_g_year);
END;

$$ LANGUAGE plpgsql;
