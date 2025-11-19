/*
 * File: 18_epirf_mirror_sch.sql
 * File Created: Tuesday, 12th May 2020 6:14:20 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 2nd July 2020 8:41:40 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


SELECT

  'Autres' "Type d'enquête",
  initcap(w_region)  "Region",
  initcap(w_district)  "Unité d'éxécution",
  initcap(w_subdistrict)  "Sous-unité d'éxécution",
  initcap(w_site_name)  "Site",
  
  TO_CHAR(w_start, 'Month') "Mois",
  EXTRACT(YEAR FROM w_start) "Année",
  w_gps_lat "Latitude (decimal)",
  w_gps_lng "Longitude (decimal)",
  CONCAT(min(p__age_yrs), ' - ', max(p__age_yrs)) "Group Age",
  'Kato-Katz & Filtration d''urine' "Test diag",
  
  count(case when u.id is not null then 1 else 0 end) "Urinaire - Nbr examiné",
  count(case when u_sh_egp_10ml > 0 then 1 else null end) "Urinaire - Nbr positifs",
  count(case when u_sh_egp_10ml > 0 then 1 else null end) *100.0/count(case when u.id is not null then 1 else 0 end) "Urinaire - % poditifs",
  sum(u_sh_egp_10ml_heavy_intensity)*100.0/count(case when u.id is not null then 1 else 0 end)  "Urinaire - % Forte intensité",
  sum(u_sh_egp_10ml_moderate_intensity)*100.0/count(case when u.id is not null then 1 else 0 end)   "Urinaire - % Intensité Modéré",
  count(k.id) "Intestinal - Nbr examinées",
 count(case when (u_sch_man_a+u_sch_man_b)/2 > 0 then 1 else null end) "Intestinal - Nbr Positifs",
 count(case when (u_sch_man_a+u_sch_man_b)/2  > 0 then 1 else null end)*100/count(k.id) "Intestinal - % Positifs",
  sum(u_sch_man_gram_heavy_intensity)*100.0/count(k.id) "Intestinal - % Heavy intensity",
  sum(u_sch_man_gram_moderate_intensity)*100.0/count(k.id) "Intestinal - % Moderate intensity"


FROM public.v_espen_bf_202403_sch_ia_2_enrolement p
 left join public.v_espen_bf_202403_sch_ia_1_sites c on p.p_site_code = c.w_site_code 
 left join public.v_espen_bj_sch_sth_impact_202304_3_kato_katz_v1_full k on p.p__espen_code_id = k.k_espen_code_id 
 left join public.v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1_full u on p.p__espen_code_id = u.u_espen_code_id
 

GROUP BY w_region, w_district, w_subdistrict, w_site_name,  "Mois", "Année", w_gps_lat, w_gps_lng

order by w_region, w_district, w_subdistrict, w_site_name
