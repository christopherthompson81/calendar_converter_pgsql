"""
pgsql_holidays

Script for building the holidays schema in a configured PostgreSQL database
from source SQL files
"""
# Standard Imports
import json
import os
import re

# PyPi Imports
import psycopg2
import psycopg2.extras

# Local Imports
## None

###############################################################################
#
# Constants
#
###############################################################################

POSTGRESQL_CONFIG = 'postgresql_config.json'

DELTA_T_INSERT = """
INSERT INTO astronomia.delta_t_data(
	table_name,
	first,
	last,
	first_ym,
	last_ym,
	value
)
VALUES(
	%s,
	%s,
	%s,
	%s,
	%s,
	%s
)
"""

PLANET_DATA_INSERT = """
INSERT INTO astronomia.planet_data(
	planet_name,
	param1,
	param1_id,
	sequence,
	data
)
VALUES(
	%s,
	%s,
	%s,
	%s,
	%s
)
"""

###############################################################################
#
# General Functions
#
###############################################################################
class PqDbController():
	'''Top Level PostgreSQL database controller for SREDPrep'''
	def __init__(self):
		self.connection = None
		with open(POSTGRESQL_CONFIG) as config:
			self.pq_params = json.load(config)

	def connect_db(self):
		"""Connects to the specific database."""
		try:
			self.connection = psycopg2.connect(**self.pq_params)
		except psycopg2.DatabaseError as error:
			print(error)

	#Applies an SQL file to a database connection
	def apply_sql_file_to_db(self, sql_file):
		"""Applies an SQL file to a database connection"""
		query = open(sql_file, 'r', encoding='utf-8').read()
		cursor = self.connection.cursor()
		cursor.execute(query)
		self.connection.commit()
		return

	#Applies an SQL file to a database connection
	def apply_sql_folder_to_db(self, sql_folder):
		"""Applies an SQL file to a database connection"""
		sql_files = list()
		t_sql_folder = os.path.join(sql_folder)
		for filename in os.listdir(t_sql_folder):
			if os.path.isfile(os.path.join(t_sql_folder, filename)) and re.search(r'\.(pg)*sql$', filename):
				sql_files.append(os.path.join(t_sql_folder, filename))
			elif os.path.isdir(os.path.join(t_sql_folder, filename)):
				self.apply_sql_folder_to_db(os.path.join(sql_folder, filename))
		for sql_file in sql_files:
			print('Applying ' + sql_file)
			self.apply_sql_file_to_db(sql_file)
		return

	#Applies an SQL file to a database connection
	def apply_sql_folder_and_list_to_db(self, sql_folder, sql_list):
		"""Applies an SQL file to a database connection"""
		for filename in sql_list:
			sql_file = os.path.join(sql_folder, filename)
			print('Applying ' + sql_file)
			self.apply_sql_file_to_db(sql_file)
		return

	#Applies a JSON file to a database table
	def apply_vsop87_deltat_json_file(self, json_file):
		"""Applies a VSOP87 deltat JSON file to the database"""
		with open(json_file) as json_string:
			delta_t = json.load(json_string)
		cursor = self.connection.cursor()
		for table_name in delta_t:
			table = delta_t[table_name]
			first = table.get("first", None)
			last = table.get("last", None)
			first_ym = table.get("firstYM", None)
			last_ym = table.get("lastYM", None)
			data = table.get("table", None)
			cursor.execute(DELTA_T_INSERT, [table_name, first, last, first_ym, last_ym, data])
		self.connection.commit()

	def apply_vsop87_planet_json_file(self, json_file, planet_name):
		"""Applies a VSOP87 planet JSON file to the database"""
		with open(json_file) as json_string:
			planet = json.load(json_string)
		cursor = self.connection.cursor()
		for param_name in planet:
			if param_name not in ('L', 'B', 'R'):
				continue
			param = planet[param_name]
			for param_id in param:
				data = param[param_id]
				for i, row in enumerate(data):
					cursor.execute(PLANET_DATA_INSERT, [planet_name, param_name, param_id, i, row])
		self.connection.commit()

