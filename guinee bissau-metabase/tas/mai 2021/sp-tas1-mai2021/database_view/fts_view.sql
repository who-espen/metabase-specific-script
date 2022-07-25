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
 * Variable to rename  v_espen_gw_lf_tas1_3_fts_result_202206_v2_1
, espen_gw_lf_tas1_3_fts_result_202206_v2_1
, espen_gw_lf_tas1_1_sites_202206_v2_1

 */
CREATE OR REPLACE VIEW public.v_espen_gw_lf_tas1_3_fts_result_202206_v2_1 AS 
SELECT d.id,
    d.d_recorder_id,
    d.d_region,
    d.d_district,
    d.d_cluster_name,
    d.d_cluster_id,
        CASE
            WHEN d.d_id_type = 'Scanner'::text THEN d.d_barcode_id
            ELSE d.d_generatedid
        END AS d_barcode_id,
    d.d_lotnumber1,
    d.d_result1,
        CASE
            WHEN d.d_why_invalid1 = 'Other'::text THEN d.d_why_invalid_other1
            ELSE d.d_why_invalid1
        END AS d_why_invalid1,
    d.d_lotnumber2,
    d.d_result2,
        CASE
            WHEN d.d_why_invalid2 = 'Other'::text THEN d.d_why_invalid_other2
            ELSE d.d_why_invalid2
        END AS d_why_invalid2,
    d.d_final_result,
    d.d_positivo_why_no_tx,
    d.notes_part,
    d.c_start AS d_start
   FROM public.espen_gw_lf_tas1_3_fts_result_202206_v2_1 d;