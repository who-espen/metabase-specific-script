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
 * Variable to rename  v_espen_tg_oncho_stop_1_site_202209, espen_tg_oncho_stop_1_site_202209
 */
create view v_espen_gn_oncho_bsc_2_bs_localisation_202208 as

select

id, 
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
s_young_larvae, 
s_old_larvae, 
s_pupae,
s_cocoon, 
s_other_species, 
s_river_rock, 
s_river_vegetation, 
s_start

FROM public.espen_gn_oncho_bsc_2_bs_localisation_202208 s
