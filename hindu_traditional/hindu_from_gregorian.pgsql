-------------------------------------------------------------------------------
-- Return a Hindu date object from a gregorian date
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.hindu_from_gregorian(
	p_date DATE
)
RETURNS NUMERIC AS $$

DECLARE
	t_jd NUMERIC := astronomia.gregorian_to_jd(p_date::TIMESTAMP);
	hindu_years INTEGER[] := calendars.hindu_years_from_jd(t_jd);
	solar_month INTEGER := calendars.hindu_solar_month_from_jd(t_jd);
	lunar_month INTEGER := calendars.hindu_lunar_month_from_jd(t_jd);
	leap_month BOOLEAN := calendars.hindu_jd_is_in_lunar_leap_month(t_jd);
	lunar_days calendars.hindu_lunar_day[] := calendars.hindu_lunar_day_from_jd(t_jd);
	--srise = sunrise(jd, place)[1]
	--sset = sunset(jd, place)[1]
	--nak = nakshatra(jd, place)
	--yog = yoga(jd, place)
	--rtu = ritu(mas[0])
	--kar = karana(jd, place)
	--vara = vaara(jd)
	--kday = ahargana(jd)
	--samvat = samvatsara(jd, mas[0])
	--day_dur = day_duration(jd, place)[1]
	--gauri = self.gauri_panchanga(jd)
	--positions = self.kundali(jd)
	--self.set_place(event)
	--place = self.place

BEGIN
	RETURN tbd;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;


