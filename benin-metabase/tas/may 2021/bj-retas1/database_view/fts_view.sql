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
 * Variable to rename  v_espen_bj_lf_retas1_3_fts_result_202104_v3, espen_bj_lf_retas1_3_fts_result_202104_v3, espen_bj_lf_retas1_1_sites_202104_v3
 */
 CREATE view v_espen_bj_lf_retas1_3_fts_result_202104_v3
AS

SELECT 

    d.id,
    d.d_recorder_id,
    d.d_eu_name,
    d.d_commune,
    d.d_cluster_name,
    d.d_cluster_id,
    d.d_id_sequence,
    d.d_code_id,
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
    d.d_lotnumber3,
    d.d_result3,
        CASE
            WHEN d.d_why_invalid3 = 'Other'::text THEN d.d_why_invalid_other3
            ELSE d.d_why_invalid3
        END AS d_why_invalid3,
    d.d_final_result,
    d.d_start

FROM public.espen_bj_lf_retas1_3_fts_result_202104_v3 d
