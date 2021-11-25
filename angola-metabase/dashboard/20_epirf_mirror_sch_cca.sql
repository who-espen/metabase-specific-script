SELECT

  'Mapping' "Survey Type",
  h_province "Implementation Unit",
  h_commune "Site",
  TO_CHAR(h_start, 'Month') "Month",
  EXTRACT(YEAR FROM h_start) "Years",
  w_gps_lat "Latitude (decimal)",
  w_gps_lng "Longitude (decimal)",
  CONCAT(7, ' - ', 10) "Group Age",
  'CCA' "Diag Tast",
  count(u.id) "Urinary - Nbr examined",
  count(case when hemastix_h_cca = '1.Positivo' then 1 else null end) "Urinary - Nbr Positives",
  case when count(u.id) > 0 then count(case when hemastix_h_cca = '1.Positivo' then 1 else null end)*100.0/count(u.id) else 0 end  "Urinary - % Positives",
  case when count(u.id) > 0 then count(case when hemastix_h_grading = '+++' then 1 else null end)*100.0/count(u.id) else 0 end  "Urinary - % Heavy intensity",
  case when count(u.id) > 0 then count(case when hemastix_h_grading = '++' then 1 else null end)*100.0/count(u.id) else 0 end  "Urinary - % Moderate intensity",
  null "Intestinal - Nbr examinées",
  null "Intestinal - Nbr Positives",
  null "Intestinal - % Positives",
  null "Intestinal - % Heavy intensity",
  null "Intestinal - % Moderate intensity"

FROM public.v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 u
left join public.v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8 on h_school_id = w_school_id 

GROUP BY h_province, h_commune, h_start, w_gps_lat, w_gps_lng

order by h_province, h_commune, h_start