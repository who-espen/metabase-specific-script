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
DISTINCT ON  ("Village")
	c_recorder_id "Enregistreur",
	c_district "District",
	--"Code Village",
  c_cluster_name "Village",
	count (p.id) "Total Participants",
	'DBS' Fromulaire

FROM public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 p 


GROUP BY "Enregistreur",  "District", "Village"
union all 
SELECT
DISTINCT ON  ("Village")
	recorder_id "Enregistreur",
	district "District",
	--"Code Village",
    cluster_name "Village",
	count (p.id) "Total Participants",
	'Biopsie' Fromulaire

FROM public.v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 p 


GROUP BY "Enregistreur",  "District", "Village"