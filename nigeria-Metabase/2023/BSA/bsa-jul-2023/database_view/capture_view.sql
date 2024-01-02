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

CREATE OR REPLACE VIEW v_espen_ng_oncho_bsc_202306_7_capture_bauchy AS 
SELECT c.id,
    p.s_region,
    p.s_district,
    p.s_community,
    p.s_village_type,
    p.s_site_id,
    p.s_gps_lat,
    p.s_gps_lng,
    p.s_gps_acc,
    p.s_river,
    p.s_river_type,
    p.s_collector_a,
    p.s_collector_b,
    p.s_date,
    c.parent_id,
    c.add_fly,
    c.time_interval,
    
    c.total_flight,
    c.s_dammnosum_caught,
    c.othe_flies_caught,
    
    c.weather,
    c.remark,
    p.created_at
   FROM public.espen_ng_oncho_bsc_202306_7_capture_bauchy p,
    espen_ng_oncho_bsc_202306_7_capture_bauchy_s_ c
  WHERE p.id = c.parent_id::integer