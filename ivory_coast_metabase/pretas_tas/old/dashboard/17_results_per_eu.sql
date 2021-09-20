/*
 * File: 17_results_per_eu.sql
 * File Created: Wednesday, 6th May 2020 11:28:59 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:49:05 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the FTS result by sex and result.
 * Variable to rename <%v_ab_cde_fgh_2_participant%>, <%ab_cde_fgh_1_site%>
 */
 SELECT
c.code_site "Site ID",
c.ue "EU",
c.site "Site Name",
COUNT(p.id) "Enrolled",
COUNT(CASE WHEN p.sexe = 'M' THEN 1 ELSE NULL END) "Homme",
COUNT(CASE WHEN p.sexe = 'F' THEN 1 ELSE NULL END) "Femme",
COUNT(CASE WHEN (p.sexe = 'M' and d.final_result = '1_Positif') THEN 1 ELSE NULL END) "Positif Homme",
COUNT(CASE WHEN (p.sexe = 'F' and d.final_result = '1_Positif') THEN 1 ELSE NULL END) "Positif Femme",
COUNT(CASE WHEN (d.final_result = '1_Positif') THEN 1 ELSE NULL END) "Total Positif",
COUNT(CASE WHEN (p.sexe = 'M' and d.final_result = '2_Negative') THEN 1 ELSE NULL END) "Negatif Homme",
COUNT(CASE WHEN (p.sexe = 'F' and d.final_result = '2_Negative') THEN 1 ELSE NULL END) "Negatf Femme",
COUNT(CASE WHEN ( d.final_result = '2_Negative') THEN 1 ELSE NULL END) "Total Negatif",
COUNT(CASE WHEN ( d.final_result = '3_Invalide') THEN 1 ELSE NULL END) "Total Invalide"

FROM public.v_espen_ci_pretas_lf_resultats_v7 d
LEFT JOIN public.v_espen_cv_pretas_lf_village_v7 c on d.code_site = c.code_site
RIGHT JOIN public.v_espen_ci_pretas_lf_enrollement_v7 p on p.code_id = d.code_id

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c.code_site , c.ue , c.site 
