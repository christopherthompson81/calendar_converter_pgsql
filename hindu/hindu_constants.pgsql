INSERT INTO calendars.constants(calendar_type, identifier, shorthand, description, constant_value)
VALUES (
	'chinese',
	'chinese_calendar_epoch_year',
	'epoch_y',
	'Start of Chinese Calendar in 2636 BCE by Chalmers',
	-2636
);

# 0 = Sunday
WEEKDAYS = (
	"Ravivāra",
	"Somavāra",
	"Maṅgalavāra",
	"Budhavāra",
	"Guruvāra",
	"Śukravāra",
	"Śanivāra",
)

MONTHS = (
	"Chaitra",
	"Vaishākha",
	"Jyēshtha",
	"Āshādha",
	"Shrāvana",
	"Bhādrapada",
	"Āshwin",
	"Kārtika",
	"Mārgashīrsha",
	"Pausha",
	"Māgha",
	"Phālguna",
)

HAVE_31_DAYS = (2, 3, 4, 5, 6)
HAVE_30_DAYS = (7, 8, 9, 10, 11, 12)

SAKA_EPOCH = 78