/*
 * File: 19_epirf_mirror_sth.sql
 * File Created: Tuesday, 12th May 2020 6:14:20 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 2nd July 2020 8:42:46 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

--show LC_TIME;

--SET LC_TIME = 'fr_FR';

SELECT 

'autres' "Type d'enquête",
INITCAP(p_district) "Unité d'implémentation",
INITCAP(p_site) "Site",
null "Nombre de tour",
TO_CHAR(w_start, 'TMMonth') "Mois",
EXTRACT(
    YEAR
    FROM
        w_start
) "Année",
w_gps_lat "Latitude (decimal)",
w_gps_lng "Longitude (decimal)",
CONCAT(5, ' - ', 14) "Groupe d'Age",
'Kato-Katz' "Test Diagnostique",
count(
    case
        when k_ascaris_lumb_intensity = 0
        or k_ascaris_lumb_intensity > 0 then 1
        else null
    end
) "Ascaris - Nbr examiné",
count(
    case
        when k_ascaris_lumb_intensity > 0 then 1
        else null
    end
) "Ascaris - Nbr Positif",
count(
    case
        when k_ascaris_lumb_intensity > 0 then 1
        else null
    end
) * 100 / count(*) "Ascaris - % Positif",
sum(k_ascaris_heavy_intensity) * 100 / count(*) "Ascaris - % Intendité forte",
sum(k_ascaris_moderate_intensity) * 100 / count(*) "Ascaris - % Moderate Intensity",
count(*) "Ankylostome - Nbr examiné",
count(
    case
        when k_hookworm_intensity > 0 then 1
        else null
    end
) "Ankylostome - Nbr Positif",
count(
    case
        when k_hookworm_intensity > 0 then 1
        else null
    end
) * 100 / count(*) "Ankylostome - % Positif",
sum(k_hookworm_heavy_intensity) * 100 / count(*) "Ankylostome - % Intendité forte",
sum(k_hookworm_medium_intensity) * 100 / count(*) "Ankylostome - % Moderate intensity",
count(*) "Trichuris - Nbr examiné",
count(
    case
        when k_trichuris_intensity > 0 then 1
        else null
    end
) "Trichuris - Nbr Positif",
count(
    case
        when k_trichuris_intensity > 0 then 1
        else null
    end
) * 100 / count(*) "Trichuris - % Positif",
sum(k_trichuris_heavy_intensity) * 100 / count(*) "Trichuris - % Intendité forte",
sum(
    k_trichuris_moderate_intensity
) * 100 / count(*) "Trichuris - % Moderate intensity",
count(*) "Géohelminthiases - Nbr examiné",
count(
    case
        when (
            k_ascaris_lumb_intensity > 0
            or k_hookworm_intensity > 0
            or k_trichuris_intensity > 0
        ) then 1
        else null
    end
) "Géohelminthiases - Nbr Positif",
count(
    case
        when (
            k_ascaris_lumb_intensity > 0
            or k_hookworm_intensity > 0
            or k_trichuris_intensity > 0
        ) then 1
        else null
    end
) * 100 / count(*) "Géohelminthiases - % Positif",

INITCAP(p_ward) "Ward"
FROM
    public.v_espen_tz_sch_sth_impact_202311_2_child_v4 p

left join public.v_espen_tz_sch_sth_impact_202311_1_school_v4 w on w.w_site = p.p_site
left join public.v_espen_tz_sch_sth_impact_202311_3_kk_v4 k on k.k_barcode_id = p.p_barcode_id
left join public.v_espen_tz_sch_sth_impact_202311_4_urine_v4 u on u.u_code_id = p.p_barcode_id

where k_barcode_id is not null 

GROUP BY
    p_district,
    p_site,
    p_ward,
    w_start,
    w_gps_lat,
    w_gps_lng

order by p_district, p_site , w_start;