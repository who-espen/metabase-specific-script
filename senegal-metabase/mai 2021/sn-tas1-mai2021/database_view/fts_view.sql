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
 * Variable to rename  v_espen_sn_lf_tas1_3_fts_result_202105, espen_sn_lf_tas1_3_fts_result_202105, espen_sn_lf_tas1_1_sites_202105
 */
CREATE OR REPLACE VIEW public.v_espen_sn_lf_tas1_3_fts_result_202105
AS SELECT d.id,
  	d_recorder_id,
    d.d_eu_name,
    d.d_commune,
    d.d_cluster_id,
    d.d_cluster_name,
        CASE
            WHEN d.d_id_type = 'Scanner'::text THEN d.d_generate_id
            ELSE d.d_generate_id
        END AS d_generate_id,
    d.d_lotnumber1,
    d.d_result1,
        CASE
            WHEN d.d_why_invalid1 = 'Other'::text THEN d.d_why_invalid_other1
            ELSE d.d_why_invalid1
        END AS d_why_invalid1,
    d.d_display_result1,
    d.d_lotnumber2,
    d.d_result2,
        CASE
            WHEN d.d_why_invalid2 = 'Other'::text THEN d.d_why_invalid_other2
            ELSE d.d_why_invalid_other2
        END AS d_why_invalid2,
    d.d_display_result2,
        CASE
            WHEN d.d_result1 = 'Negative'::text THEN 'Negative'::text
            ELSE d.d_final_result
        END AS d_final_result,
    d.c_end AS d_start
   FROM espen_sn_lf_tas1_3_fts_result_202105 d;