
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_bf_lf_tas1_3_resultat_fts_202010
 */
 SELECT
  ds,
  nb_grappe,
  nom_grappe,
  gps_lat,
  gps_lng,
  created_at

FROM espen_bf_lf_tas1_1_sites_202010 c
LEFT JOIN v_espen_bf_lf_tas1_3_resultat_fts_202010 d on c.nb_grappe = d.d_cluster_id

where resultat_fts1 = '1_Positif' and resultat_fts2 = '1_Positif'

  ------ Metabase filter -------
  -- [[and {{nb_grappe}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
