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
 * Variable to rename espen_bf_lf_tas3_1_sites_202209_y, <%number_villlage%>
 */
 SELECT
	concat(count(id), '/', 28)
FROM v_espen_bf_lf_tas3_1_site_202209_v1_y
WHERE id IS NOT NULL
