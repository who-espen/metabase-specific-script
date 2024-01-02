SELECT 

'Avec TAS' "Type d'enquête",
INITCAP(w_region) "Region",
INITCAP(w_district) "Unité d'implémentation",
initcap(w_usp) "Sous-district",
INITCAP(w_site_name) "Site",
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
count(k.id) "Ascaris - Nbr examiné",
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
) * 100.0 / count(k.id) "Ascaris - % Positif",
sum(k_ascaris_heavy_intensity) * 100.0 / count(k.id) "Ascaris - % Intendité forte",
sum(k_ascaris_moderate_intensity) * 100.0 / count(k.id) "Ascaris - % intensité Modéré",
count(k.id) "Ankylostome - Nbr examiné",
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
) * 100 / count(k.id) "Ankylostome - % Positif",
sum(k_hookworm_heavy_intensity) * 100.0 / count(k.id) "Ankylostome - % Intendité forte",
sum(k_hookworm_medium_intensity) * 100.0 / count(k.id) "Ankylostome - % Intensité modéré",

count(k.id) "Trichuris - Nbr examiné",
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
) * 100 / count(k.id) "Trichuris - % Positif",
sum(k_trichuris_heavy_intensity) * 100 / count(k.id) "Trichuris - % Intendité forte",
sum(
    k_trichuris_moderate_intensity
) * 100 / count(k.id) "Trichuris - % Intensité modéré",

count(k.id) "Géohelminthiases - Nbr examiné",
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
) * 100 / count(k.id) "Géohelminthiases - % Positif",
null "Décision"

FROM public.espen_tg_sch_sth_impact_202309_2_child_v2 p 

left join public.v_espen_tg_sch_sth_impact_202309_1_school_v2 w on w_site_id = p.p_site_id
left join public.v_espen_tg_sch_sth_impact_202309_3_kato_katz_v2_full k on k.k_barcodeid = p.p_barcodeid
left join public.v_espen_ml_sch_sth_impact_202304_4_hemastix_full u on u.u_barcodeid = p.p_barcodeid

GROUP BY
    w_region,
    w_district,
    w_usp,
    w_site_name,
    "Mois",
    "Année",
    w_gps_lat,
    w_gps_lng

order by w_region, w_district, w_usp, w_site_name 