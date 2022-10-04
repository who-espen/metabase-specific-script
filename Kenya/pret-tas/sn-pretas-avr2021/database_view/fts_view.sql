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
 * Variable to rename  v_espen_ke_lf_pretas_3_resultat_fts_202203_v4, espen_ke_lf_pretas_3_resultat_fts_202203_v4, espen_ke_lf_pretas_1_site_202203_v4
 */

CREATE OR REPLACE VIEW public.v_espen_ke_lf_pretas_3_resultat_fts_202203_v4
AS SELECT d.id,
    d.d_enumerator,
    d.d_county,
    d.d_subcounty,
    d.d_cluster_name,
    d.d_cluster_id,
        CASE
            WHEN d.d_id_method = 'Scanner'::text THEN d.p_barcode_id
            ELSE d.d_code_id
        END AS d_barcode_id,
    d.d_blood_sample,
    d.d_dbs_prepared,
    d.d_filter_paper_stored,
    d.d_lotnumber1,
    d.d_result1,
    d.d_why_invalid1,
    d.d_display_result1,
    d.d_need_second_test,
    d.d_lotnumber2,
    d.d_result2,
    d.d_why_invalid2,
    d.d_display_result2,
    d.d_final_result,
    d.d_start
   FROM espen_ke_lf_pretas_3_resultat_fts_202203_v4 d;
