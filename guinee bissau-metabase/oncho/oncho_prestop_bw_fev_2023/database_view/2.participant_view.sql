/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_ng_ng_oncho_prestop_2_participant_202302_v2, v_espen_gw_oncho_202302_prestop_2_participant_v1_2
 */

create view v_espen_gw_oncho_202302_prestop_2_participant_v1_2 as

SELECT 

id,
p_recorder_id,
p_region,
p_district,

case when p_cluster_name = 'Other' then p_cluster_name2 else p_cluster_name end p_cluster_name,

case when p_cluster_name = 'Other' then p_cluster_id2 else p_cluster_id end p_cluster_id,

p_date,
p_consent, 

case when p_id_method = 'Sim' then p_barcode_id else p_code_id end p_barcode_id,

p_sex, 
p_age_yrs,
p_how_long_lived,
p_travel,
p_ivm_taken, 
p_ivm_taken_last_12,
p_ivm_month, 
p_ivm_place,
p_sample_collected,
 p_additional_notes,
 p_start

FROM public.espen_gw_oncho_202302_prestop_2_participant_v1_2 p






