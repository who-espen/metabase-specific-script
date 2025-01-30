/*
 * File: fts_view.sql
 * File Created: Monday, 4th May 2020 4:21:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 4:26:23 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  v_espen_ng_lf_tas_202402_3_resultat_fts_jgw_v3, espen_ng_lf_tas_202402_3_resultat_fts_jgw_v3, espen_ng_lf_tas_202402_1_site_jgw_v2_2
 */

create view v_espen_ng_lf_tas_202402_3_resultat_fts_jgw_v3 as
SELECT 

c.id, 
p.d_recorder_id, 
p.d_district, 
p.d_cluster_name, 
p.d_cluster_id, 

c.d_code_id, 
c.d_lotnumber1, 
c.d_result1, 
c.d_why_invalid1, 
c.d_why_invalid_other1, 
c.d_lotnumber2, 
c.d_result2, 
c.d_why_invalid2, 
c.d_why_invalid_other2, 
c.d_final_result,
c.notes_part,

p.c_start

FROM public.espen_ng_lf_tas_202402_3_resultat_fts_jgw_v2 p, espen_ng_lf_tas_202402_3_resultat_fts_jgw_v2_ng_fts_202402_v2_1 c

where p.id = c.parent_id::int

union all


SELECT 

c.id, 
p.d_recorder_id, 
p.d_district, 
p.d_cluster_name, 
p.d_cluster_id, 

c.d_code_id, 
c.d_lotnumber1, 
c.d_result1, 
c.d_why_invalid1, 
c.d_why_invalid_other1, 
c.d_lotnumber2, 
c.d_result2, 
c.d_why_invalid2, 
c.d_why_invalid_other2, 
c.d_final_result,
c.notes_part,

p.c_start

FROM public.espen_ng_lf_tas_202402_3_resultat_fts_jgw_v3 p, public.espen_ng_lf_tas_202402_3_resultat_fts_jgw_v3_ng_fts_202402_v3_1 c

where p.id = c.parent_id::int





