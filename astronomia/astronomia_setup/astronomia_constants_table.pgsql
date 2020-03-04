-------------------------------------------------------------------------------
-- Astronomia NUMERIC Constants
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS astronomia.constants CASCADE;
CREATE TABLE astronomia.constants (
	constant_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	identifier TEXT,
	shorthand TEXT,
	description TEXT,
	derivation_method TEXT,
	reference TEXT,
	constant_value NUMERIC
);

INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'julian_date_epoch_2000',
	'J2000',
	'Julian date corresponding to January 1.5, year 2000',
	'asserted',
	'Chapter 21, p. 133',
	2451545.0
);
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'julian_year_days',
	'jd_year',
	'Julian year in days',
	'asserted',
	'Chapter 21, p. 133',
	365.25
);
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'julian_century_days',
	'jd_century',
	'Julian century in days',
	'asserted',
	'Chapter 21, p. 133',
	36525.0
);
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'gregorian_epoch_in_julian_days',
	'GREGORIAN0JD',
	'Julian date corresponding to October 15, 1582 (Gregorian Epoch)',
	'asserted',
	NULL,
	2299160.5
);
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'day_seconds',
	'SECS_OF_DAY',
	'Number of seconds in a day. ',
	'24 * 60 * 60',
	NULL,
	86400
);
-- ck: "mean lunar month expressed in centuries"?
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'mean_lunar_month_centuries',
	'mp_ck',
	'ck is the time, in centuries, between the instant of the new moon on 2000-01-06 and the first new moon thereafter.',
	'1 / 1236.85',
	'Chapter 49, Page 349 and 350',
	1 / 1236.85
);
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'degrees_to_radians_coefficient',
	'D2R',
	'The coefficient that generates radians when applied to a value expressed in degrees.',
	'PI() / 180',
	'Classical Trigonometry',
	PI() / 180
);
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'mean_lunar_month',
	'MEAN_LUNAR_MONTH',
	'Mean synodial lunar month',
	'asserted',
	'Chapter 49, Page 349',
	29.530588861
);
INSERT INTO astronomia.constants(identifier, shorthand, description, derivation_method, reference, constant_value)
VALUES (
	'besselian_year_days',
	'besselian_year',
	'Besselian year in days; equals mean tropical year',
	'asserted',
	'Chapter 21, p. 133',
	365.2421988
);
-------------------------------------------------------------------------------
-- Astronomia NUMERIC[] Constants
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS astronomia.array_constants CASCADE;
CREATE TABLE astronomia.array_constants (
	array_constant_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	identifier TEXT,
	shorthand TEXT,
	description TEXT,
	derivation_method TEXT,
	book_reference TEXT,
	constant_value NUMERIC[]
);

-- Julian
INSERT INTO astronomia.array_constants(identifier, shorthand, description, derivation_method, book_reference, constant_value)
VALUES (
	'days_of_year',
	'DAYS_OF_YEAR',
	'Array of the number of days prior to a given month (non-leap)',
	'asserted',
	'Classic Astronomy / Calendaring',
	ARRAY[0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
);
-- moon phase
INSERT INTO astronomia.array_constants(identifier, shorthand, description, derivation_method, book_reference, constant_value)
VALUES (
	'moon_phase_new_moon_coefficients',
	'mp_nc',
	'Array of the Horner? coefficients associated with a "new moon" moon phase',
	'asserted',
	'?',
	ARRAY[
		-0.4072, 0.17241, 0.01608, 0.01039, 0.00739,
		-0.00514, 0.00208, -0.00111, -0.00057, 0.00056,
		-0.00042, 0.00042, 0.00038, -0.00024, -0.00017,
		-0.00007, 0.00004, 0.00004, 0.00003, 0.00003,
		-0.00003, 0.00003, -0.00002, -0.00002, 0.00002
	]
);
INSERT INTO astronomia.array_constants(identifier, shorthand, description, derivation_method, book_reference, constant_value)
VALUES (
	'moon_phase_full_moon_coefficients',
	'mp_fc',
	'Array of the Horner? coefficients associated with a "full moon" moon phase',
	'asserted',
	'?',
	ARRAY[
		-0.40614, 0.17302, 0.01614, 0.01043, 0.00734,
		-0.00515, 0.00209, -0.00111, -0.00057, 0.00056,
		-0.00042, 0.00042, 0.00038, -0.00024, -0.00017,
		-0.00007, 0.00004, 0.00004, 0.00003, 0.00003,
		-0.00003, 0.00003, -0.00002, -0.00002, 0.00002
	]
);
INSERT INTO astronomia.array_constants(identifier, shorthand, description, derivation_method, book_reference, constant_value)
VALUES (
	'moon_phase_additional_corrections',
	'mp_ac',
	'Array of corrections associated with moon phase',
	'asserted',
	'?',
	ARRAY[
		0.000325, 0.000165, 0.000164, 0.000126, 0.00011,
		0.000062, 0.00006, 0.000056, 0.000047, 0.000042,
		0.000040, 0.000037, 0.000035, 0.000023
	]
);
