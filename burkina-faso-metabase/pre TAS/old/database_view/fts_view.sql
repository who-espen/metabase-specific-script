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
 * Variable to rename  v_espen_bf_lf_pretas_3_resultat_202007_v2, espen_bf_lf_pretas_3_resultat_202007_v2, espen_bf_lf_pretas_1_sites_202007
 */
CREATE OR REPLACE VIEW public.v_espen_bf_lf_pretas_3_resultat_202007_v2
AS SELECT d.id,
    d.d_recorder_id,
    d.village,
    d.d_cluster_id,
    d.d_id_type,
        CASE
            WHEN d.d_id_type = 'scanner' THEN d.d_barcode_id
            ELSE d.manual_code
        END AS d_barcode_id,
    d.nb_bandelette,
    d.d_lotnumber1,
    d.d_result1,
    d.fts1_invalid_description,
    d.autre_expliquer_fts1,
    d.d_lotnumber2,
    d.d_result2,
    d.fts2_invalid_description,
    d.photo,
    d.defis_operationnels,
    d.defis_operationnels_autre,
    d.observations,
    d.d_start AS d_date
   FROM espen_bf_lf_pretas_3_resultat_202007_v2 d;