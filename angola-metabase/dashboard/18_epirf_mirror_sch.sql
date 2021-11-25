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

  'Mapping' "Survey Type",
  u_municipality "Implementation Unit",
  u_school "Site",
  TO_CHAR(u_start, 'Month') "Month",
  EXTRACT(YEAR FROM u_start) "Years",
  w_gps_lat "Latitude (decimal)",
  w_gps_lng "Longitude (decimal)",
  CONCAT(7, ' - ', 10) "Group Age",
  'CCA' "Diag Tast",
  count(u.id) "Urinaire - Nbr examined",
  count(case when u_nbr_eggs > 0 then 1 else null end) "Urinaire - Nbr Positives",
  case when count(u.id) > 0 then count(case when u_nbr_eggs > 0 then 1 else null end)*100.0/count(u.id) else 0 end  "Urinaire - % Positives",
  case when count(u.id) > 0 then count(case when is_haem_heavy_intensity > 0 then 1 else null end)*100.0/count(u.id) else 0 end  "Urinaire - % Heavy intensity",
  case when count(u.id) > 0 then count(case when is_haem_low_intensity > 0 then 1 else null end)*100.0/count(u.id) else 0 end  "Urinaire - % Moderate intensity",
  count(k.id) "Intestinal - Nbr examinées",
  count(case when k_sch_man_intensity > 0 then 1 else null end) "Intestinal - Nbr Positives",
  case when count(k.id) > 0 then count(case when k_sch_man_intensity > 0 then 1 else null end)*100.0/count(k.id) else 0 end "Intestinal - % Positives",
  case when count(k.id) > 0 then sum(k_sch_man_heavy_intensity)*100.0/count(k.id) else 0 end  "Intestinal - % Heavy intensity",
  case when count(k.id) > 0 then  sum(k_sch_man_moderate_intensity)*100.0/count(k.id) else 0 end "Intestinal - % Moderate intensity"

FROM public.v_espen_ao_sch_sth_baseline_4_urine_202105_full u
left join public.v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8 on u_school_id = w_school_id 
left join public.v_espen_ao_sch_sth_baseline_3_kato_katz_202105_full k on u_code_id = k.k_code_id 

GROUP BY u_municipality, u_school, u_start, w_gps_lat, w_gps_lng

order by u_municipality, u_school, u_start

