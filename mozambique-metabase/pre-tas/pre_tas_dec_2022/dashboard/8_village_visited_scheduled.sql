/*
 * File: 8_village_visited_scheduled.sql
 * File Created: Tuesday, 5th May 2020 7:59:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 8:00:49 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename update_lf_tas_orphaned_table_from_diag_result_202212, <%number_villlage%>
 */
 SELECT
	concat(count(id))
FROM v_espen_mz_lf_pretas_1_site_202209_v1
WHERE id IS NOT NULL
