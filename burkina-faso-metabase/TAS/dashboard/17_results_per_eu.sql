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
 * Variable to rename v_espen_bf_lf_tas1_2_enrolement_202010, espen_bf_lf_tas1_1_sites_202010
 */
 SELECT
nb_grappe "Site ID",
c_eu_code "EU",
ds "District",
nom_grappe "Site Name",
COUNT(p.id) "Enrolled",
COUNT(CASE WHEN sexe = 'Male' THEN 1 ELSE NULL END) "Male",
COUNT(CASE WHEN sexe = 'Female' THEN 1 ELSE NULL END) "Female",
COUNT(CASE WHEN (sexe = 'Male' and resultat_fts1 = 'Positive') THEN 1 ELSE NULL END) "Positive Male",
COUNT(CASE WHEN (sexe = 'Female' and resultat_fts1 = 'Positive') THEN 1 ELSE NULL END) "Positive Female",
COUNT(CASE WHEN (resultat_fts1 = 'Positive') THEN 1 ELSE NULL END) "Total Positive",
COUNT(CASE WHEN (sexe = 'Male' and resultat_fts1 = 'Negative') THEN 1 ELSE NULL END) "Negative Male",
COUNT(CASE WHEN (sexe = 'Female' and resultat_fts1 = 'Negative') THEN 1 ELSE NULL END) "Negative Female",
COUNT(CASE WHEN ( resultat_fts1 = 'Negative') THEN 1 ELSE NULL END) "Total Negative",
COUNT(CASE WHEN ( resultat_fts1 = 'Invalid') THEN 1 ELSE NULL END) "Total Invalid"

FROM v_espen_bf_lf_tas1_3_resultat_fts_202010 d
LEFT JOIN espen_bf_lf_tas1_1_sites_202010 c on d.d_cluster_id::int = c.nb_grappe
RIGHT JOIN v_espen_bf_lf_tas1_2_enrolement_202010 p on p.barcode = d.barcode

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{nb_grappe}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY nb_grappe, c_eu_code, ds, nom_grappe
