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
 * Variable to rename v_espen_tz_sch_sth_impact_202311_1_school_v4, v_espen_tz_sch_sth_impact_202311_3_kk_v4, v_espen_tz_sch_sth_impact_202311_4_urine_v4
 */

SELECT DISTINCT 

w_regiON,
w_district,
w_ward,
w_site,
w_gps_lat,
w_gps_lng

FROM
    v_espen_tz_sch_sth_impact_202311_1_school_v4 w
    LEFT JOIN v_espen_tz_sch_sth_impact_202311_3_kk_v4 k ON k.k_site_name = w.w_site
    LEFT JOIN v_espen_tz_sch_sth_impact_202311_4_urine_v4 u ON u.u_site_name = w.w_site

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