/*
 * File: 12_school_map.sql
 * File Created: Tuesday, 12th May 2020 2:01:53 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 2:04:26 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename v_espen_cd_sch_sth_baseline_1_school_202202_v2_1
 */
SELECT

  w_region,
  w_zone_sante,
  w_aire_sante,
  w_village,
  w_gps_lat,
  w_gps_lng

FROM v_espen_cd_sch_sth_baseline_1_school_202202_v2_1
WHERE w_gps_lat IS NOT NULL
