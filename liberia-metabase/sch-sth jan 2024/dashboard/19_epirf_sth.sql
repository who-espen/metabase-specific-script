select 

'Enquête d''impacte' "Type d'enquête",
null "Région",
p_district "Council",
p_subdistrict "Sous-district",
p_site "Communauté",
TO_CHAR(w_start, 'Month') "Mois", 
EXTRACT(YEAR FROM w_start) "Année",
w_gps_lat "Latitude",
w_gps_lng "Longitude",
CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Group Age",
'Kato-Katz & Filtration d''urine' "Test diagnostique",


null "Nombre TMM",

count(*) "Ascaris - Nbr examiné",
count(
    case
        when r_ascaris_lumb_gram > 0 then 1
        else null
    end
) "Ascaris - Nbr Positif",
count(
    case
        when r_ascaris_lumb_gram > 0 then 1
        else null
    end
) * 100 / count(*) "Ascaris - % Positif",
sum(r_ascaris_heavy_intensity) * 100 / count(*) "Ascaris - % Intendité forte",
sum(r_ascaris_moderate_intensity) * 100 / count(*) "Ascaris - % Moderate Intensity",

count(*) "Ankylostome - Nbr examiné",
count(
    case
        when r_hookworm_gram > 0 then 1
        else null
    end
) "Ankylostome - Nbr Positif",
count(
    case
        when r_hookworm_gram > 0 then 1
        else null
    end
) * 100 / count(*) "Ankylostome - % Positif",
sum(r_hookworm_heavy_intensity) * 100 / count(*) "Ankylostome - % Intendité forte",
sum(r_hookworm_medium_intensity) * 100 / count(*) "Ankylostome - % Moderate intensity",


count(
    case
        when r_trichuris_gram > 0 then 1
        else null
    end
) "Trichuris - Nbr Positif",
count(
    case
        when r_trichuris_gram > 0 then 1
        else null
    end
) * 100 / count(*) "Trichuris - % Positif",
sum(r_trichuris_heavy_intensity) * 100 / count(*) "Trichuris - % Intendité forte",
sum(
    r_trichuris_moderate_intensity
) * 100 / count(*) "Trichuris - % Moderate intensity",


count(*) "Géohelminthiases - Nbr examiné",
count(
    case
        when (
            r_ascaris_lumb_gram > 0
            or r_hookworm_gram > 0
            or r_trichuris_gram > 0
        ) then 1
        else null
    end
) "Géohelminthiases - Nbr Positif",
count(
    case
        when (
            r_ascaris_lumb_gram > 0
            or r_hookworm_gram > 0
            or r_trichuris_gram > 0
        ) then 1
        else null
    end
) * 100 / count(*) "Géohelminthiases - % Positif"



from public.v_espen_lr_sch_sth_impact_202401_2_child_v2_1 p
left join public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1_full d on p.p_code_id = d.k_code_id 
left join public.v_espen_lr_sch_sth_impact_202401_1_school_v2 c on p.p_site_code = c.w_site_code 

group by p_district, p_subdistrict, p_site, "Mois", "Année", w_gps_lat, w_gps_lng



