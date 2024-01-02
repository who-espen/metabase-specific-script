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
 * Variable to rename espen_civ_oncho_ia_202309_1_site_v4, <%number_villlage%>
 */

with sites as (
        select distinct s_site
        from
            public.v_espen_civ_oncho_ia_202309_1_site_v4
    )

SELECT count(*) FROM sites 