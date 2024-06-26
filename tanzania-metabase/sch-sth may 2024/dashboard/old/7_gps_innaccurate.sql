/*
 * File: 7_gps_innaccurate.sql
 * File Created: Tuesday, 12th May 2020 1:36:06 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:37:13 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename v_espen_tz_sch_sth_impact_2405_1_school
 */

SELECT 

w_recorder, w_district, w_school_id, w_school_name, w_gps_acc 

FROM
    v_espen_tz_sch_sth_impact_2405_1_school
WHERE w_gps_acc > 20

------ Metabase filter -------

-- [[and {{c_school_id}}]]

-- [[and {{cluster_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]