###############################################################################
#
# Main Functions
#
###############################################################################

# Builds the Astronomia database
def build_astronomia_db():
	"""Builds the astronomia database"""
	db = PqDbController()
	db.connect_db()
	print('Setting up Astronomia Schema')
	setup_path = os.path.join('astronomia', 'astronomia_setup')
	db.apply_sql_folder_and_list_to_db(setup_path, [
		'astronomia_schema.pgsql',
		'delta_t_data.pgsql',
		'planet_data.pgsql',
		'astronomia_constants_table.pgsql',
		'nutation_constants.pgsql',
	])
	print('Loading VSOP87B Data')
	delta_t_path = os.path.join('astronomia', 'astronomia_data', 'delta_t.json')
	db.apply_vsop87_deltat_json_file(delta_t_path)
	eath_data_path = os.path.join('astronomia', 'astronomia_data', 'earth.json')
	db.apply_vsop87_planet_json_file(eath_data_path, 'earth')
	# Load types
	print('Loading Astronomia Types')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'astronomia_types'))
	# Load Functions
	print('Loading Astronomia - Base')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'base'))
	print('Loading Astronomia - Constants')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'constants'))
	print('Loading Astronomia - Coordinates')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'coordinates'))
	print('Loading Astronomia - Delta T')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'delta_t'))
	print('Loading Astronomia - Interpolation')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'interpolation'))
	print('Loading Astronomia - Julian')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'julian'))
	print('Loading Astronomia - Moonphase')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'moonphase'))
	print('Loading Astronomia - Nutation')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'nutation'))
	print('Loading Astronomia - Ordinal Dates')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'ordinal_dates'))
	print('Loading Astronomia - Planet Position')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'planet_position'))
	print('Loading Astronomia - Precession')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'precession'))
	print('Loading Astronomia - Sexagesimal')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'sexagesimal'))
	print('Loading Astronomia - Solar')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'solar'))
	print('Loading Astronomia - Solstice')
	db.apply_sql_folder_to_db(os.path.join('astronomia', 'solstice'))
	

# Builds the calendars database
def build_calendars_db():
	"""Builds the calendars database"""
	db = PqDbController()
	db.connect_db()
	print('Setting up Calendars Schema')
	setup_path = os.path.join('db_setup')
	db.apply_sql_folder_and_list_to_db(setup_path, [
		'calendars_schema.pgsql',
		'constants_table.pgsql',
		'date_parts_type.pgsql',
		'get_constant.pgsql',
	])


# Extends the calendars database with Chinese date functions
def add_chinese_calendar():
	"""Extends the calendars database with Chinese date functions"""
	db = PqDbController()
	db.connect_db()
	print('Adding Chinese date types and functions')
	setup_path = os.path.join('chinese', 'chinese_setup')
	db.apply_sql_folder_and_list_to_db(setup_path, [
		'chinese_date_type.pgsql',
		'chinese_new_year_cache.pgsql',
		'chinese_solar_term_type.pgsql',
		'longitude_cache.pgsql',
		'winter_solstice_cache.pgsql',
	])
	# Load Functions
	print('Loading Chinese Date Functions')
	db.apply_sql_folder_to_db('chinese')


# Extends the calendars database with Hijri date functions
def add_hijri_calendar():
	"""Extends the calendars database with Hijri date functions"""
	db = PqDbController()
	db.connect_db()
	print('Adding Hijri date types and functions')
	# Load Functions
	print('Loading Hijri Date Functions')
	db.apply_sql_folder_to_db('hijri')


# Extends the calendars database with Jalali date functions
def add_jalali_calendar():
	"""Extends the calendars database with Jalali date functions"""
	db = PqDbController()
	db.connect_db()
	print('Adding Jalali date types and functions')
	# Load Functions
	print('Loading Jalali Date Functions')
	db.apply_sql_folder_to_db('jalali')


###############################################################################
#
# Main
#
###############################################################################

build_astronomia_db()
build_calendars_db()
add_chinese_calendar()
add_hijri_calendar()
add_jalali_calendar()
