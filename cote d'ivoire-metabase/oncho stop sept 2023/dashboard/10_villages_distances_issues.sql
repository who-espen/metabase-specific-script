/*
 * File: 10_villages_distances_issues.sql
 * File Created: Saturday, 2nd May 2020 11:13:12 am
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 11:44:07 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will will display the list of nearby villages less than <%village_dist_required%> KM
 * Variable to rename espen_civ_oncho_ia_202309_1_site_v4, <%village_dist_required%>
 */

SELECT 

calculate_distance(
    src.s_gps_lat,
    src.s_gps_lng,
    dest.s_gps_lat,
    dest.s_gps_lng,
    'K'
) "Distances in KM",
src.s_recorder_id "Recorder1 ID",
--  src.s_cluster_id "Cluster1 ID",
src.s_site "Cluster1 Name",
dest.s_recorder_id "Recorder2 ID",
-- dest.s_cluster_id "Cluster2 ID",
dest.s_site "Cluster2 Name",
src.s_gps_lat "Latitude1",
src.s_gps_lng "Longitude1",
dest.s_gps_lat "Latitude2",
dest.s_gps_lng "Longitude2"

FROM
    public.v_espen_civ_oncho_ia_202309_1_site_v4 src
    JOIN public.v_espen_civ_oncho_ia_202309_1_site_v4 dest on (
        SELECT
            calculate_distance(
                src.s_gps_lat,
                src.s_gps_lng,
                dest.s_gps_lat,
                dest.s_gps_lng,
                'K'
            ) < 5
            AND src.s_site <> dest.s_site
    )
order by "Distances in KM" desc