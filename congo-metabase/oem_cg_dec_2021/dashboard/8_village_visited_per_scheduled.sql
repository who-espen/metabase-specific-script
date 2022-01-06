/*
 * File: 8_village_visited_per_scheduled.sql
 * File Created: Friday, 1st May 2020 10:51:39 pm
 * Author: Dyesse YUMBA
 * Last Modified: Friday, 1st May 2020 10:54:31 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename v_espen_cg_oncho_oem_full_202112, <%number_villlage%>
 */
 SELECT
	concat(count(distinct cluster_name))
FROM v_espen_cg_oncho_oem_full_202112
WHERE id IS NOT null
