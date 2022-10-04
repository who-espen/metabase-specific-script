/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ng_oncho_prestop_1_site_202208, espen_ng_ng_oncho_prestop_1_site_202208_v2
 */
create view v_espen_ng_oncho_prestop_1_site_202208 as

SELECT 

id, 
meta_instance_id, 
c_recorder_id, 
c_region, 
c_district, 
c_cluster_name, 
c_cluster_id, 
c_supervisor, 
c_date, 
c_health_facility, 
c_type_health_facility, 
c_gps_lat, 
c_gps_lng, 
c_gps_alt, 
c_gps_acc, 
c_admin_level, 
c_river, 
c_distance_community, 
c_population, 
c_hh_number, 
c_receiving_ivm, 
c_lengh_period_ivm, 
c_month_dist, 
c_year_dist, 
c_last_dist, 
c_notes, 
c_start

FROM public.espen_ng_oncho_prestop_1_site_202208 c