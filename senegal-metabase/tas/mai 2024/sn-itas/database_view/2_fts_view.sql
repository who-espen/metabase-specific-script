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
 * Variable to rename  espen_sn_lf_itas_20305_2_fts_v4, espen_sn_lf_tas1_3_fts_result_202104_v2, v_espen_sn_lf_itas_2405_1_sit_part_v3_1
 */

create view v_espen_sn_lf_itas_20305_2_fts_v4 as

SELECT 

c.id, 
p.d_recorder_id, 
p.d_eu_name, 
p.d_commune, 
p.d_cluster_name, 
p.d_cluster_id, 
p.d_nb_part, 

c.parent_id,
c.d_id_type, 
c.d_barcode_id, 
c.d_manual_code_id, 
c.d_manual_code_id2, 
c.d_code_id, 
c.d_dbs_collect, 
c.d_lotnumber1,
c.d_result1,
c.d_why_invalid1,
c.d_why_invalid_other1,
c.d_photo_1, 
c.d_display_result1, 
c.d_need_second_test,
c.d_lotnumber2, 
c.d_result2, 
c.d_why_invalid2,
c.d_why_invalid_other2,
c.d_photo_2, 
c.d_final_result,
c.notes_part,

p.d_start

FROM public.espen_sn_lf_itas_20305_2_fts_v4 p, espen_sn_lf_itas_20305_2_fts_v4_sn_lf_f_2405_v4 c
where p.id = c.parent_id::int

union all

SELECT 

c.id, 
p.d_recorder_id, 
p.d_eu_name, 
p.d_commune, 
p.d_cluster_name, 
p.d_cluster_id, 
p.d_nb_part, 

c.parent_id,
c.d_id_type, 
c.d_barcode_id, 
c.d_manual_code_id, 
c.d_manual_code_id2, 
c.d_code_id, 
c.d_dbs_collect, 
c.d_lotnumber1,
c.d_result1,
c.d_why_invalid1,
c.d_why_invalid_other1,
c.d_photo_1, 
c.d_display_result1, 
c.d_need_second_test,
c.d_lotnumber2, 
c.d_result2, 
c.d_why_invalid2,
c.d_why_invalid_other2,
c.d_photo_2, 
c.d_final_result,
c.notes_part,

p.d_start

from public.espen_sn_lf_itas_20305_2_fts_v3_1 p, espen_sn_lf_itas_20305_2_fts_v3_1_sn_lf_f_2405_v3 c
where p.id = c.parent_id::int

