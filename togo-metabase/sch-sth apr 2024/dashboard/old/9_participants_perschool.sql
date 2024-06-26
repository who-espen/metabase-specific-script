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
 * Variable to rename v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2, v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2
 */

SELECT
    DISTINCT ON (w_site_name) w_recorder "Opérateur",
    w_district "District",
    w_usp "USP",
    w_site_name "Village",
    count (p.id) "Total Enfants"

FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 c
    JOIN v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p ON p.p_site = c.w_site_name

--WHERE id IS NOT NULL

GROUP BY w_recorder, w_district, w_usp, w_site_name 