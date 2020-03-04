# Chinese Date Parser

## Dates in Chinese calendar (lunar)

Dates in the chines calendar can be attributed using the following rule:

Rule: `chinese <cycle>-<year>-<month>-<leapmonth>-<day>`

Where:
- `<cycle>` (optional) Chinese cycle - current is 78
- `<year>` (optional) year in Chinese cycle (1 ... 60)
- `<month>` (mandatory) lunar month
- `<leapmonth>` (mandatory) `0|1` - `1` means month is leap month
- `<day>` (mandatory) day of lunar month

**Examples**:

- `chinese 01-0-01` is 1st day in the 1st lunar month (aka Chinese New Year)
- `chinese 78-32-08-0-15` is 15th day in the 8th non-leap lunar month in year 32 of 78th cycle

## Dates in Chinese calendar (solar)

Rule: `chinese <cycle>-<year>-<count>-<day> solarterm`

Where:
- `<cycle>` (optional) Chinese cycle - current is 78
- `<year>` (optional) year in Chinese cycle (1 ... 60)
- `<count>` (mandatory) Number of solar term. (1 .. 24)
- `<day>` (mandatory) day of lunar month

**Examples**:

- `chinese 5-01 solarterm` is the 1st day in the 5th solarterm (aka Qingming Festival)
- `chinese 78-32-24-01 solarterm` is the 1st day in the 24th solarterm in year 32 of 78th cycle


## Regular Expressions

	chineseLunar: /^(chinese|korean|vietnamese) (?:(\d+)-(\d{1,2})-)?(\d{1,2})-([01])-(\d{1,2})/
    chineseSolar: /^(chinese|korean|vietnamese) (?:(\d+)-(\d{1,2})-)?(\d{1,2})-(\d{1,2}) solarterm/

## Constructor

	_shorten (o, cap0) {
		o.str = o.str.substr(cap0.length, o.str.length)
	}

	_chineseSolar (o) {
		let cap
		if ((cap = grammar.chineseSolar.exec(o.str))) {
			this._shorten(o, cap[0])
			cap.shift()
			const res = {
				fn: cap.shift(),
				cycle: toNumber(cap.shift()),
				year: toNumber(cap.shift()),
				solarterm: toNumber(cap.shift()),
				day: toNumber(cap.shift()),
				timezone: cap.shift()
			}
			this.tokens.push(res)
			return true
		}
	}

	_chineseLunar (o) {
		let cap
		if ((cap = grammar.chineseLunar.exec(o.str))) {
			this._shorten(o, cap[0])
			cap.shift()
			const res = {
				fn: cap.shift(),
				cycle: toNumber(cap.shift()),
				year: toNumber(cap.shift()),
				month: toNumber(cap.shift()),
				leapMonth: !!toNumber(cap.shift()),
				day: toNumber(cap.shift()),
				timezone: cap.shift()
			}
				this.tokens.push(res)
				return true
		}
	}