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
 * Variable to rename espen_bj_lf_pretas_1_site_202009_v3, <%number_villlage%>
 */
with site as (select distinct c_cluster_id from v_espen_ng_lf_pretas_202404_1_site_v2) 
 
SELECT
	TO_CHAR(COUNT(*), '999 999')
FROM site

