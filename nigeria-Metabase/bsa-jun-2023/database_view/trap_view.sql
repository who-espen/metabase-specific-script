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
 * Variable to rename  v_espen_tg_oncho_stop_1_site_202204, espen_tg_oncho_stop_1_site_202204
 */
 create view v_espen_ng_oncho_bsc_202306_2_traps_v2_1 as

select 

c.id
c_region,
c_district,
c_community,
c_village_type,
c_site_id,
c_gps_lat,
c_gps_lng,
c_gps_acc,
c_river,
c_river_type,
c_date,
c_trap_id,
c_old_larvae,
parent_id,
c.time_interval,
c.nb_simulium_damnosum_sl_collected,
c.weather,
c.remark,
created_at


from public.espen_ng_oncho_bsc_202306_2_traps_v2_1 p, public.espen_ng_oncho_bsc_202306_2_traps_v2_1_c_ c 

where p.id = c.parent_id::int