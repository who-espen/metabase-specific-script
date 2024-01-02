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
 * Variable to rename v_espen_sn_sch_sth_impact_1_school_202308_v3_1, v_espen_sn_sch_sth_impact_3_resultats_202308_v3, v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1
 */

SELECT DISTINCT 

w_regiON,
w_district,
w_subdistrict,
w_site_name,
w_gps_lat,
w_gps_lng

FROM
    v_espen_sn_sch_sth_impact_1_school_202308_v3_1 w
    LEFT JOIN v_espen_sn_sch_sth_impact_3_resultats_202308_v3 k ON k.k_site_name = w.w_site_name
    LEFT JOIN v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 u ON u.u_site_name = w.w_site_name

where (
        k_sch_man_sa > 0
        OR k_sch_man_sb > 0
        OR k_ascaris_lumb_sa > 0
        OR k_ascaris_lumb_sb > 0
        OR k_hookwORm_sa > 0
        OR k_hookwORm_sb > 0
        OR k_trichuris_sa > 0
        OR k_trichuris_sb > 0
    )

------ Metabase filter -------

-- [[and {{c_school_id}}]]

-- [[and {{cluster_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]