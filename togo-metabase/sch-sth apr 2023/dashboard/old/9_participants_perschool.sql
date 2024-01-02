/*
 * File: 9_participants_perschool.sql
 * File Created: Tuesday, 12th May 2020 1:50:37 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:52:52 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename v_espen_tg_sch_sth_impact_202309_1_school_v2, v_espen_tg_sch_sth_impact_202309_2_child_v2
 */

SELECT
    DISTINCT ON (w_site_name) w_recorder "Opérateur",
    w_district "District",
    w_usp "USP",
    w_site_name "Village",
    count (p.id) "Total Enfants"

FROM
    v_espen_tg_sch_sth_impact_202309_1_school_v2 c
    JOIN v_espen_tg_sch_sth_impact_202309_2_child_v2 p ON p.p_site = c.w_site_name

--WHERE id IS NOT NULL

GROUP BY w_recorder, w_district, w_usp, w_site_name 