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
 * Variable to rename  v_espen_lr_lf_tas1_1_site_202406_v1, espen_lr_lf_tas1_1_site_202406_v1
 */

create view v_espen_lr_lf_tas1_1_site_202406_v1 as

select

id, 
c_recorder,
c_date_visit,
c_county, 
c_eu, 
c_cluster_name,
c_cluster_id,
c_cluster_leader,
c_population,
c_eligib_pop, 
c_eligib_pop_present,
c_gps_lat,
c_gps_lng, 
c_gps_acc, 
c_comment, 
c_start

FROM public.espen_lr_lf_tas1_1_site_202406_v1 c
