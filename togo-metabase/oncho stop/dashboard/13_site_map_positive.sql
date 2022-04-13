
/*
 * This query will will display a pin Map of clusters with Positivo cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_tg_oncho_stop_3_elisa_202204
 */
 SELECT
 
 c_district,
 c_cluster_id,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 c.c_start_time


FROM v_espen_tg_oncho_stop_1_site_202204 c
LEFT JOIN v_espen_tg_oncho_stop_3_elisa_202204 d on c.c_cluster_id = d.d_cluster_id

where d_lab_elisa = 'Positif'


