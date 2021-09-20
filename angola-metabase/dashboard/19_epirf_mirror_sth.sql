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

  'cartographie' "Type d'enquête",
  municipio "Nom de l'unité",
  code_school "Code de l'école",
  null "Nombre de tournées TMM achevées avant l'enquete",
  TO_CHAR(data, 'Month') "Date de l'enquête(mois)",
  EXTRACT(YEAR FROM data) "Date de l'enquête(année)",
  latitude "Latitude (decimal)",
  longitude "Longitude (decimal)",
  CONCAT(min(idade), ' - ', max(idade)) "Groupe d'âge interrogé",
  'Kato-Katz' "Test diagnostique",
  count(*) "Ascaris - Nbr examinées",
  count(case when kk_ascaris > 0 then 1 else null end) "Ascaris - Nbr Positives",
  count(case when kk_ascaris > 0 then 1 else null end)*100/count(*) "Ascaris - % Positives",
  sum(ascaris_heavy_intensity)*100/count(*) "Ascaris - % Positives à  Forte intensité",
  sum(ascaris_medium_intensity)*100/count(*) "Ascaris - % Positives à  Moyenne intensité",
  count(*) "Ankylostome - Nbr examinées",
  count(case when kk_ancil > 0 then 1 else null end) "Ankylostome - Nbr Positives",
  count(case when kk_ancil > 0 then 1 else null end)*100/count(*) "Ankylostome - % Positives",
  sum(ancil_heavy_intensity)*100/count(*) "Ankylostome - % Positives à  Forte intensité",
  sum(ancil_medium_intensity)*100/count(*) "Ankylostome - % Positives à  Moyenne intensité",
  count(*) "Trichuris - Nbr examinées",
  count(case when kk_tric > 0 then 1 else null end) "Trichuris - Nbr Positives",
  count(case when kk_tric > 0 then 1 else null end)*100/count(*) "Trichuris - % Positives",
  sum(trichuris_heavy_intensity)*100/count(*) "Trichuris - % Positives à  Forte intensité",
  sum(sth_medium_intensity)*100/count(*) "Trichuris - % Positives à  Moyenne intensité",
  count(*) "Géohelminthiases - Nbr examinées",
  count(case when (kk_ascaris > 0 or kk_tric > 0 or kk_ancil > 0 or kk_others > 0) then 1 else null end) "Géohelminthiases - Nbr Positives",
  count(case when (kk_ascaris > 0 or kk_tric > 0 or kk_ancil > 0 or kk_others > 0) then 1 else null end)*100/count(*) "Géohelminthiases - % Positives"

FROM public.v_cleaned_full_dataset

WHERE sn is not null
[[and  {{provincia}}]]
[[and municipio={{municipio}}]]
[[and {{data}}]]

GROUP BY municipio, code_school, data, latitude, longitude
