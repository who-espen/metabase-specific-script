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
 * Variable to rename  v_espen_bf_lf_pretas_3_resultat_202106_v2_1, espen_bf_lf_pretas_3_resultat_202007_v2_1, espen_bf_lf_pretas_1_sites_202106_v2
 */
create view v_espen_bf_lf_pretas_3_resultat_202106_v2_1
as

SELECT 
id,
d_recorder_id, 
village, 
d_cluster_id, 

case when d_id_type = 'scanner' then d_barcode_id else manual_code end d_barcode_id,

nb_bandelette, 
d_lotnumber1, 
d_result1,
fts1_invalid_description,
autre_expliquer_fts1,
photo1, 
d_lotnumber2, 
d_result2, 
fts2_invalid_description,
photo2, 

case when defis_operationnels = 'G_Autre_expliquer' then defis_operationnels_autre else defis_operationnels end defis_operationnels,


observations, 
d_start
FROM public.espen_bf_lf_pretas_3_resultat_202007_v2_1;
