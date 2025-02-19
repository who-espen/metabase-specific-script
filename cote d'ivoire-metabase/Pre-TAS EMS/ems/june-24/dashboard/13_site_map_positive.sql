
/*
 * This query will will display a pin Map of clusters with Positif cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_ci_lf_pretas_2406_4_fts_v4
 */
 SELECT
 
 c_region,
 c_district,
 c_site_id,
 c_site,
 c_gps_lat,
 c_gps_lng,
 c.c_start


FROM v_espen_ci_lf_pretas_2406_1_site_v4 c
LEFT JOIN v_espen_ci_lf_pretas_2406_4_fts_v4 d on c.c_site_id = d.d_site_id

where d_result = 'Positif'

