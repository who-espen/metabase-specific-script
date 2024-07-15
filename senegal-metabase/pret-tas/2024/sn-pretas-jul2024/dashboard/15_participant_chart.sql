/*
 * File: 15_participant_chart.sql
 * File Created: Wednesday, 6th May 2020 11:01:22 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:06:00 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return the participant per sex
 * Variable to rename v_espen_sn_lf_pretas_2_partcipants_202307_v1_3
 */

select
    'Masculin' sexe,
    sum(male) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Masculin' then 1
                    else null
                end
            ) male
        FROM
            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 P
        GROUP BY
            p_district,
            p_cluster_id,
            p_cluster_name
    ) src
UNION
select
    'Féminin' sexe,
    sum(female) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Féminin' then 1
                    else null
                end
            ) female
        FROM
            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 P
        GROUP BY
            p_district,
            p_cluster_id,
            p_cluster_name
    ) src ------ Metabase filter -------
    -- [[and {{c_cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]