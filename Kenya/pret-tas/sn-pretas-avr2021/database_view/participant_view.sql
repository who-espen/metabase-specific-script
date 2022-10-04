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
 * Variable to rename  espen_ke_lf_pretas_2_participant_202203_v4, v_espen_ke_lf_pretas_2_participant_202203_v4
 */
create view v_espen_ke_lf_pretas_2_participant_202203_v4 as 
SELECT 

id, 
p_enumerator, 
p_county,
p_subcounty, 
p_cluster_name,
p_cluster_id, 
p_consent,

case when p_id_method = 'Scanner' then p_barcode_id else p_barcode_id end p_barcode_id,

p_sex,
p_age_yrs,

concat (p_dob__date, ' ', p_dob__month, ' ', p_dob__year) p_birth_date,

 p_lived_last_1yr,
 p_oth_recent_subcounties, 
 p_length_reside, 
 p_bednet, 
 p_bednet_lastnight, 
 p_previous_trt, 
 p_notes, p_start,
 p_end

FROM public.espen_ke_lf_pretas_2_participant_202203_v4 p

