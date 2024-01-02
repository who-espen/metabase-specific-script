/*
 * File: 22_complete_dataset.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:17 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This request will provid merged result from cluster, participant and OV16 form
 * Variable to rename <%v_ab_cde_fgh_3_rdt_ov16%>, v_espen_civ_oncho_ia_202309_1_site_v4
 */

select
    c_district_id,
    c_eu,
    c_cluster_id1,
    c_gps_lat,
    c_gps_lng,
    c_village_pop,
    c_black_fly,
    c_cluster_notes,
    p_consent,
    p_age_yrs,
    p_how_long_lived,
    p_travel,
    p_ivm,
    p_ivm_where,
    p_sexe,
    p_id_method,
    p_code_id,
    p_generate_id,
    p_additional_notes,
    d_lotnumber,
    d_lab_ov16,
    d_lab_ov16_invalid,
    d_notes,
    p_date
from
    v_espen_civ_oncho_ia_202309_2_participant_v4 p
    left join v_espen_civ_oncho_ia_202309_1_site_v4 c on c.c_cluster_id1 :: text = p.p_cluster_id
    left join < % v_ab_cde_fgh_3_rdt_ov16 % > d on d.d_code_id = p.p_code_id