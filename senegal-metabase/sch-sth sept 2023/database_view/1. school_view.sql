/*
 * File: school_view.sql
 * File Created: Monday, 11th May 2020 12:39:08 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 12:41:13 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_sn_sch_sth_impact_1_school_202308_v3_1
 */

create view v_espen_sn_sch_sth_impact_1_school_202308_v3_1 as

SELECT 

id, 
w_recorder, 
w_district,
w_subdistrict,
w_site_name, 
w_site_code, 
w_director_name,
w_consent, 
w_source_exist,
w_source_type, 
w_source_place, 
w_source_type2, 
-- w_source_type2_other,
w_place_water_point, 
w_water_point_used,
w_gps_lat,
w_gps_lng, 
w_gps_acc, 
w_remarks,
w_start

FROM espen_sn_sch_sth_impact_1_school_202308_v3_1 w



