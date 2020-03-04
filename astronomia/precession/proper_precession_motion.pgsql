-------------------------------------------------------------------------------
-- Param NUMERIC mα - anual proper motion (ra)
-- Param NUMERIC mδ - anual proper motion (dec)
-- Param NUMERIC p_epoch
-- Param astronomia.ecliptic_coordinates p_ecl
-- Returns NUMERIC[] [mλ, mβ]
-------------------------------------------------------------------------------
--
CREATE OR REPLACE FUNCTION astronomia.proper_precession_motion(
	mα NUMERIC,
	mδ NUMERIC,
	p_epoch NUMERIC,
	p_ecl astronomia.ecliptic_coordinates
)
RETURNS NUMERIC[]
AS $$

DECLARE
	ε NUMERIC := astronomia.nutation_mean_obliquity(astronomia.julian_year_to_jde(p_epoch));
	εsin NUMERIC := SIN(ε);
	εcos NUMERIC := COS(ε);
	t_equ astronomia.equatorial_coordinates%rowtype := astronomia.ecliptic_to_equatorial(p_ecl, ε);
	sα NUMERIC := SIN(t_equ.right_ascension);
	cα NUMERIC := COS(t_equ.right_ascension);
	sδ NUMERIC := SIN(t_equ.declination);
	cδ NUMERIC := COS(t_equ.declination);
	cβ NUMERIC := COS(p_ecl.latitude);
	t_longitude NUMERIC := (mδ * εsin * cα + mα * cδ * (εcos * cδ + εsin * sδ * sα)) / (cβ * cβ);
	t_latitude NUMERIC := (mδ * (εcos * cδ + εsin * sδ * sα) - mα * εsin * cα * cδ) / cβ;
	t_ecl astronomia.ecliptic_coordinates := (lon, lat, NULL);

BEGIN
	RETURN t_ecl;
END;

$$ LANGUAGE plpgsql STRICT IMMUTABLE;
