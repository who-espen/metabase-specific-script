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
 * Variable to rename v_espen_tz_sch_sth_impact_2405_1_school, v_espen_tz_sch_sth_impact_2405_2_child
 */

SELECT
    DISTINCT ON (w_site) w_recorder "Recorder ID",
    w_district "District",
    w_ward "Ward",
    w_site "School",
    count (p.id) "Total Enfants"

FROM
    v_espen_tz_sch_sth_impact_2405_1_school c
    JOIN v_espen_tz_sch_sth_impact_2405_2_child p ON p.p_site = c.w_site

--WHERE id IS NOT NULL

GROUP BY w_recorder, w_district, w_ward, w_site 