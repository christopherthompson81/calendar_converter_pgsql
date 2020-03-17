# Hindu Calendar Nomenclature

## Time Keeping Constructs

### Saka Year

The year count since the Saka epoch.

The Saka epoch started on the vernal equinox of the year AD 78 (Julian Calendar). So (roughly) the Gregorian Year minus 78.

### Kali Yuga Year

Another Epoch: 17/18 February 3102 BCE.

This reckoning does not appear to be used in determining holidays and festivals.

### Vikrama Year

Another Epoch: "Vikrama era". The Ujjain calendar started around 58–56 BCE.

Related to the Vikrama Samvat calendar.

### Ahargana

epoch-midnight to given midnight
Days elapsed since beginning of Kali Yuga

Similar to julian days or ordinal days

### Maasa

Lunar Months

### Raasi

Solar Months

### Asura / Adhika

Reference to a lunar leap month. A lunar month will repeat to correct solar and lunar alignment. The second one is the "real" one.

Test: is_leap_month = (this_solar_month == next_solar_month)

### Divasa

The solar day or civil day, called divasa (दिवस),

### Tithi

The lunar day is called tithi (तिथि), and this is based on complicated measures of lunar movement. A lunar day or tithi may, for example, begin in the middle of an afternoon and end next afternoon.

A Tithi is technically defined in Indian texts, states John E. Cort, as "the time required by the combined motions of the sun and moon to increase (in a bright fortnight) or decrease (in a dark fortnight) their relative distance by twelve degrees of the zodiac. These motions are measured using a fixed map of celestial zodiac as reference, and given the elliptical orbits, a duration of a tithi varies between 21.5 and 26 hours, states Cort.

However, in the Indian tradition, the general population's practice has been to treat a tithi as a solar day between one sunrise to next.

A lunar month has 30 tithi. The technical standard makes each tithi contain different number of hours, but helps the overall integrity of the calendar. Given the variation in the length of a solar day with seasons, and moon's relative movements, the start and end time for tithi varies over the seasons and over the years, and the tithi adjusted to sync with divasa periodically with intercalation.

## Time Keeping Constructs that are meaningless for calculating holidays and festivals

### Samvat / Samvatsara

60 Year cycle of year names

### Ritu

Agricultural Season (0 - 5)

"0": "Vasanta" -- Spring
"1": "Grīṣma",
"2": "Varṣā",
"3": "Śarad",
"4": "Hemanta",
"5": "Śiśira"

### Varas / Vaara

Weekdays (0-6)

The weekdays appear to be directly alignable to Gregorian weekdays

"""Weekday for given Julian day. 0 = Sunday, 1 = Monday,..., 6 = Saturday"""
  return int(ceil(jd + 1) % 7)

### Gauri

The day duration is divided into 8 parts
Similarly night duration

### Durmuhurtha

Like hours - 48 minute blocks

### Kalam / Three Kalams / Trikalam

A certain amount of time every day which lasts approximately for one and a half hours.

rahu_kalam = lambda jd, place: trikalam(jd, place, 'rahu')
yamaganda_kalam = lambda jd, place: trikalam(jd, place, 'yamaganda')
gulika_kalam = lambda jd, place: trikalam(jd, place, 'gulika')

### Abhijit Muhurta

I think this is somehow equivalent to "noon"

## Non Time Keeping Constructs

### Yoga

This appears to be an astrological construct and not a time-keeping construct because the selected value day-to-day will approximate random selection rather than be sequential.

The Sanskrit word Yoga means "union, joining, attachment", but in astronomical context, this word means latitudinal and longitudinal information. The longitude of the sun and the longitude of the moon are added, and normalised to a value ranging between 0° to 360° (if greater than 360, one subtracts 360). This sum is divided into 27 parts. Each part will now equal 800' (where ' is the symbol of the arcminute which means 1/60 of a degree). These parts are called the yogas. They are labelled:

Viṣkambha
Prīti
Āyuśmān
Saubhāgya
Śobhana
Atigaṇḍa
Sukarma
Dhrti
Śūla
Gaṇḍa
Vṛddhi
Dhruva
Vyāghatā
Harṣaṇa
Vajra
Siddhi
Vyatipāta
Variyas
Parigha
Śiva
Siddha
Sādhya
Śubha
Śukla
Brahma
Māhendra
Vaidhṛti

Again, minor variations may exist. The yoga that is active during sunrise of a day is the prevailing yoga for the day.

### Karaṇa

A karaṇa is half of a tithi. To be precise, a karaṇa is the time required for the angular distance between the sun and the moon to increase in steps of 6° starting from 0°. (Compare with the definition of a tithi.)

Since the tithis are 30 in number, and since 1 tithi = 2 karaṇas, therefore one would logically expect there to be 60 karaṇas. But there are only 11 such karaṇas which fill up those slots to accommodate for those 30 tithis. There are actually 4 "fixed" (sthira) karaṇas and 7 "repeating" (cara) karaṇas.

The 4

Śakuni (शकुनि)
Catuṣpāda (चतुष्पाद)
Nāga (नाग)
Kiṃstughna(किंस्तुघ्न)

The 7 "repeating" karaṇas are:

Vava or Bava (बव)
Valava or Bālava (बालव)
Kaulava (कौलव)
Taitila or Taitula (तैतिल)
Gara or Garaja (गरज)
Vaṇija (वणिज)
Viṣṭi (Bhadra) (भद्रा)

Now the first half of the 1st tithi (of Śukla Pakṣa) is always Kiṃtughna karaṇa. Hence this karaṇa is "fixed".
Next, the 7-repeating karaṇas repeat eight times to cover the next 56 half-tithis. Thus these are the "repeating" (cara) karaṇas.
The 3 remaining half-tithis take the remaining "fixed" karaṇas in order. Thus these are also "fixed" (sthira).
Thus one gets 60 karaṇas from those 11 preset karaṇas.

The Vedic day begins at sunrise. The karaṇa at sunrise of a particular day shall be the prevailing karaṇa for the whole day.

### Nakshatra

Nakshatras are divisions of ecliptic, each 13° 20', starting from 0° Aries. The purnima of each month is synchronised with a nakshatra.
