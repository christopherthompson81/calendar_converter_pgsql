-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Calendar Constants
--
-- Implemented
-- * Chinese
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DROP TABLE IF EXISTS calendars.constants CASCADE;
CREATE TABLE calendars.constants (
	constant_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	calendar_type TEXT,
	identifier TEXT,
	shorthand TEXT,
	description TEXT,
	constant_value NUMERIC
);

-- Double-Check Precision
-- const epoch = new julian.CalendarGregorian(epochY, 2, 15).toJDE()
-- JD creation may be flawed by 0.5 days.
INSERT INTO calendars.constants(calendar_type, identifier, shorthand, description, constant_value)
VALUES (
	'chinese',
	'chinese_calendar_jd_epoch',
	'epoch',
	'Start of Chinese Calendar is 2636-02-15 BCE by Chalmers',
	astronomia.calendar_to_jd(ARRAY[-2636, 2, 15, 0, 0, 0, 0]::NUMERIC[])
);
INSERT INTO calendars.constants(calendar_type, identifier, shorthand, description, constant_value)
VALUES (
	'chinese',
	'chinese_calendar_epoch_year',
	'epoch_y',
	'Start of Chinese Calendar in 2636 BCE by Chalmers',
	-2636
);
