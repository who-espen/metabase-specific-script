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
 * Variable to rename  espen_bf_lf_tas3_2_enrolement_202209_y, v_espen_bf_lf_tas3_2_participant_202209_v1_y
*/
create view v_espen_bf_lf_tas3_2_participant_202209_v1_y as 

SELECT 

id,
p_code_operateur,
p_ue,
p_ds,
p_commune, 
p_nom_grappe,
p_num_menage,

case when p_id_methode = 'Scanner' then p_barcode_id1 else p_barcode_id2 end as p_barcode_id,

p_age, 
p_sexe, 
p_scolarise, 
p_commentaire,
p_debut_enreg, 
p_fin_enreg, 
created_at

FROM public.espen_bf_lf_tas3_2_participant_202209_y_v1 p

