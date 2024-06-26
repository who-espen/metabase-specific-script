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
 * Variable to rename  v_espen_gw_lf_tas1_202402_3_fts_result_v2
, espen_gw_lf_tas1_202402_3_fts_result_v2
, espen_gw_lf_tas1_202402_1_sites_v2

 */
CREATE OR REPLACE VIEW public.v_espen_gw_lf_tas1_202402_3_fts_result_v2 AS 
SELECT c.id,
    p.d_recorder_id,
    p.d_eu,
    p.d_district,
    p.d_cluster_name,
    p.d_cluster_id,
    c.d_add_results,
    c.parent_id,
    c.d_code_id,
    c.d_lotnumber1,
    c.d_result1,
    c.d_why_invalid1,
    c.d_why_invalid_other1,
    c.d_lotnumber2,
    c.d_result2,
    c.d_why_invalid2,
    c.d_why_invalid_other2,
    c.d_final_result,
    c.notes_part,
    p.c_start AS d_start
   FROM espen_gw_lf_tas1_202402_3_fts_result_v2 p,
    espen_gw_lf_tas1_202402_3_fts_result_v2_gw_fts_202402_v2 c

  WHERE p.id = c.parent_id::integer;