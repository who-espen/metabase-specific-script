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
 * Variable to rename  espen_ng_lf_tas_202403_2_participant_bay_v2, v_espen_ng_lf_tas_202403_2_participant_bay_v2
 */

create view v_espen_ng_lf_tas_202403_2_participant_bay_v2 as

SELECT 

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

FROM public.espen_ng_lf_tas_202403_2_participant_bay_v2 p, espen_ng_lf_tas_202403_2_participant_bay_v2_ng_p_202403_v2 c
where p.id = c.parent_id::int

