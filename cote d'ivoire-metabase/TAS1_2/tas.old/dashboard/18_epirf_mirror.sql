show LC_TIME;
SET LC_TIME = 'fr_FR';

  select
  
  'TAS1' "Type d'enquête",
  INITCAP(c_district) "Unité d'Implémentation",
  initcap(c_eu_name) "Unité d'Evaluation",
  initcap(c_cluster_name) "Site d'enquête",
  
  TO_CHAR(c_start, 'TMMonth') "Mois",
  EXTRACT(YEAR FROM c.c_start) "Années",
  
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date 1ère tournées TMM",
  NULL "Nombre de tournées TMM",
  null "Nombre de cournéézs avec couverture effective",
  'Ecole' "Site enquete",
  'Cluster' "Methode de sélection des sites",
  'Commodité' "Méthode de selection des personnes",
  null "Population cible",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Tranche d'âge(Min - Max)",
  
  
  'FTS (Ag)' "Test Diagnostic",
  
  count(*) "Examiné",
  COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) "Number de Positif",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / count(*), 2) "% positif",
  0 "Number of invalid tests", --TODO: Update the number of invalid test
  null "Positive pour MF",
  null "Nombre pour MF+",
  null "Décision"


from public.v_espen_ci_202302_lf_tas1_2_partcipants p
join public.v_espen_ci_202302_lf_tas1_1_sites c on upper(p.p_cluster_name) = upper(c.c_cluster_name) and  upper(p.p_district) = upper(c.c_district) 
join public.v_espen_ci_202302_lf_tas1_3_fts_result d on p.p_code_id = d.d_code_id 

group by c_district, c_eu_name, c_cluster_name, "Mois", "Années", c_gps_lat, c_gps_lng

order by c_district, c_eu_name, c_cluster_name;