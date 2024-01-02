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
 * Variable to rename  v_espen_sn_lf_tas_3_fts_result_202101_v3, espen_sn_lf_tas_3_fts_result_202101_v3, espen_sn_lf_tas_1_sites_202101_v3
 */
CREATE view v_espen_sn_lf_tas_3_fts_result_202101_v3
AS
SELECT
  id,
  d_recorder_id,
  d_district,
  d_cluster_id,
  d_cluster_name,

  CASE WHEN d_id_type = 'Scanner' THEN d_barcode_id ELSE d_generate_id END AS d_barcode_id,

  d_lotnumber1,
  d_result1,

  CASE WHEN d_why_invalid1 = 'Other' THEN d_why_invalid_other1 ELSE d_why_invalid1 END AS d_why_invalid1,

  d_display_result1,
  d_lotnumber2,
  d_result2,

  CASE WHEN d_why_invalid2 = 'Other' THEN d_why_invalid_other2 ELSE d_why_invalid_other2 END AS d_why_invalid2,

  d_display_result2,
  case when d_result1 = 'Negative' then 'Negative' else d_final_result end as d_final_result,
  c_end d_date

FROM public.espen_sn_lf_tas_3_fts_result_202101_v3 d
