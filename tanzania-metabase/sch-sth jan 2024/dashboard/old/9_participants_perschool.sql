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
 * Variable to rename v_espen_tz_sch_sth_impact_202311_1_school_v4, v_espen_tz_sch_sth_impact_202311_2_child_v4
 */

SELECT
    DISTINCT ON (w_site) w_recorder "Recorder ID",
    w_district "District",
    w_ward "Ward",
    w_site "School",
    count (p.id) "Total Enfants"

FROM
    v_espen_tz_sch_sth_impact_202311_1_school_v4 c
    JOIN v_espen_tz_sch_sth_impact_202311_2_child_v4 p ON p.p_site = c.w_site

--WHERE id IS NOT NULL

GROUP BY w_recorder, w_district, w_ward, w_site 