/*
 * File: 8_village_visited_per_scheduled.sql
 * File Created: Tuesday, 12th May 2020 1:38:01 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:38:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2, <%number_villlage%>
 */

SELECT concat(count(id))
FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2
WHERE id IS NOT NULL