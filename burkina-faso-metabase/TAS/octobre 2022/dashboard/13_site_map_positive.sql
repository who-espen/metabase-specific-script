
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y
 */
 SELECT
  ds,
  nb_grappe,
  nom_de_la_grappe,
  gps_lat,
  gps_lng,
  created_at

FROM espen_bf_lf_tas3_1_sites_202209_y c
LEFT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on c.nb_grappe = d.d_cluster_id

where resultat_fts1 = '1_Positif' and resultat_fts2 = '1_Positif'

