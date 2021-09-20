/*
 * File: urine_result_view.sql
 * File Created: Monday, 11th May 2020 1:35:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:38:48 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8, <%ab_cde_fgh_4_urine%>
 */
CREATE view v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8
AS
SELECT

  id,
  u_recorder_id,
  u_district,
  u_school_id,
  CASE WHEN u_id_type = 'Scanner' THEN u_barcode_id ELSE u_generate_id END AS u_barcode_id,
  u_exam,
  u_sh_egp_10ml,
  u_haematuria,
  u_grading,
  u_cca,
  u_remarks,
  u_end u_date

FROM <%ab_cde_fgh_4_urine%> u
