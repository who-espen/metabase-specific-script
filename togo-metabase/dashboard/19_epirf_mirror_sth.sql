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

  'Sentinel site' "Syrvey Type",
  p_district "Implementation Unit",
  p_school_name "Site",
  null "Number of Round",
  TO_CHAR(p_start, 'Month') "Month",
  EXTRACT(YEAR FROM p_start) "Year",
  w_gps_lat "Latitude (decimal)",
  w_gps_lng "Longitude (decimal)",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age Group",
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

FROM public.v_espen_tg_sch_sth_impact_2_child_202110_v6 p
left join public.v_espen_tg_sch_sth_impact_1_school_202110_v6_1 c on p.p_school_id = c.w_school_id 
left join public.v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 k on p.p_barcodeid = k.k_barcodeid 



GROUP BY p_district, p_school_name, p_start, w_gps_lat, w_gps_lng
