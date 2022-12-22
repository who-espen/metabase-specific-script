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
 * Variable to rename  espen_mz_lf_pretas_2_participant_202209_v1, espen_mz_lf_pretas_2_participant_202209_v1
 */
create view v_espen_mz_lf_pretas_2_participant_202209_v1 as

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

 case when p_id_method = 'Manual' then p_barcode_id1 2 else p_barcode_id1 1 end p_barcode_id1 ,
 
p_residence_type,
p_house_type,
p_education_degree, 
p_occupation, 
p_participate_last_mda, 
p_possess_net, 
p_use_net, 

 case when p_disease_knowledge = 'Outro' then p_disease_knowledge_other else p_disease_knowledge end p_disease_knowledge,
 
 p_notes, 
 p_start

FROM public.espen_mz_lf_pretas_2_participant_202209_v1 p


