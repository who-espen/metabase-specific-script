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
 * Variable to rename  v_espen_cv_pretas_lf_village_v7, <%ab_cde_fgh_1_site%>
 */
CREATE view v_espen_cv_pretas_lf_village_v7
AS
SELECT
  id,
  c_survey_type,
  c_recorder,
  c_eu_code,
  c_district,
  c_site,
  c_site_type,
  c_cluster_name,
  c_cluster_id1,
  c_cluster_leader,
  c_population,
  c_present,
  c_consent,
  c_gps_lat,
  c_gps_lng,
  c_gps_alt,
  c_gps_acc,
  c_cluster_notes,
  c_end c_date
FROM <%ab_cde_fgh_1_site%> c
