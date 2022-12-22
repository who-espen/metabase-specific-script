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
 * Variable to rename  espen_bf_lf_pretas_2_enrolement_202106_v2_2, v_espen_bf_lf_pretas_2_enrolement_202106_v2_2
 */
create or replace view v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 as

SELECT 
id, 
p_recorder_id, 
ds, 
csps, 
p_cluster_name, 
p_cluster_id,
p_consent, 

case when p_id_method = 'scanner' then p_barcode_id else manual_code end p_barcode_id,

numero_famille, 
numero_enquete,
numero_enquete_complet, 
p_age_yrs, 
p_sex,
status, 
ivm_alb, 
avm_alb_derniere_campagne, 
nb_fois_ivm_alb, 
migration,
migration_autre, 
lymphoedeme, 
hydrocele, 
p_ending_survey_note,
commentaires, 
p_start
FROM public.espen_bf_lf_pretas_2_enrolement_202106_v2_2 p;

