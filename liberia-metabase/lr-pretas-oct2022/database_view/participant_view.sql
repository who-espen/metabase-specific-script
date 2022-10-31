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
 * Variable to rename  v_espen_lr_lf_tas1_2_participant_202210_v0, v_espen_lr_lf_tas1_2_participant_202210_v0
 */
create view v_espen_lr_lf_tas1_2_participant_202210_v0 as

SELECT 

id, 
p_recorder_id,
p_eu, 
p_district,
p_cluster_name, 
p_cluster_id, 
p_consent,

case when p_id_method = 'ID_generation' then  p_code_id else p_barcode_id end p_barcode_id,

p_sex, 
p_age_yrs,
p_how_long_lived, 
p_notes, 
p_start


FROM public.espen_lr_lf_tas1_1_site_202210_v0 p

