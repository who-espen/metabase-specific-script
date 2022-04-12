
/*
 * This query will will display a pin Map of clusters with Positivo cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_st_lf_tas1_3_fts_result_202204_3
 */
 SELECT
 
 c_eu_name,
 c_commune,
 c_cluster_id,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 c.c_start


FROM v_espen_st_lf_tas1_1_sites_202204_3 c
LEFT JOIN v_espen_st_lf_tas1_3_fts_result_202204_3 d on c.c_cluster_id = d.d_cluster_id

where d_result1 = 'Positivo'

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
