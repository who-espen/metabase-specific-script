select
    'Autre' "Type Enquête",
    c_drshp "Region",
    c_district "UI",
    c_ecole "Ecole",
    null "Nombre de tour",
    TO_CHAR(c.c_start, 'Month') "Mois",
    EXTRACT(
        YEAR
        FROM
            c.c_start
    ) "Année",
    c_gps_lat "Latitude",
    c_gps_lng "Longitude",
    CONCAT(
        min(p_age_yrs),
        ' - ',
        max(p_age_yrs)
    ) "Tranche d'âge(Min - Max)",
    'Kato-Katz' "Test Diagnostique",
    count(*) "Ascaris - Nbr examiné",
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
    null "Décision",
    c_csps "Sous District"
from
    v_espen_bf_202403_sch_ia_2_enrolement p
    left join v_espen_bf_202403_sch_ia_1_sites c on c.c_code_site = p.p_code_site
    and c.c_district = p.p_district
    left join v_espen_bf_202403_sch_ia_3_resultat_selles_full k on p.p_numero_enquete_complet = k.d_numero_enquete_complet
    left join v_espen_bf_202403_sch_ia_4_resultat_urines u on p.p_numero_enquete_complet = u.u_numero_enquete_complet
group by
    c_drshp,
    c_district,
    c_ecole,
    "Mois",
    "Année",
    c_gps_lat,
    c_gps_lng,
    c_csps