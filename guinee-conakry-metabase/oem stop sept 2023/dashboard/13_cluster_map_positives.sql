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
 * Variable to rename espen_gn_oncho_oem_202310_1_site_v3, <%v_ab_cde_fgh_3_rdt_ov16%>
 */

SELECT
    c_district,
    c_cluster_name_id1,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    created_at
FROM
    espen_gn_oncho_oem_202310_1_site_v3 c
    LEFT JOIN v_espen_gn_oncho_oem_3_resultat_ov16_202206_v3 d c.c_cluster_name_id = d.cluster_id
where
    d_lab_ov16 = '<%Positive%>' ------ Metabase filter -------
    -- [[and {{c_cluster_name_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]