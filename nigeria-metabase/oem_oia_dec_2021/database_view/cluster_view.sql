/*
 * File: cluster_view.sql
 * File Created: Wednesday, 22nd April 2020 2:51:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 9:57:12 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  <%v_ab_cde_fgh_1_cluster%>, v_espen_ng_oncho_oem_1_site_202112_v2_2
 */

CREATE OR REPLACE VIEW public.v_espen_ng_oncho_oem_1_site_202112_v2_2
AS SELECT c.id,
    c.c_recorder_id,
    c.c_region,
    c.c_district,
    c.c_cluster_name,
    c.c_cluster_id,
    c.c_supervisor,
    c.c_date,
    c.c_health_facility,
    c.c_type_health_facility,
    c.c_gps_lat,
    c.c_gps_lng,
    c.c_gps_alt,
    c.c_gps_acc,
    c.c_admin_level,
    c.c_river,
    c.c_distance_community,
    c.c_population,
    c.c_hh_number,
    c.c_receiving_ivm,
    c.c_lengh_period_ivm,
    c.c_month_dist,
    c.c_year_dist,
    c.c_last_dist,
    c.c_notes,
    c.c_start
   FROM espen_ng_oncho_oem_1_site_202112_v2_2 c;