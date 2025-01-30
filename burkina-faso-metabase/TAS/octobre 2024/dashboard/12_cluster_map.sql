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
 * Variable to rename espen_bf_lf_tas3_1_sites_202307
 */

select

    c_ds,
    c_site,
    c_numero_ordre_grappe,
    c_gps_lat,
    c_gps_lng,
    c_debut_enreg
    
FROM v_espen_bf_lf_tas1_202306_1_site_v4

