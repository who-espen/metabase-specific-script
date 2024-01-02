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
 * Variable to rename v_espen_bi_oncho_prestop_3_202307_diag_v2, v_espen_bi_oncho_prestop_2_202307_questions_v3, espen_bi_oncho_prestop_1_202307_site_v3
 */

SELECT
    c_eu_code,
    c_district,
    c_site_id1,
    c_site,
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
    p_barecode_id,
    d_lotnumber1,
    d_lab_elisa,
    d_why_invalid1,
    d_lotnumber2,
    d_result2,
    d_why_invalid2,
    d_lab_elisa,
    d_start_time
from
    v_espen_bi_oncho_prestop_3_202307_diag_v2 d
    left join espen_bi_oncho_prestop_1_202307_site_v3 c on d.d_site_id:: int = c.c_site_id1
    right join v_espen_bi_oncho_prestop_2_202307_questions_v3 p on p.p_barecode_id = d.d_barecode_id