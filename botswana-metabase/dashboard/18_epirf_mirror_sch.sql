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

  'cartographie' "Type d'enquête",
  municipio "Nom de l'unité",
  code_school "Code de l'école",
  TO_CHAR(data, 'Month') "Date de l'enquête(mois)",
  EXTRACT(YEAR FROM data) "Date de l'enquête(année)",
  latitude "Latitude (decimal)",
  longitude "Longitude (decimal)",
  CONCAT(min(idade), ' - ', max(idade)) "Groupe d'âge interrogé",
  'Filtration d''urine & Kato-Katz' "Test diagnostique",
  count(*) "Urinaire - Nbr examinées",
  count(case when fu_intensity > 0 then 1 else null end) "Urinaire - Nbr Positives",
  count(case when fu_intensity > 0 then 1 else null end)*100/count(*) "Urinaire - % Positives",
  sum(sch_haem_heavy_intensity)*100/count(*) "Urinaire - % Positives à  Forte intensité",
  sum(sch_haem_low_intensity)*100/count(*) "Urinaire - % Positives à  Moyenne intensité",
  count(*) "Intestinal - Nbr examinées",
  count(case when kk_mansoni > 0 then 1 else null end) "Intestinal - Nbr Positives",
  count(case when kk_mansoni > 0 then 1 else null end)*100/count(*) "Intestinal - % Positives",
  sum(sch_heavy_man_intensity)*100/count(*) "Intestinal - % Positives à  Forte intensité",
  sum(sch_medium_man_intensity)*100/count(*) "Intestinal - % Positives à  Moyenne intensité"

FROM public.v_cleaned_full_dataset

WHERE sn IS NOT NULL
[[and  {{provincia}}]]
[[and municipio={{municipio}}]]

GROUP BY municipio, code_school, data, latitude, longitude

