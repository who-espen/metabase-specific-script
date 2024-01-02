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
 * Variable to rename  espen_tg_oncho_stop_2_participants_202204, v_espen_tg_oncho_stop_2_participants_202204
 */

create view v_espen_ng_oncho_bsc_202304_1_capture 
as

SELECT 

s.id, 
c.s_region, 
c.s_district,
c.s_community, 
c.s_site, 
c.s_site_id, 
c.s_gps_lat, 
c.s_gps_lng, 
c.s_gps_acc,
c.s_river,
c.s_collector_a, 
c.s_collector_b, 
c.s_date, 

s.parent_id, 
s.add_fly,
s.time_interval, 
s.nb_collected, 
s.weather, 
s.remark,


c.created_at

FROM espen_ng_oncho_bsc_202304_1_capture c, espen_ng_oncho_bsc_202304_1_capture_s_ s

where s.parent_id = c.id::text

union all

SELECT 

s.id, 
c.s_region, 
c.s_district,
c.s_community, 
c.s_site, 
c.s_site_id, 
c.s_gps_lat, 
c.s_gps_lng, 
c.s_gps_acc,
c.s_river,
c.s_collector_a, 
c.s_collector_b, 
c.s_date, 

s.parent_id, 
s.add_fly,
s.time_interval, 
s.nb_collected, 
s.weather, 
s.remark,


c.created_at

FROM public.espen_ng_oncho_bsc_202304_1_capture_v2_gombe c, public.espen_ng_oncho_bsc_202304_1_capture_v2_gombe_s_ s

where s.parent_id = c.id::text;




