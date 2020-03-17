-------------------------------------------------------------------------------
-- Days elapsed since beginning of Kali Yuga
--
-- Kali Yuga Days (KYD) <=> Ahargana (Sanskrit)
-- epoch-midnight to given midnight
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION calendars.jd_to_kyd(
	p_jd NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
	kyd NUMERIC := p_jd - 588465.5;

BEGIN
	RETURN kyd;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;