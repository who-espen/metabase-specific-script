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
 * Variable to rename espen_gn_oncho_pre_stop_202311_1_site, <%number_villlage%>
 */

with sites as (select distinct c_cluster_name from public.v_espen_gn_oncho_pre_stop_2407_1_site_part)


SELECT count(*)
FROM
    sites
