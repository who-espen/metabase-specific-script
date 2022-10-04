/*
 * File: 1_participant_per_village.sql
 * File Created: Thursday, 7th May 2020 11:30:31 am
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 7th May 2020 11:33:12 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return a table that will contain the number of participants per village surveyed the day before.
 * Variable to rename v_espen_bf_lf_tas3_1_site_202209_v1_y, v_espen_bf_lf_tas3_2_participant_202209_v1_y
 */
 SELECT
  code_operateur "Code Opérateur",
  ds "Duistrict",
  nb_grappe "Cluster ID",
  nom_de_la_grappe "Nom du Site",
  COUNT(p.id) "# Participant"

FROM v_espen_bf_lf_tas3_1_site_202209_v1_y c
LEFT JOIN v_espen_bf_lf_tas3_2_participant_202209_v1_y p ON c.nb_grappe = p.nb_grappe::INT

where p.date_enregistrement > CURRENT_DATE - 1

GROUP BY code_operateur, ds, nb_grappe, nom_de_la_grappe
