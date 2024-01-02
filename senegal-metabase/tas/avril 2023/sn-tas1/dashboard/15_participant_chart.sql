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
 * Variable to rename v_espen_sn_lf_tas3_20305_2_partcipants
 */

select
    'Masculin' sexe,
    sum(male) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Male' then 1
                    else null
                end
            ) male
        FROM
            public.v_espen_sn_lf_tas3_20305_2_partcipants P
        GROUP BY
            p_cluster_id,
            p_cluster_name,
            p_start
    ) src
UNION
select
    'Féminin' sexe,
    sum(female) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Female' then 1
                    else null
                end
            ) female
        FROM
            v_espen_sn_lf_tas3_20305_2_partcipants P
        GROUP BY
            p_cluster_id,
            p_cluster_name,
            p_start
    ) src 