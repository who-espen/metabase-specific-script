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
 * Variable to rename  v_espen_bj_lf_pretas_3_resultat_fts_202009_v3, espen_bj_lf_pretas_3_resultat_fts_202009_v3, espen_bj_lf_pretas_1_site_202009_v3
 */
 CREATE view v_espen_bj_lf_pretas_3_resultat_fts_202009_v3
AS
SELECT
  d.id,
  d_recorder_id,
  c_district as d_district,
  d_cluster_id,
  d_cluster_name,

  d_code_id,

  d_lotnumber1,
  d_result1,

  CASE WHEN d_why_invalid1 = 'Other' THEN d_why_invalid_other1 ELSE d_why_invalid1 END AS d_why_invalid1,

  d_display_result1,
  d_lotnumber2,
  d_result2,

  CASE WHEN d_why_invalid2 = 'Other' THEN d_why_invalid_other2 ELSE d_why_invalid_other2 END AS d_why_invalid2,

  d_display_result2,
  case when d_result1 = 'Negative' then 'Negative' else d_final_result end as d_final_result,
  d.c_end d_date

FROM public.espen_bj_lf_pretas_3_resultat_fts_202009_v3 d
left join public.espen_bj_lf_pretas_1_site_202009_v3 c on c.c_cluster_id = d.d_cluster_id 