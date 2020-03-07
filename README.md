# calendar_converter_pgsql
Package to convert dates between various in-use (2020) or mathamatically useful calendars.

Calendars that are historical, proposed, disused, in limited-use, special-purpose, or fictional will be given a much lower priority.

# Installation:

There are files provided which will create schemas and functions in your database. The calendar converter package is intended to reside in a new "calendar" schema.

1. Create the calendar schema using the files in /db_setup/calendar_schema.pgsql

Alternatively, you can use the python loader.

1. Create a postgresql_config.json file using postgresql_config.example.json as a template
2. Install pipenv

		pip install pipenv

3. Use pipenv to install the prerequisite python modules

		pipenv install

4.  Run the loader

		pipenv run python .\build_calendar_schema.py

# Usage:

The high-level functions within the package largely provide functions which either accept or output a gregorian date in relation to another calendar type. From a utility perspective, many other interstitial conversion functions are also available.

A convienience "by calendar" function is also provided which will parse a string as it relates to a specified calendar and return both a gregorian and JSONB object with calendar-specific organization.

	SELECT * FROM calendars.by_calendar('hijri', '24 Jumada al-thani, 1441');

or with an integer array

	SELECT * FROM calendars.by_calendar('hijri', ARRAY[1441, 6, 24]);

or with a gregorian input

	SELECT * FROM calendars.by_calendar('hijri', '2020-02-19'::DATE);

or with a string of year-internal information and a gregorian year (multiple rows could be returned)

	SELECT * FROM calendars.by_calendar('hijri', '24 Jumada al-thani', 2020);

or with an integer array of year-internal information and a gregorian year (multiple rows could be returned)

	SELECT * FROM calendars.by_calendar('hijri', ARRAY[6, 24], 2020);

These queries would output two columns as follows:

	gregorian [DATE]: "2020-02-19",
	target_calendar [JSONB] {
		"calendar": "hijri",
		"year": 1441,
		"month": 6,
		"day": 24,
		"month_object" : {
			"scalar": 6,
			"transliterated": "Jumādā ath-Thāniyah / Jumādā al-ʾĀkhirah",
			"arabic": "''جُمَادَىٰ ٱلثَّانِيَة‎'' / ''جُمَادَىٰ ٱلْآخِرَة‎''",
			"meaning": "the last of parched land",
			"simple_latin": "Jumada al-thani"
		},
		"weekday_object": {
			"scalar": 3,
			"transliterated": "al-ʾArbiʿāʾ",
			"arabic": "ٱلْأَرْبِعَاء‎",
			"meaning": "the Fourth",
			"gregorian_equivalent": "Wednesday",
			"simple_latin": "Arbia"
		}
	}

# Currently Supported Calendar Types

* Chinese
* Hebrew
* Hijri
* Hindu (needs work)
* Jalali

# To Do

* Add unsupported calendars.
	* https://github.com/fitnr/convertdate
* Convenience Function (as described here) is not implemented yet

# Feedback

I openly solicit pull requests and issues as feedback to make this package better.

# Ported From Credits / Attributions

* Astronomia: 
	* [Astronomia](https://github.com/commenthol/astronomia)
	* [Meeus](https://github.com/soniakeys/meeus)
	* [Astronomica Algorithms - Jean Meeus](https://www.amazon.ca/Astronomical-Algorithms-Jean-Meeus/dp/0943396611)
* Parsing Calendar Strings
	* [date-holidays-parser](https://github.com/commenthol/date-holidays-parser)
* Chinese Date Support:
	* [date-chinese](https://github.com/commenthol/date-chinese)
* Hebrew Date Support:
	* [convertdate](https://pypi.org/project/convertdate/)
* Hindu Date Support:
	* [convertdate](https://pypi.org/project/convertdate/)
* Hijri Date Support
	* [hijri-converter](https://github.com/dralshehri/hijri-converter)
* Jalali Date Support
	* [khayyam](https://github.com/pylover/khayyam/)