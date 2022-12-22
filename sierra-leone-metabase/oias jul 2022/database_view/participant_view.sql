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
 * Variable to rename  espen_ng_ng_oncho_oias_2_participant_202212_v2, v_espen_sr_oncho_oem_2_participant_202211_v1_3
 */
create view v_espen_sr_oncho_oem_2_participant_202211_v1_3 as
SELECT 

id, 
p_recorder_id,
p_district,

case when p_cluster_name like '%Spare%' then p_cluster_name_other else p_cluster_name end p_cluster_name,


p_cluster_id, 
p_date,
p_consent, 
p_serial_number1, 
p_serial_number2,
p_code_id, 
p_sex, 
p_how_long_lived,
p_age_yrs, 
p_travel, 
p_ivm, 
p_ivm_where,
p_sample_collected,
p_additional_notes, 
p_start

FROM public.espen_sr_oncho_oem_2_participant_202211_v1_3 p

