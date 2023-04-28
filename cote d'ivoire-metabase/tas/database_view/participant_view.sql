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
 * Variable to rename  espen_ci_202302_lf_tas1_2_partcipants, v_espen_ci_202302_lf_tas1_2_partcipants
 */

create view v_espen_ci_202302_lf_tas1_2_partcipants as 

SELECT 

id,
 p_recorder_id, 
 p_eu_name,
 p_district,  
 p_district_id,

case when p_cluster_name = 'Autre' then p_cluster_name2 else p_cluster_name end p_cluster_name,

case when p_cluster_name = 'Autre' then p_cluster_id2 else p_cluster_id end p_cluster_id,

p_consent, 
p_sex,
p_age_yrs,
p_how_long_lived, 
p_num,
p_code_id,
p_notes,
c_start p_start

FROM public.espen_ci_202302_lf_tas1_2_partcipants p




