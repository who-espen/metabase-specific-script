/*
 * File: 19_epirf_mirror_sth.sql
 * File Created: Tuesday, 12th May 2020 6:14:20 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 2nd July 2020 8:42:46 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


SELECT

  'k_start' "Survey Type",
  INITCAP(k_municipality) "Implementation Unit",
  INITCAP(k_school) "Site",
  null "Number of Round",
  TO_CHAR(k_start, 'Month') "Month",
  EXTRACT(YEAR FROM k_start) "Year",
  w_gps_lat "Latitude (decimal)",
  w_gps_lng "Longitude (decimal)",
  CONCAT(7, ' - ', 10) "Age Group",
 'Kato-Katz' "Diagnostic Test",
  count(*) "Ascaris - Nbr examined",
  count(case when k_ascaris_lumb_intensity > 0 then 1 else null end) "Ascaris - Nbr Positives",
  count(case when k_ascaris_lumb_intensity > 0 then 1 else null end)*100/count(*) "Ascaris - % Positives",
  sum(k_ascaris_heavy_intensity)*100/count(*) "Ascaris - % Heavy intensity",
  sum(k_ascaris_moderate_intensity)*100/count(*) "Ascaris - % Moderate Intensity",
  count(*) "Kookworm - Nbr examinées",
  count(case when k_hookworm_intensity > 0 then 1 else null end) "Kookworm - Nbr Positives",
  count(case when k_hookworm_intensity > 0 then 1 else null end)*100/count(*) "Kookworm - % Positives",
  sum(k_hookworm_heavy_intensity)*100/count(*) "Kookworm - % Heavy intensity",
  sum(k_hookworm_medium_intensity)*100/count(*) "Kookworm - % Moderate intensity",
  count(*) "Trichuris - Nbr examinées",
  count(case when k_trichuris_intensity > 0 then 1 else null end) "Trichuris - Nbr Positives",
  count(case when k_trichuris_intensity > 0 then 1 else null end)*100/count(*) "Trichuris - % Positives",
  sum(k_trichuris_heavy_intensity)*100/count(*) "Trichuris - % Heavy intensity",
  sum(k_trichuris_moderate_intensity)*100/count(*) "Trichuris - % Moderate intensity",
  count(*) "Géohelminthiases - Nbr examinées",
  count(case when (k_ascaris_lumb_intensity > 0 or k_hookworm_intensity > 0 or k_trichuris_intensity > 0 ) then 1 else null end) "Géohelminthiases - Nbr Positives",
  count(case when (k_ascaris_lumb_intensity > 0 or k_hookworm_intensity > 0 or k_trichuris_intensity > 0) then 1 else null end)*100/count(*) "Géohelminthiases - % Positives"

FROM public.v_espen_ao_sch_sth_baseline_3_kato_katz_202105_full 
left join public.v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8 c on k_school_id = w_school_id 



GROUP BY k_municipality, k_school, k_start, w_gps_lat, w_gps_lng

order by k_municipality, k_school, k_start
