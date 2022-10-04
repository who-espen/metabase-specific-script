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
 * Variable to rename  v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y, espen_bf_lf_tas3_3_resultat_sth_202209_y, espen_bf_lf_tas3_1_sites_202209_y
 */
create view v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y as

SELECT 

id, 
d_code_operateur,
d_ue, 
d_ds, 
--d_commune, 
d_nom_grappe,
null d_num_grappe,

case when d_id_methode = 'Manuel' then d_barcode_id2 else d_barcode_id1 end as d_barcode_id,

d_nb_bandelette,
d_lot_fts1,
d_resultat_fts1,
d_fts1_invalid_description, 
 d_photo1, 
 d_lot_fts2,
 d_resultat_fts2,
 d_fts2_invalid_description,
d_photo2,
concat (d_duree_sejour_mois,' mois, ', d_duree_sejour, ' jours')

d_defis_operationnels, 
 d_observations, 
 d_debut_enreg, 
 d_fin_enreg, 
 created_at

FROM public.espen_bf_lf_tas3_3_resultat_fts_202209_y_v1 d


union all

SELECT 

id, 
d_code_operateur,
d_ue, 
d_ds, 
--d_commune, 
null d_nom_grappe,
d_num_grappe,

case when d_id_methode = 'Manuel' then d_barcode_id2 else d_barcode_id1 end as d_barcode_id,

d_nb_bandelette,
d_lot_fts1,
d_resultat_fts1,
d_fts1_invalid_description, 
 d_photo1, 
 d_lot_fts2,
 d_resultat_fts2,
 d_fts2_invalid_description,
d_photo2,
concat (d_duree_sejour_mois,' mois, ', d_duree_sejour, ' jours')

d_defis_operationnels, 
 d_observations, 
 d_debut_enreg, 
 d_fin_enreg, 
 created_at

FROM public.espen_bf_lf_tas3_3_resultat_fts_202209_y_v3 d
