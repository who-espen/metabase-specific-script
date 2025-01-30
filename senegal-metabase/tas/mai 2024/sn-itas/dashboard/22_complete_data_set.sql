/*
 * File: 22_complete_data_set.sql
 * File Created: Wednesday, 6th May 2020 1:54:52 pm
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 1:59:28 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * The result from three from joint
 * Variable to rename espen_sn_lf_itas_20305_2_fts_v4, v_espen_sn_lf_itas_2405_1_sit_part_v3_1, v_espen_sn_lf_itas_2405_1_sit_part_v3_1
 */

SELECT
    c_eu_code,
    c_eu_name,
    c_cluster_id1,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    c_population,
    c_present,
    c_site,
    c_site_type,
    p_consent,
    p_sex,
    p_age_yrs,
    p_how_long_lived,
    p_generate_id,
    d_lotnumber1,
    d_result1,
    d_why_invalid1,
    d_lotnumber2,
    d_result2,
    d_why_invalid2,
    d_final_result,
    d_start
from
    espen_sn_lf_itas_20305_2_fts_v4 d
    left join v_espen_sn_lf_itas_2405_1_sit_part_v3_1 c on d.d_cluster_id:: int = c.c_cluster_id1
    right join v_espen_sn_lf_itas_2405_1_sit_part_v3_1 p on p.p_generate_id = d.d_generate_id