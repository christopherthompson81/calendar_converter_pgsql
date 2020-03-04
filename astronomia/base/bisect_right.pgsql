------------------------------------------
------------------------------------------
-- Return the index where to insert item x in list a, assuming a is sorted.
-- The return value i is such that all e in a[:i] have e <= x, and all e in
-- a[i:] have e > x.  So if x already appears in the list, a.insert(x) will
-- insert just after the rightmost x already there.
-- Optional args lo (default 0) and hi (default len(a)) bound the
-- slice of a to be searched.
--
-- Arrays in PL/pgSQL are 1 indexed;
--
--if lo < 0:
--	raise ValueError('lo must be non-negative')
--if hi is None:
--	hi = len(a)
--	while lo < hi:
--		mid = (lo+hi)//2
--if x < a[mid]:
--	hi = mid
--else:
--	lo = mid+1
--return lo
------------------------------------------
------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.bisect_right(
	a NUMERIC[],
	x NUMERIC,
	lo INTEGER DEFAULT 0,
	hi INTEGER DEFAULT -1
)
RETURNS INTEGER AS $$

DECLARE
	t_lo INTEGER := lo;
	t_hi INTEGER := hi;
	t_mid INTEGER;

BEGIN
	-- Check date range
	IF lo < 0 THEN
		RAISE EXCEPTION 'lo must be greater than zero --> %', lo;
	END IF;
	IF t_hi = -1 THEN
		t_hi := ARRAY_LENGTH(a, 1);
	END IF;
	-- Find the insertion point
	LOOP
		EXIT WHEN t_lo >= t_hi;
		t_mid := ((t_lo + t_hi) / 2) + 1;
		IF x < a[t_mid] THEN
			IF t_mid < t_hi THEN
				t_hi := t_mid;
			ELSE
				t_lo := 1;
				EXIT;
			END IF;
		ELSE
			t_lo := t_mid + 1;
		END IF;
	END LOOP;
	-- Return the insertion point to the right
	RETURN t_lo;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
