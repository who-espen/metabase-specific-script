
/*
 * This query will will display a pin Map of clusters with Positivo cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_tg_oncho_stop_202304_3_elisa
 */
 SELECT
 
 c_district,
 c_site_id,
 c_site,
 c_gps_lat,
 c_gps_lng,
 c.c_start_time


FROM v_espen_tg_oncho_stop_202304_1_site c
LEFT JOIN v_espen_tg_oncho_stop_202304_3_elisa d on c.c_site_id = d.d_site_id

where d_lab_elisa = 'Positif'


