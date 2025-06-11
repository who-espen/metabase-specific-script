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
 * Variable to rename  v_espen_lr_lf_tas1_2_child_202406_v1, v_espen_lr_lf_tas1_2_child_202406_v1
 */

create view v_espen_lr_lf_tas1_2_child_202406_v1 as

SELECT 

c.id, 
p.p_recorder, 
p.p_eu, 
p.p_cluster_name, 
p.p_cluster_id, 

c.parent_id,
c.p_consent, 
c.p_assent, 
c.p_num, 
c.p_espen_code_id, 
c.p_espen_code_id2, 
c.p_sex, 
c.p_age_yrs, 
c.p_how_long_lived, 
c.p_swallow_med, 
c.p_time_taken_med,
c.p_mosquito_net, 
c.p_sleep_mosq_net, 
c.p_comment,

p.p_start

FROM public.espen_lr_lf_tas1_2_child_202406_v1 p, espen_lr_lf_tas1_2_child_202406_v1_lr2tas1_202406 c

where p.id = c.parent_id::int





