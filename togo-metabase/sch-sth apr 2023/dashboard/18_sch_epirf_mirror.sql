SELECT 

'Autres' "Type d'enquête",
initcap(w_region) "Region",
initcap(w_district) "Unité d'éxécution",
initcap(w_usp) "Sous-unité d'éxécution",
initcap(w_site_name) "Site",
TO_CHAR(w_start, 'Month') "Mois",
EXTRACT(
    YEAR
    FROM
        w_start
) "Année",
w_gps_lat "Latitude (decimal)",
w_gps_lng "Longitude (decimal)",
CONCAT(
    min(p_age_yrs),
    ' - ',
    max(p_age_yrs)
) "Group Age",
'Kato-Katz & Filtration d''urine' "Test diag",
count(
    case
        when u.id is not null then 1
        else 0
    end
) "Urinaire - Nbr examiné",
count(
    case
        when u_sh_egg_per_10ml > 0 then 1
        else null
    end
) "Urinaire - Nbr positifs",
count(
    case
        when u_sh_egg_per_10ml > 0 then 1
        else null
    end
) * 100.0 / count(
    case
        when u.id is not null then 1
        else 0
    end
) "Urinaire - % poditifs",
sum(is_haem_heavy_intensity) * 100.0 / count(
    case
        when u.id is not null then 1
        else 0
    end
) "Urinaire - % Forte intensité",
sum(is_haem_low_intensity) * 100.0 / count(
    case
        when u.id is not null then 1
        else 0
    end
) "Urinaire - % Intensité Modéré",
count(k.id) "Intestinal - Nbr examinées",
count(
    case
        when k_sch_man_intensity > 0 then 1
        else null
    end
) "Intestinal - Nbr Positifs",
count(
    case
        when k_sch_man_intensity > 0 then 1
        else null
    end
) * 100 / count(k.id) "Intestinal - % Positifs",
sum(k_sch_man_heavy_intensity) * 100.0 / count(k.id) "Intestinal - % Heavy intensity",
sum(k_sch_man_moderate_intensity) * 100.0 / count(k.id) "Intestinal - % Moderate intensity"

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