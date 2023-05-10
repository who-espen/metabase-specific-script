
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_sn_lf_tas2_3_fts_result_202101
 */
 SELECT
 
 c_eu_name,
 c_commune,
 c_cluster_id,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 c.c_date


FROM v_espen_sn_lf_tas2_1_sites_202101 c
LEFT JOIN v_espen_sn_lf_tas2_3_fts_result_202101 d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positive'

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
