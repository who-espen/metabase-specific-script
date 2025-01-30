/*
 * File: child_view.sql
 * File Created: Monday, 11th May 2020 1:05:59 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:11:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_202403_sch_ia_2_enrolement, v_espen_bf_202403_sch_ia_2_enrolement
 */
 
 create view v_espen_bf_202403_sch_ia_2_enrolement as

SELECT 

p.id, 
p.p_recorder,
p.p_district,
p.p_subdistrict, 
p.p_site_name,
p.p_site_code, 
p.p_affections, 

e.parent_id, 
e.p_add_more_child, 
e.p__num, 
e.p__classe, 
e.p__sex, 
e.p__consent, 
e.p__age_yrs, 
e.p__chaussures, 
e.p__latrines, 
e.p__espen_code_id, 
e.p__collected_stool, 
e.p__collected_urine, 
e.p__grading, 
e.p__urine_conserve, 
e.p__sample_note, 
e.p__remarks,

p.p_start


FROM public.espen_bj_sch_sth_impact_202304_2_child p, espen_bj_sch_sth_impact_202304_2_child_p_boucle e

where p.id::text = e.parent_id
