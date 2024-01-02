/*
 * File: 13_village_map_positives.sql
 * File Created: Saturday, 2nd May 2020 1:50:50 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 1:53:33 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_cm_oncho_pre_stop_1_202309_village_v2, <%v_ab_cde_fgh_3_rdt_ov16%>
 */

SELECT
    c_district,
    c_village_id1,
    c_village,
    c_gps_lat,
    c_gps_lng,
    created_at
FROM
    espen_cm_oncho_pre_stop_1_202309_village_v2 c
    LEFT JOIN v_espen_cm_oncho_pre_stop_3_202309_diag_v2 d c.c_village_id = d.cluster_id
where
    d_lab_ov16 = '<%Positive%>' ------ Metabase filter -------
    -- [[and {{c_village_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]