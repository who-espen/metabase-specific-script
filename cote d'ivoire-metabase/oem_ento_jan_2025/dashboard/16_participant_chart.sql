/*
 * File: 16_participant_chart.sql
 * File Created: Saturday, 2nd May 2020 3:43:01 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:45 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return the participant per sex
 * Variable to rename v_espen_bj_oncho_stop_2_202306_questions_v3
 */

select sum(male), sum(female)
FROM (
        SELECT
            p_district,
            p_cluster_id,
            p_cluster_name,
            COUNT(
                case
                    when p_sex = 'Male' then 1
                    else null
                end
            ) male,
            COUNT(
                case
                    when p_sex = 'Female' then 1
                    else null
                end
            ) female,
            p_date
        FROM
            v_espen_bj_oncho_stop_2_202306_questions_v3 P
        GROUP BY
            p_district,
            p_cluster_id,
            p_cluster_name,
            p_date
    ) src
WHERE
    p_date IS NOT NULL ------ Metabase filter -------
    -- [[and {{c_cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]