/*
 * File: 15_participant_per_district.sql
 * File Created: Tuesday, 12th May 2020 2:29:36 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 2:44:52 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participant per EU by the total population
 * Variable to rename v_espen_lr_sch_sth_impact_202401_2_child_v2_1, v_espen_lr_sch_sth_impact_202401_1_school_v2
 */

SELECT 

w_district "Council",
w_school_id "School ID",
w_school_name "School",
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
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 p
    LEFT JOIN v_espen_lr_sch_sth_impact_202401_1_school_v2 w on w.w_school_id = p.p_school_id

WHERE p.id IS NOT NULL 

------ Metabase filter -------

-- [[and {{c_school_id}}]]

-- [[and {{school_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]

GROUP BY w_school_id, w_school_name, w_district 