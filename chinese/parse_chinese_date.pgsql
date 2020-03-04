-------------------------------------------------------------------------------
-- Function to parse a Chinese 'find date' string
--
-- For example: "chinese 01-0-01"
--
-- Param INTEGER p_g_year - Gregorian Year
-- Param TEXT p_c_string - find date string
-- Returns NUMERIC jde of date
-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calendars.parse_chinese_date(
	p_c_string TEXT,
	p_g_year INTEGER = NULL
)
RETURNS NUMERIC
AS $$

DECLARE
	-- Vars
	t_cap TEXT[];
	t_json JSONB;

BEGIN
	IF LOWER(p_c_string) ~ 'solarterm$' THEN
		-- Handle solar term parsing
		t_cap := regexp_match(p_c_string, '^(chinese|korean|vietnamese) (?:(\d+)-(\d{1,2})-)?(\d{1,2})-(\d{1,2}) solarterm');
		t_json := json_build_object(
			'calendar', t_cap[1],
			'c_cycle', t_cap[2],
			'c_year', t_cap[3],
			'c_solarterm', t_cap[4],
			'c_day', t_cap[5],
			'solarterm', TRUE::TEXT,
			'g_year', p_g_year::TEXT
		);
	ELSE
		-- Handle lunar month parsing
		t_cap := regexp_match(p_c_string, '^(chinese|korean|vietnamese) (?:(\d+)-(\d{1,2})-)?(\d{1,2})-([01])-(\d{1,2})');
		t_json := json_build_object(
			'calendar', t_cap[1],
			'c_cycle', t_cap[2],
			'c_year', t_cap[3],
			'c_lunar_month', t_cap[4],
			'c_leap_month', t_cap[5]::BOOLEAN::TEXT,
			'c_day', t_cap[6],
			'g_year', p_g_year::TEXT
		);
	END IF;
	RETURN calendars.find_chinese_date(t_json);
END;

$$ LANGUAGE plpgsql;