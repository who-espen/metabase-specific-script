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
 * Variable to rename  espen_bj_lf_tas2_5_partcipants_202104_v2, v_espen_bj_lf_tas2_5_partcipants_202104_v2
 */
create view v_espen_bj_lf_tas2_5_partcipants_202104_v2 as

SELECT 

id, 
p_recorder_id,
p_eu_name, 
p_c_commune, 
p_cluster_name, 
p_cluster_id, 
p_consent, 
p_sex, 
p_age_yrs,
p_how_long_lived, 
p_id_sequence, 
p_code_id, 
p_notes, 
p_start

FROM public.espen_bj_lf_tas2_5_partcipants_202104_v2 p

