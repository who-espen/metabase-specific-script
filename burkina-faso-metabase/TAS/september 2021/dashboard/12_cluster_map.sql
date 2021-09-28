/*
 * File: 12_cluster_map.sql
 * File Created: Wednesday, 6th May 2020 10:55:50 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 10:56:54 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename espen_bf_lf_tas3_1_sites_202109
 */
 SELECT

 drs,
 nb_grappe,
 nom_de_la_grappe,
 gps_lat,
 gps_lng,
 date_enregistrement

FROM v_espen_bf_lf_tas3_1_sites_202109

  ------ Metabase filter -------
  -- [[and {{nb_grappe}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
