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
 * Variable to rename espen_ci_202302_lf_conf_1_sites, <%number_villlage%>
 */

with sites as (select distinct c_cluster_id from v_espen_ci_202302_lf_conf_1_sites)
 
SELECT
	concat(count(c_cluster_id))
FROM sites
