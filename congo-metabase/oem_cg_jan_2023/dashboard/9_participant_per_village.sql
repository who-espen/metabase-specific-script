/*
 * File: 9_participant_per_village.sql
 * File Created: Saturday, 2nd May 2020 11:05:52 am
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:10 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename v_espen_cg_oncho_oem_full_202112, v_espen_cg_oncho_oem_full_202112
 */
SELECT
DISTINCT ON  ("Code Village")
	"Enregistreur",
	"District",
	"Code Village",
  "Village",
	count (p.id) "Total Participants"

FROM public.v_espen_cg_oncho_oem_202303_1_site_dbs p 


GROUP BY "Enregistreur", "Code Village", "District", "Village"
