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
 * Variable to rename espen_cm_oncho_pre_stop_1_202309_village_v2, <%number_villlage%>
 */

with sites as (select distinct c_village from public.v_espen_cm_oncho_pre_stop_1_202309_village_v2)


SELECT count(*)
FROM
    sites
