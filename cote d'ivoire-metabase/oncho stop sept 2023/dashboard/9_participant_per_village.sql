/*
 * File: 9_participant_per_village.sql
 * File Created: Saturday, 2nd May 2020 11:05:52 am
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:10 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename espen_civ_oncho_ia_202309_1_site_v4, v_espen_civ_oncho_ia_202309_2_participant_v4
 */

SELECT
    DISTINCT ON (s_site) s_recorder_id "Recorder ID",
    s_district "District",
    --s_cluster_id "Code Site",
    s_site "Site",
    count (p.id) "Total Participants" --s_village_pop "Total Population"
FROM
    espen_civ_oncho_ia_202309_1_site_v4 c
    JOIN v_espen_civ_oncho_ia_202309_2_participant_v4 p ON p.p_site = c.s_site

GROUP BY
    s_recorder_id,
    s_site,
    s_district -- s_village_pop