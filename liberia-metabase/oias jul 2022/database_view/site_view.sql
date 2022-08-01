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
 * Variable to rename  v_espen_lr_oncho_ias_1_site_202112_v2_1, espen_ng_ng_oncho_oias_1_site_202207_v2
 */
create view v_espen_lr_oncho_ias_1_site_202112_v2_1 as
select

id, 
c_recorder_id_id, 
c_county,
c_district, 
c_site_name, 
c_site_id, 
c_gps_lat,
c_gps_lng, 
c_gps_acc,
c_notes, 
c_start

FROM public.espen_lr_oncho_ias_1_site_202112_v2_1 c
