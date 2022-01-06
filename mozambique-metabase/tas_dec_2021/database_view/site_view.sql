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
 * Variable to rename  espen_mz_lf_tas2_2_participant_202111_v2_1, espen_mz_lf_tas1_2_participant_202011_v3
 */
CREATE OR REPLACE VIEW public.v_espen_mz_lf_tas2_1_site_202111_v2
AS SELECT c.id,
    c.c_recorder,
    c.c_eu,
    c.c_district,
    c.c_cluster_name,
    c.c_cluster_id,
    c.c_cluster_leader,
    c.c_consent,
    c.c_population,
    c.c_present,
    c.c_gps_lat,
    c.c_gps_lng,
    c.c_gps_alt,
    c.c_gps_acc,
    c.c_cluster_notes,
    c.c_start
   FROM espen_mz_lf_tas2_1_site_202111_v2 c;
