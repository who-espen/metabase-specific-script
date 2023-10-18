/*
 * File: dbs_view.sql
 * File Created: Thursday, 23rd April 2020 3:07:02 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 23rd April 2020 3:09:04 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

 /*
 * Variable to rename  <%v_ab_cde_fgh_3_dbs%>, espen_cm_oncho_pre_stop_3_202309_diag_v2
 */

create view v_espen_cm_oncho_pre_stop_3_202309_diag_v2 as

SELECT 

id, 
d_recorder_id, 
d_region,
d_district, 
d_village, 
d_village_id, 
d_ecole, 
d_ecole_id, 
d_num_ordre,
d_num_final, 
d_dbs, 
d_nodule, 
d_nombre_nodules, 
d_localisation_nodules, 
d_gale, 
d_prurit, 
d_autre_morbidite, 
d_notes, 
d_start

FROM public.espen_cm_oncho_pre_stop_3_202309_diag_v1_2 d

union all

SELECT 

id, 
d_recorder_id, 
d_region,
d_district, 
d_village, 
d_village_id, 
d_ecole, 
d_ecole_id, 
d_num_ordre,
d_num_final, 
d_dbs, 
d_nodule, 
d_nombre_nodules, 
d_localisation_nodules, 
d_gale, 
d_prurit, 
d_autre_morbidite, 
d_notes, 
d_start

FROM public.espen_cm_oncho_pre_stop_3_202309_diag_v2 d


