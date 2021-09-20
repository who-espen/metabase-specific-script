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
 * Variable to rename  v_espen_ci_pretas_lf_resultats_v7, <%ab_cde_fgh_3_fts%>, espen_ci_lf_pretas_1_site_202105_v3
 */
 CREATE view v_espen_ci_pretas_lf_resultats_v7
AS
SELECT
  id,
  code_operateur,
  d_eu_code,
  d_cluster_id,
  c.c_site d_cluster_name,

  CASE WHEN d_id_type = 'Scanner' THEN code_id ELSE d_generate_id END AS code_id,

  d_lotnumber1,
  d_result1,

  CASE WHEN d_why_invalid1 = 'Other' THEN d_why_invalid_other1 ELSE d_why_invalid1 END AS d_why_invalid1,

  d_display_result1,
  d_lotnumber2,
  d_result2,

  CASE WHEN d_why_invalid2 = 'Other' THEN d_why_invalid_other2 ELSE d_why_invalid_other2 END AS d_why_invalid2,

  d_display_result2,
  d_final_result,
  d_end d_date

FROM <%ab_cde_fgh_3_fts%> d
   left join espen_ci_lf_pretas_1_site_202105_v3 c on d.d_cluster_id::int = c.c_cluster_id1
