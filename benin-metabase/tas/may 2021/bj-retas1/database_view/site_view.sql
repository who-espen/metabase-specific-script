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
 * Variable to rename  v_espen_bj_lf_retas1_1_sites_202104_v3, espen_bj_lf_retas1_1_sites_202104_v3
 */
create view v_espen_bj_lf_retas1_1_sites_202104_v3 as
 SELECT c.id,
    c.c_recorder,
    c.c_eu_name,
    c.c_commune,
    c.c_cluster_name,
    c.c_cluster_id,
    c.c_cluster_leader_name,
    c.c_cluster_leader_contact,
    c.c_consent,
    c.c_population,
    c.c_present,
    c.c_absent,
    c.c_gps_lat,
    c.c_gps_lng,
    c.c_gps_acc,
    c.c_cluster_notes,
    c.c_start
   FROM espen_bj_lf_retas1_1_sites_202104_v3 c;
