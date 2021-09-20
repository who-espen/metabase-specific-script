/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_sn_lf_tas2_1_sites_202101, espen_sn_lf_tas2_1_sites_202101
 */
CREATE VIEW v_espen_sn_lf_tas2_2_partcipants_202101
AS
SELECT
  id,
  p_recorder_id,
  p_eu_name,
  p_c_commune,
  p_cluster_name,
  p_cluster_id,
  p_consent,
  p_sex,
  p_age_yrs,
  p_how_long_lived,

  CASE WHEN p_id_method = 'Scanner' THEN p_barcode_id ELSE p_generate_id END AS p_barcode_id,

  p_notes,
  c_end p_date

FROM espen_sn_lf_tas2_2_partcipants_202101 p

