/*
 * File: participant_view.sql
 * File Created: Thursday, 23rd April 2020 2:11:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 28th April 2020 5:29:11 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_cm_oncho_pre_stop_2_202309_couverture_v2, espen_cm_oncho_pre_stop_1_202309_village_v2, v_espen_cm_oncho_pre_stop_2_202309_couverture_v2
 */

create view v_espen_cm_oncho_pre_stop_2_202309_couverture_v2 as

SELECT 

id, 
p_recorder_id,
p_region, 
p_district, 
p_village, 
p_village_id, 
p_ecole, 
p_ecole_id, 
p_num_ordre, 
p_num_final, 
p_sexee, 
p_age, 
p_annees_vecu_village, 
p_autre_lieu, 
p_ivm_hist, 
p_anne_ivm, 
p_nb_traitement_ivm, 
p_raison_non_traitement, 
p_notes, 
p_start

FROM public.espen_cm_oncho_pre_stop_2_202309_couverture_v1_2 p

union all 

SELECT 

id, 
p_recorder_id,
p_region, 
p_district, 
p_village, 
p_village_id, 
p_ecole, 
p_ecole_id, 
p_num_ordre, 
p_num_final, 
p_sexee, 
p_age, 
p_annees_vecu_village, 
p_autre_lieu, 
p_ivm_hist, 
p_anne_ivm, 
p_nb_traitement_ivm, 
p_raison_non_traitement, 
p_notes, 
p_start

FROM public.espen_cm_oncho_pre_stop_2_202309_couverture_v2 p
