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
 * Variable to rename  v_espen_bj_oncho_prestop_1_site, espen_bj_oncho_prestop_1_site
 */

create view v_espen_bj_oncho_prestop_1_site as
SELECT 


  id, 
  c_recorder_id, 
  c_region, 
  c_district, 
  c_cluster_name, 
  c_cluster_id, 
  c_cluster_type, 
  c_gps_lat, 
  c_gps_lng, 
  c_gps_alt, 
  c_gps_acc, 
  c_village_pop, 
  c_cluster_notes

FROM public.espen_bj_oncho_prestop_1_site c;

