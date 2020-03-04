DROP TABLE IF EXISTS astronomia.delta_t_data CASCADE;
CREATE TABLE astronomia.delta_t_data (
	delta_t_data_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	table_name TEXT,
	first NUMERIC,
	last NUMERIC,
	first_ym INTEGER[2],
	last_ym INTEGER[2],
	value NUMERIC[]
);