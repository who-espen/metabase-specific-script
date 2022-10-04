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
create view v_espen_ng_oncho_bsc_1_capture_202208_v2 as
SELECT 

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

c.parent_id, 
c.add_fly, 
c.time_interval, 
c.nb_collected, 
c.weather, 
c.remark,

s_date

FROM public.espen_ng_oncho_bsc_1_capture_202208_v2_s_ c, public.espen_ng_oncho_bsc_1_capture_202208_v2 p
where c.parent_id = p.id::text 