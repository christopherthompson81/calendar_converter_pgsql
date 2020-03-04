-------------------------------------------------------------------------------
-- returns the difference ΔT = TD - UT between Dynamical Time TD and
-- Univeral Time (GMT+12) in second
--
-- Polynoms are from <http://eclipse.gsfc.nasa.gov/SEcat5/deltatpoly.html>
-- and <http://www.staff.science.uu.nl/~gent0113/deltat/deltat_old.htm>
--
-- param - decimal year
-- Returns - ΔT in seconds.
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION astronomia.delta_t(
	p_decimal_year NUMERIC
)
RETURNS NUMERIC
AS $$

DECLARE
	-- VSOP87B Data
	DELTA_T_HISTORIC astronomia.delta_t_data%rowtype;
	DELTA_T_DATA astronomia.delta_t_data%rowtype;
	DELTA_T_PREDICTION astronomia.delta_t_data%rowtype;
	-- Constant
	u CONSTANT NUMERIC := (p_decimal_year - 1820) / 100;
	-- Return Variable
	ΔT NUMERIC;

BEGIN
	SELECT * INTO DELTA_T_HISTORIC FROM astronomia.delta_t_data WHERE table_name = 'historic';
	SELECT * INTO DELTA_T_DATA FROM astronomia.delta_t_data WHERE table_name = 'data';
	SELECT * INTO DELTA_T_PREDICTION FROM astronomia.delta_t_data WHERE table_name = 'prediction';
	IF p_decimal_year < -500 THEN
		ΔT := astronomia.horner(
			(p_decimal_year - 1820) * 0.01,
			ARRAY[-20, 0, 32]
		);
	ELSIF p_decimal_year < 500 THEN
		ΔT = astronomia.horner(
			p_decimal_year * 0.01,
			ARRAY[
				10583.6,
				-1014.41,
				33.78311,
				-5.952053,
				-0.1798452,
				0.022174192,
				0.0090316521
			]
		);
	ELSIF p_decimal_year < 1600 THEN
		ΔT := astronomia.horner(
			(p_decimal_year - 1000) * 0.01,
			ARRAY[
				1574.2,
				-556.01,
				71.23472,
				0.319781,
				-0.8503463,
				-0.005050998,
				0.0083572073
			]
		);
	ELSIF p_decimal_year < DELTA_T_HISTORIC.first THEN
		ΔT := astronomia.horner(
			(p_decimal_year - 1600),
			ARRAY[
				120,
				-0.9808,
				-0.01532,
				1 / 7129
			]
		);
	ELSIF p_decimal_year < DELTA_T_DATA.first THEN
		ΔT := astronomia.interpolate(p_decimal_year, DELTA_T_HISTORIC);
	-- -0.25 ~= do not consider last 3 months in dataset
	ELSIF p_decimal_year < DELTA_T_DATA.last - 0.25 THEN 
		ΔT := astronomia.interpolate_data(p_decimal_year, DELTA_T_DATA);
	ELSIF p_decimal_year < DELTA_T_PREDICTION.last THEN
		ΔT := astronomia.interpolate(p_decimal_year, DELTA_T_PREDICTION);
	ELSIF p_decimal_year < 2050 THEN
		ΔT := astronomia.horner(
			(p_decimal_year - 2000) / 100,
			ARRAY[
				62.92,
				32.217,
				55.89
			]
		);
	ELSIF p_decimal_year < 2150 THEN
		ΔT := astronomia.horner(
			(p_decimal_year - 1820) / 100,
			ARRAY[
				-205.72,
				56.28,
				32
			]
		);
	ELSE
		ΔT := -20 + 32 * u * u;
	END IF;
	RETURN ΔT;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
