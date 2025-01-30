/*
 * File: participant_per_village.sql
 * File Created: Tuesday, 12th May 2020 6:08:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 6:09:15 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participant per district by the total population
 * Variable to rename v_espen_bf_202403_sch_ia_2_enrolement, v_espen_bf_202403_sch_ia_1_sites
 */

SELECT
    w_district "District",
    w_school_id "School ID",
    w_school_name "Village",
    COUNT(p.id) "Enrolled",
    COUNT(
        CASE
            WHEN p_sex = 'Male' THEN 1
            ELSE NULL
        END
    ) "Male",
    COUNT(
        CASE
            WHEN p_sex = 'Female' THEN 1
            ELSE NULL
        END
    ) "Female"
FROM
    v_espen_bf_202403_sch_ia_2_enrolement p
    LEFT JOIN v_espen_bf_202403_sch_ia_1_sites w on w.w_school_id = p.p_school_id
where p.p_date > CURRENT_DATE - 1