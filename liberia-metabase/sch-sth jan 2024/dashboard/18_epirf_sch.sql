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


null "Date 1ère Tournée TMM",
null "Nombre de Tournée TMM",


count(*) "Urinaire - Nbr examiné",
count(
    case
        when r_sh_egr_10ml > 0 then 1
        else null
    end
) "Urinaire - Nbr positifs",
count(
    case
        when r_sh_egr_10ml > 0 then 1
        else null
    end
) * 100.0 / count(*) "Urinaire - % poditifs",
sum(
    is_haem_heavy_intensity
) * 100.0 / count(*) "Urinaire - % Forte intensité",
sum(
    is_haem_low_intensity
) * 100.0 / count(*) "Urinaire - % Intensité Modéré",



count(*) "Intestinal - Nbr examinées",
count(
    case
        when r_sch_man_gram > 0 then 1
        else null
    end
) "Intestinal - Nbr Positifs",
count(
    case
        when r_sch_man_gram > 0 then 1
        else null
    end
) * 100 / count(*) "Intestinal - % Positifs",
sum(
    r_sch_man_heavy_intensity
) * 100.0 / count(*) "Intestinal - % Heavy intensity",
sum(
    r_sch_man_moderate_intensity
) * 100.0 / count(*) "Intestinal - % Moderate intensity"




from public.v_espen_lr_sch_sth_impact_202401_2_child_v2_1 p
left join public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1_full d on p.p_code_id = d.k_code_id 
left join public.v_espen_lr_sch_sth_impact_202401_1_school_v2 c on p.p_site_code = c.w_site_code 

group by p_district, p_subdistrict, p_site, "Mois", "Année", w_gps_lat, w_gps_lng



