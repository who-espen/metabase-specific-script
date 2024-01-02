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
 * Variable to rename  espen_bi_oncho_prestop_2_202307_questions_v3, v_espen_bi_oncho_prestop_2_202307_questions_v3
 */


create view v_espen_bi_oncho_prestop_2_202307_questions_v3 as

SELECT

e.id, 
p.p_date,
p.p_recorder_id,
p.r_chef_equipe, 
p.p_region, 
p.p_district, 
p.p_commune, 
p.p_centre_sante, 
p.p_cluster_name,

parent_id, 
e.p_add_participant, 
e.p_consent, 

case when e.p_id_type = 'Scanner' then e.p_barecode_id else e.p_manual_id end p_barecode_id,

e.p_sex, 
e.p_age_yrs, 
e.p_time_in_village, 
e.p_pris_dbs, 
e.p_note,

p.created_at c_start

FROM public.espen_bi_oncho_prestop_2_202307_questions_v3 p, espen_bi_oncho_prestop_2_202307_questions_v3_p e

where p.id = e.parent_id::int and  e.p_add_participant = 'Ajouter'



