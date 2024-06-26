/*
 * File: 13_school_map_positives.sql
 * File Created: Tuesday, 12th May 2020 2:05:12 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 2:15:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2, v_espen_tg_sch_sth_ia_202404_2_kk_v3_1, v_espen_tg_sch_sth_ia_202404_3_ur_v3_1
 */

SELECT
    DISTINCT w_regiON,
    w_district,
    w_usp,
    w_site_name,
    w_gps_lat,
    w_gps_lng
FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 w
    LEFT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 k ON k.k_site_name = w.w_site_name
    LEFT JOIN v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 u ON u.u_site_name = w.w_site_name
where (
        k_sch_man_sa > 0
        OR k_sch_man_sb > 0
        OR k_ascaris_lumb_sa > 0
        OR k_ascaris_lumb_sb > 0
        OR k_hookwORm_sa > 0
        OR k_hookwORm_sb > 0
        OR k_trichuris_sa > 0
        OR k_trichuris_sb > 0
    ) ------ Metabase filter -------
    -- [[and {{c_school_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]