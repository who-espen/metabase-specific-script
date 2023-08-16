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

create view v_espen_ng_oncho_bsc_202306_1_capture_v2_1 as

select 

c.id,
s_region,
s_district,
s_community,
s_village_type,
s_site_id,
s_gps_lat,
s_gps_lng,
s_gps_acc,
s_river,
s_river_type,
s_collector_a,
s_collector_b,
s_date,
c.parent_id,
c.add_fly,
c.time_interval,
c.nb_collected,
c.weather,
c.remark,
created_at

from public.espen_ng_oncho_bsc_202306_1_capture_v2_1 p, public.espen_ng_oncho_bsc_202306_1_capture_v2_1_s_ c 

where p.id = c.parent_id::int