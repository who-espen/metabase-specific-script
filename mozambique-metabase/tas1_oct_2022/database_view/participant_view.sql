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
 * Variable to rename  espen_mz_lf_tas1_2_participant_202209_v1, v_espen_mz_lf_tas1_2_participant_202209_v1
 */
create view v_espen_mz_lf_tas1_2_participant_202209_v1 as

SELECT 

id,
p_recorder_id,
p_province, 
p_district, 
p_cluster_name, 
p_cluster_id, 
p_consent, 
p_sex, 
p_age_yrs, 
p_how_long_lived,

case when  p_id_method = 'Manual' then p_barcode_id2 else p_barcode_id1 end p_barcode_id,

p_mosquito_prevent,
p_possess_net,
p_use_net, 
p_building_type,
 p_notes, 
 p_start

FROM public.espen_mz_lf_tas1_2_participant_202209_v1 p

