/*
 * File: 9_participants_perschool.sql
 * File Created: Tuesday, 12th May 2020 1:50:37 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:52:52 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename v_espen_bj_sch_sth_impact_202304_1_school, v_espen_bj_sch_sth_impact_202304_2_child
 */
SELECT
DISTINCT ON  (w_site_name)
	w_recorder "Opérateur",
	w_district "District",
	w_subdistrict "USP",
	
  w_site_name "Village",
	count (p.id) "Total Enfants"

FROM v_espen_bj_sch_sth_impact_202304_1_school c
JOIN v_espen_bj_sch_sth_impact_202304_2_child p ON p.p_site = c.w_site_name

--WHERE id IS NOT NULL


GROUP BY w_recorder, w_district, w_subdistrict, w_site_name

