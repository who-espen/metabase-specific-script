/*
 * File: cluster_view.sql
 * File Created: Wednesday, 22nd April 2020 2:51:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 9:57:12 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_gn_oncho_oem_202310_1_site_v3, espen_gn_oncho_oem_202310_1_site_v3
 */

create view v_espen_gn_oncho_oem_202310_1_site_v3 as

SELECT 

id, 
c_recorder_id, 
c_district, 
c_sub_district,

case when c_cluster_name = 'Autre' then c_cluster_name2 else c_cluster_name end c_cluster_name,

c_cluster_id,
c_gps_lat, 
c_gps_lng, 
c_gps_acc, 
c_river_name, 
c_date, 
c_centre_sante,
c_distance_communaute,
c_population, 
c_nb_menages, 
c_recu_ivm, 
c_mois_dist, 
c_annee_dist, 
c_derniere_dist,
c_notes, 

c_start

FROM public.espen_gn_oncho_oem_202310_1_site_v3 c

