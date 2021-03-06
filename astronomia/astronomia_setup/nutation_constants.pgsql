DROP TABLE IF EXISTS astronomia.nutation_periods CASCADE;
CREATE TABLE astronomia.nutation_periods (
	nutation_period_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	d INTEGER,
	m INTEGER,
	n INTEGER,
	f INTEGER,
	ω INTEGER,
	s0 INTEGER,
	s1 NUMERIC,
	c0 INTEGER,
	c1 NUMERIC
);

COMMENT ON TABLE astronomia.nutation_periods IS 'Periodic terms for the nutation in longitude (Δψ) and in obliquity (Δε). The unit is 0° 0007.
Astronomical Algorithms, Chapter 22, Table 22.A

Explanation of shorthand

The nutation algorithm uses the values in the table as coefficients to
generate the desired outputs, so they are not the outputs direclty and are
therefore not labeled as such.';

COMMENT ON COLUMN astronomia.nutation_periods.d IS 'Mean elongation of the moon from the sun - D => lunar_solar_mean_elongation';
COMMENT ON COLUMN astronomia.nutation_periods.m IS 'Mean anomaly of the Sun (Earth) - M -> solar_mean_anomaly_earth';
COMMENT ON COLUMN astronomia.nutation_periods.n IS 'Mean anomaly of the Moon - M′ => lunar_mean_anomaly';
COMMENT ON COLUMN astronomia.nutation_periods.f IS 'Moon''s argument of latitude - F => lunar_latitude';
COMMENT ON COLUMN astronomia.nutation_periods.ω IS 'Longitude of the ascending node of the Moon''s mean orbit on the ecliptic, measured from the mean equinox of the date - Ω / ω => lunar_ascending_node_longitude';
COMMENT ON COLUMN astronomia.nutation_periods.s0 IS 'Coefficient of the sine of the argument Nutation in Longitude - Δψ - Part 1 => sin0';
COMMENT ON COLUMN astronomia.nutation_periods.s1 IS 'Coefficient of the sine of the argument Nutation in Longitude - Δψ - Part 2 => sin1';
COMMENT ON COLUMN astronomia.nutation_periods.s0 IS 'Coefficient of the cosine of the argument Nutation in Obliquity - Δε - Part 1 => cos0';
COMMENT ON COLUMN astronomia.nutation_periods.s1 IS 'Coefficient of the cosine of the argument Nutation in Obliquity - Δε - Part 2 => cos1';

INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 0, 0, 1, -171996, -174.2, 92025, 8.9);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 0, 2, 2, -13187, -1.6, 5736, -3.1);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 0, 2, 2, -2274, -0.2, 977, -0.5);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 0, 0, 2, 2062, 0.2, -895, 0.5);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 1, 0, 0, 0, 1426, -3.4, 54, -0.1);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 1, 0, 0, 712, 0.1, -7, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 1, 0, 2, 2, -517, 1.2, 224, -0.6);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 0, 2, 1, -386, -0.4, 200, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 1, 2, 2, -301, 0, 129, -0.1);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, -1, 0, 2, 2, 217, -0.5, -95, 0.3);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 1, 0, 0, -158, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 0, 2, 1, 129, 0.1, -70, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, -1, 2, 2, 123, 0, -53, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, 0, 0, 0, 63, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 1, 0, 1, 63, 0.1, -33, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, -1, 2, 2, -59, 0, 26, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, -1, 0, 1, -58, -0.1, 32, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 1, 2, 1, -51, 0, 27, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 2, 0, 0, 48, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, -2, 2, 1, 46, 0, -24, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, 0, 2, 2, -38, 0, 16, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 2, 2, 2, -31, 0, 13, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 2, 0, 0, 29, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 1, 2, 2, 29, 0, -12, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 0, 2, 0, 26, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 0, 2, 0, -22, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, -1, 2, 1, 21, 0, -10, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 2, 0, 0, 0, 17, -0.1, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, -1, 0, 1, 16, 0, -8, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 2, 0, 2, 2, -16, 0.1, 7, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 1, 0, 0, 1, -15, 0, 9, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 1, 0, 1, -13, 0, 7, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, -1, 0, 0, 1, -12, 0, 6, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 2, -2, 0, 11, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, -1, 2, 1, -10, 0, 5, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, 1, 2, 2, -8, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 1, 0, 2, 2, 7, 0, -3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 1, 1, 0, 0, -7, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, -1, 0, 2, 2, -7, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, 0, 2, 1, -7, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, 1, 0, 0, 6, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 2, 2, 2, 6, 0, -3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 1, 2, 1, 6, 0, -3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, -2, 0, 1, -6, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, 0, 0, 0, 1, -6, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, -1, 1, 0, 0, 5, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, -1, 0, 2, 1, -5, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 0, 0, 1, -5, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 2, 2, 1, -5, 0, 3, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 0, 2, 0, 1, 4, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 1, 0, 2, 1, 4, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 1, -2, 0, 4, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-1, 0, 1, 0, 0, -4, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-2, 1, 0, 0, 0, -4, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(1, 0, 0, 0, 0, -4, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 1, 2, 0, 3, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, -2, 2, 2, -3, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(-1, -1, 1, 0, 0, -3, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 1, 1, 0, 0, -3, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, -1, 1, 2, 2, -3, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, -1, -1, 2, 2, -3, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(0, 0, 3, 2, 2, -3, 0, 0, 0);
INSERT INTO astronomia.nutation_periods (d, m, n, f, ω, s0, s1, c0, c1)
VALUES(2, -1, 0, 2, 2, -3, 0, 0, 0);