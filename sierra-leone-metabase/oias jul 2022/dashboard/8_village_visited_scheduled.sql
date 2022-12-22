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
 * Variable to rename espen_bj_ng_oncho_oias_1_site_202009_v3, <%number_villlage%>
 */
 SELECT
	TO_CHAR(COUNT(*), '999 999')
FROM v_espen_sr_oncho_oem_1_site_202211_v_3
WHERE id IS NOT NULL
