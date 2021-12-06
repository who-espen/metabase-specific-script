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
 * Variable to rename  v_espen_mz_lf_pretas_3_resultat_fts_202111_2_1, espen_mz_lf_pretas_3_resultat_fts_202111_2_1, espen_mz_lf_pretas_2_participant_202111_v2_1
 */
create view v_espen_mz_lf_pretas_3_resultat_fts_202111_2_1 as

SELECT d.id,
    d.d_recorder_id,
    d.d_province,
    d.d_district,
    d.d_cluster_name ,
    d.d_cluster_id,
    d.d_id_sequence,
    d.d_code_id,
    d.d_lotnumber1,
    d.d_result1,
    d.d_why_invalid1,
    d.d_why_invalid_other1,
    d.d_display_result1,
    d.d_need_second_test,
    d.d_lotnumber2,
    d.d_result2,
    d.d_why_invalid2,
    d.d_why_invalid_other2,
    d.d_display_result2,
    d.d_final_result,
    d.d_display_final_result,
    d.d_positive_why_no_tx,
    d.notes_part,
    d.d_start
   FROM espen_mz_lf_pretas_3_resultat_fts_202111_2_1 d;
   
