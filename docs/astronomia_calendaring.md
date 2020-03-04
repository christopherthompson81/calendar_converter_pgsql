# Astronomia for Calendaring

This is a duplicative subset of the astronomia package which implements only the functions necessary to perpetually calculate calendar dates. It is extended for calendaring purposes where needed.

In short, it aims to be a means for deriving accurate historical and future instants and latitudes for equinoxes, solstices, and moon phases by using the VSOP87B dataset so that all the various calendar systems can have their dates (year, month, and event starts) imputed between -4713-01-01 and 3000-01-01.

# Necessary Functions, Types, and Data

Here are the functions, types, and data required by the Chinese calendar conversion algorithms:

* astronomia
	* base
		* coordinates
		* horner
		* j2000_century
	* constants
		* get_constant
	* coordinates
		* ecliptic
		* equitorial
	* data
		* delta_t
			* data
			* historic
			* prediction
		* vsop87b
			* earth
	* delta_t
		* delta_t
		* interpolate
		* interpolate_data
		* month_of_year
	* element_equinox
		* elements class
	* interpolation
		* len3 class
		* len3_for_interpolate_x
	* julian
		* calendar class
		* gregorian_to_dec_years
		* gregorian_to_jde
		* jd_to_jde
		* jde_to_gregorian
		* jde_to_jd
		* jde_to_julian_year
		* julian_year_to_jde
		* leap_year_gregorian
	* moonphase
		* mean
		* moon_phase class
		* moon_phase constants
		* new_moon
	* nutation
		* mean_obliquity
		* nutation
	* planet_position
		* planet class
			* position
	* precession
		* ecliptic_position
		* ecliptic_precessor class
	* sexagesimal
		* angle
		* hour_angle
	* solar
		* apparent_vsop87b
	* solstice
		* december2
		* longitude
		* solstice_constants

# Caching

For practical purposes, the earliest calendar epoch is also the earliest that calendar dates will need to work. This appears to be the Julian days epoch (JD0). The first instant of Julian Days reckoning is interpretable as being 12:00h, January 1, 4713 BC using the BC count in common-era (Gregorian-based) calendaring.

The Gregorian Epoch (GC0) is October 15, 1582; and this is October 5, 1582 Julian or 2299159.5 JD.

Instants are typically stored in decimal JDE (useful for conversion) or as DATE (easily readable) objects.

Most calendar systems are lunar, solar, or lunisolar and therefore rely on equinoxes, solstices, and moon phases. There are a limited number of these events between -4713-01-01 and now (2020), and therefore their longitude, latitude, and instant can be calculated once and persisted with a few hundred years of future capacity calculated for good measure (and a means of auto-populating if the system runs out). This should make most calendar calculations instant after the intial astronomical calculations. (12.37 complete moon phases / year; 2 equinox events per year; 2 solstice events per year; ~7000 cachable years; 114,590 lunisolar events to cache).
