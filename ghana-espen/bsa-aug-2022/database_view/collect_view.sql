/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_tg_oncho_stop_2_participants_202209, v_espen_tg_oncho_stop_2_participants_202209
 */
create view v_espen_gn_oncho_bsc_1_capture_202208 as

SELECT 

c.id, 
s_transmission_zone, 
s_region, 
s_district, 
s_community, 
s_site, 
s_site_id, 
s_gps_lat, 
s_gps_lng, 
s_gps_acc, 
s_river, 
s_collector_a,
s_collector_b, 
s_date, 

c.time_interval,
c.nb_collected,
c.weather,
c.remark,

s_start


FROM public.espen_gn_oncho_bsc_1_capture_202208_s_ c, public.espen_gn_oncho_bsc_1_capture_202208 p
where c.parent_id = p.id::text 
