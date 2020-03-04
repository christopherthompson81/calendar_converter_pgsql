DROP TABLE IF EXISTS astronomia.planet_data CASCADE;
CREATE TABLE astronomia.planet_data (
	planet_data_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	planet_name TEXT,
	param1 TEXT,
	param1_id INTEGER,
	sequence INTEGER,
	data NUMERIC[3]
);