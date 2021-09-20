/*
 * File: 8_village_visited_per_scheduled.sql
 * File Created: Tuesday, 12th May 2020 1:38:01 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:38:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This card will list all records with innacurate GPS
 * Variable to rename v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8, <%number_villlage%>
 */
 SELECT
	concat(count(id))
FROM v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8
WHERE id IS NOT NULL
