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
 * Variable to rename v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8, v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8
 */
SELECT
DISTINCT ON  (w_school_id)
	c_recorder_id "Recorder ID",
	c_district_id "District",
	w_school_id "School ID",
  w_school_name "School Name",
	count (p.id) "Total Children",
	c_village_pop "Total Children in school"

FROM v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8 c
JOIN v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p ON p.p_school_id::INT = c.w_school_id

WHERE id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_recorder_id, w_school_id, c_district_id, c_village_pop
