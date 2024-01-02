/*
 * File: fts_view.sql
 * File Created: Monday, 4th May 2020 4:21:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 4:26:23 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bi_oncho_prestop_3_202307_diag_v2, espen_bi_oncho_prestop_3_202307_diag_v2, espen_bi_oncho_prestop_1_202307_site_v3
 */


create view v_espen_bi_oncho_prestop_3_202307_diag_v2 as 

select

id, 
d_recorder_id, 
d_region, 
d_district, 
d_commune, 
d_centre_sante,
d_cluster_name, 

case when d_id_type = 'Manuel' then d_manual_id else d_barecode_id end d_barecode_id,

d_elisa_value_od,
d_elisa_result,
d_elisa_value_od_2, 
d_elisa_result_2, 
d_cluster_notes, 
d_start_time d_start

FROM public.espen_bi_oncho_prestop_3_202307_diag_v2 d
