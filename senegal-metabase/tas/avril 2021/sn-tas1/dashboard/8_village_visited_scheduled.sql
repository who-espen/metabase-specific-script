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
 * Variable to rename espen_sn_lf_tas1_1_sites_202104_v2, <%number_villlage%>
 */
 SELECT
	concat(count(id), '/', 28)
FROM v_espen_sn_lf_tas1_1_sites_202104_v2
WHERE id IS NOT NULL
