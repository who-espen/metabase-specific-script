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
 * Variable to rename  v_espen_gw_oncho_202302_prestop_1_site_v1, espen_ng_ng_oncho_prestop_1_site_202302_v2
 */

create view v_espen_gw_oncho_202302_prestop_1_site_v1 as

select

distinct on (c_cluster_id)

id, 
c_recorder_id,
c_region, 
c_district,

case when c_cluster_name = 'Other' then c_cluster_name2 else c_cluster_name end c_cluster_name,

case when c_cluster_name = 'Other' then c_cluster_id2 else c_cluster_id end c_cluster_id,

c_date, 
c_gps_lat, 
c_gps_lng, 
c_gps_alt, 
c_gps_acc, 
c_population, 
c_black_fly, 
c_cluster_notes, 
c_start

FROM public.espen_gw_oncho_202302_prestop_1_site_v1 c


