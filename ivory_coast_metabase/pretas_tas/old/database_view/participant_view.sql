/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_ci_pretas_lf_enrollement_v7, v_espen_ci_pretas_lf_enrollement_v7
 */
CREATE VIEW v_espen_ci_pretas_lf_enrollement_v7
AS
SELECT
  id,
  code_operateur,
  p_eu_code,
  p_cluster_name,
  p_cluster_id,
  p_consent,
  p_sex,
  p_age_yrs,
  p_how_long_lived,

  CASE WHEN p_id_method = 'Scanner' THEN code_id ELSE p_generate_id END AS code_id,

  p_notes,
  p_end p_date

FROM espen_ci_pretas_lf_enrollement_v7 p
