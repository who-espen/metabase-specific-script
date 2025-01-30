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
 * Variable to rename  espen_gw_lf_tas1_202402_3_fts_result_v2
, v_espen_gw_lf_tas1_202402_3_fts_result_v2

 */
create view v_espen_gw_lf_tas1_202402_2_partcipants_v2 as

select

c.id, 
p.p_recorder_id, 
p.p_eu, 
p.p_district, 
p.p_cluster_name, 
p.p_cluster_id, 

parent_id, 
c.p_consent, 
c.p_sex, 
c.p_age_yrs, 
c.p_how_long_lived, 
c.p_code_id, 
c.p_notes,

p.c_start p_start
FROM public.espen_gw_lf_tas1_202402_2_partcipants_v2 p, public.espen_gw_lf_tas1_202402_3_fts_result_v2_gw_p_202401_v2_1 c

where p.id = c.parent_id::int
